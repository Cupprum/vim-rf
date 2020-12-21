from .connector import Connector
from .objects import User, Org, Manager
from . import custom_errors as err
import concurrent.futures
import os
import jinja2
import requests
import json
import re


class Idm(Connector):
    def __init__(self, logger_name, requests_config, config):
        super().__init__(logger_name)
        self.requests_config = requests_config
        self.config = config
        self.config['hostname'] = os.environ['idm_hostname']
        self.config['name'] = os.environ['idm_admin_name']
        self.config['pass'] = os.environ['idm_admin_pass']

        self.headers = {
            "Content-Type": "application/xml",
            "Accept": "application/json"
        }

        self.auth = (
            self.config['name'],
            self.config['pass']
        )

    def connect(self):
        try:
            self._connect()
        except Exception as e:
            self.logger.error(e)
            raise err.InitError("Idm init failed")

    def _connect(self):
        url = f"{self.config['hostname']}/{self.config['health_path']}"

        try:
            resp = requests.get(
                url,
                verify=self.requests_config['crt_path'],
                timeout=self.requests_config['timeout']
            )
        except requests.exceptions.Timeout as e:
            self.logger.error(e)
            raise err.IdmError("request timeout")
        except requests.exceptions.RequestException as e:
            self.logger.error(e)
            raise err.IdmError("request failed")
        except Exception as e:
            self.logger.error(e)
            raise Exception("unknown error")

        try:
            resp_content = json.loads(resp.content)['status']
        except json.JSONDecodeError as e:
            self.logger.error(e)
            raise err.IdmError("json decode error")
        except KeyError as e:
            self.logger.error(e)
            raise err.IdmError("missing data error")
        except TypeError as e:
            self.logger.error(e)
            raise err.IdmError("invalid data type")
        except Exception as e:
            self.logger.error(e)
            raise Exception("unknown error")

        if resp_content != "UP":
            raise err.IdmError("Midpoint Not UP")

    def _get_xml(self, file_name):
        idm_templates_dir, _ = os.path.split(__file__)
        idm_templates_dir = os.path.join(idm_templates_dir, "idm_templates")

        template_loader = jinja2.FileSystemLoader(
            searchpath=idm_templates_dir)

        template_env = jinja2.Environment(loader=template_loader)
        template = template_env.get_template(file_name)
        return template

    def _get_users_xml(self, offset, maxSize):
        template_file = "query-users.xml.j2"

        return(self._get_xml(template_file).render(offset=offset,
                                                   maxSize=maxSize))

    def _get_org_xml(self):
        template_file = "query-orgs.xml.j2"

        return(self._get_xml(template_file).render())

    def _get_managers_xml(self, oid):
        template_file = "query-managers.xml.j2"

        return(self._get_xml(template_file).render(oid=oid))

    def _get_batch_of_users_request(self,
                                    offset,
                                    url,
                                    params):
        try:
            return requests.post(
                url,
                headers=self.headers,
                auth=self.auth,
                data=self._get_users_xml(offset, self.config['max_page_size']),
                params=params,
                verify=self.requests_config['crt_path'],
                timeout=self.requests_config['timeout']
            )
        except requests.exceptions.Timeout as e:
            self.logger.error(e)
            raise err.IdmGetUsersError("request timeout")
        except requests.exceptions.RequestException as e:
            self.logger.error(e)
            raise err.IdmGetUsersError("request failed")
        except Exception as e:
            self.logger.error(e)
            raise Exception("unknown error")

    def _get_batch_of_users_decode(self, resp):
        try:
            return json.loads(resp.content)['object']['object']
        except json.JSONDecodeError as e:
            self.logger.error(e)
            raise err.IdmGetUsersError("json decode error")
        except KeyError:
            raise err.IdmGetUsersMissing("missing audit data")
        except TypeError as e:
            self.logger.error(e)
            raise err.IdmGetUsersError("invalid audit data type")
        except Exception as e:
            self.logger.error(e)
            raise Exception("unknown error")

    def _parse_user(self, invalid_users, raw_user):
        try:
            if raw_user['name']:
                user = User(raw_user['name'])
            else:
                raise ValueError("name")
        except (ValueError, KeyError):
            user = User("")
            user.problems['name'].append(str(raw_user))
            invalid_users.append(user)
            raise err.IdmGetUsersMissing("get users -> missing name")
        except Exception as e:
            raise e

        try:
            user.first_name = raw_user['givenName']
            user.last_name = raw_user['familyName']

            if not user.first_name or not user.last_name:
                raise ValueError("real name")
        except (ValueError, KeyError) as e:
            if user in invalid_users:
                index = invalid_users.index(user)
                user.problems = invalid_users[index].problems

                invalid_users.pop(index)

            user.problems['real_name'].append(e)
            invalid_users.append(user)

            raise err.IdmGetUsersMissing(f"{user.name} -> missing real name")
        except Exception as e:
            raise e

        try:
            user.create_timestamp = raw_user['metadata']['createTimestamp']

            if not user.create_timestamp:
                raise ValueError("missing createTimestamp")
        except (ValueError, KeyError) as e:
            if user in invalid_users:
                index = invalid_users.index(user)
                user.problems = invalid_users[index].problems

                invalid_users.pop(index)

            user.problems['create_timestamp'].append(e)
            invalid_users.append(user)

            raise err.IdmGetUsersMissing(f"{user.name} -> missing " +
                                         "createTimestamp")
        except Exception as e:
            raise e

        try:
            if raw_user['organizationalUnit'] is None:
                raise ValueError("missing org unit")
            elif type(raw_user['organizationalUnit']) is list:
                user.org_units.extend(
                    raw_user['organizationalUnit'])
            elif type(raw_user['organizationalUnit']) is str:
                user.org_units.append(
                    raw_user['organizationalUnit'])
            else:
                raise TypeError
        except (ValueError, KeyError) as e:
            if user in invalid_users:
                index = invalid_users.index(user)
                user.problems = invalid_users[index].problems

                invalid_users.pop(index)

            user.problems['org_units'].append(e)
            invalid_users.append(user)

            raise err.IdmGetUsersMissing(f"{user.name} -> missing org unit")
        except TypeError:
            e = err.IdmGetUsersMissing("wrong format of org units")

            if user in invalid_users:
                index = invalid_users.index(user)
                user.problems = invalid_users[index].problems

                invalid_users.pop(index)

            user.problems['org_units'].append(e)
            invalid_users.append(user)

            raise err.IdmGetUsersMissing(f"{user.name} -> wrong format of " +
                                         "org unit")
        except Exception as e:
            raise e

        return user

    def get_users(self, invalid_users, users):
        url = f"{self.config['hostname']}/{self.config['users_path']}"

        params = {
            "exclude": "subtype"
        }

        offset = 0
        maxSize = self.config['max_page_size']

        while True:
            try:
                resp = self._get_batch_of_users_request(offset,
                                                        url,
                                                        params)
            except Exception as e:
                raise e

            try:
                raw_users = self._get_batch_of_users_decode(resp)
            except err.IdmGetUsersMissing:
                break
            except Exception as e:
                raise e

            offset += maxSize

            for raw_user in raw_users:
                try:
                    user = self._parse_user(invalid_users, raw_user)
                except err.IdmGetUsersMissing as e:
                    self.logger.warning(e)
                    continue
                except Exception as e:
                    self.logger.error(e)
                    raise Exception("unknown error")

                try:
                    if re.search(self.config['user_regex_format'], user.name) \
                            and user not in users:
                        users.append(user)
                except Exception as e:
                    self.logger.error(e)
                    raise Exception("unknown error")

            if len(raw_users) != maxSize:
                break

    def _get_org_unit_names(self, users, org_units):
        for user in users:
            for org_unit_name in user.org_units:
                potential_org_unit = Org(org_unit_name)
                if potential_org_unit not in org_units:
                    potential_org_unit.users.append(user)
                    org_units.append(potential_org_unit)
                else:
                    index = org_units.index(potential_org_unit)
                    org_units[index].users.append(user)

    def _get_org_unit_oids_request(self):
        url = f"{self.config['hostname']}/{self.config['orgs_path']}"

        data = self._get_org_xml()

        params = ([
            ("exclude", "version"),
            ("exclude", "parentOrgRef"),
            ("exclude", "metadata"),
            ("exclude", "operationExecution"),
            ("exclude", "assignment")
        ])

        try:
            return requests.post(
                url,
                headers=self.headers,
                auth=self.auth,
                data=data,
                params=params,
                verify=self.requests_config['crt_path']
            )
        except requests.exceptions.Timeout as e:
            self.logger.error(e)
            raise err.IdmGetOrgsError("request timeout")
        except requests.exceptions.RequestException as e:
            self.logger.error(e)
            raise err.IdmGetOrgsError("request failed")
        except Exception as e:
            self.logger.error(e)
            raise Exception("unknown error")

    def _get_org_unit_oids_decode(self, org_units, resp):
        try:
            resp_content = json.loads(resp.content)

            for org_unit_resp in resp_content['object']['object']:
                try:
                    index = org_units.index(Org(org_unit_resp['name']))
                    org_units[index].oid = org_unit_resp['oid']
                except ValueError:
                    continue

        except json.JSONDecodeError as e:
            self.logger.error(e)
            raise err.IdmGetOrgsError("json decode error")
        except KeyError as e:
            self.logger.error(e)
            raise err.IdmGetOrgsError("missing data error")
        except TypeError as e:
            self.logger.error(e)
            raise err.IdmGetOrgsError("invalid data type")
        except Exception as e:
            self.logger.error(e)
            raise Exception("unknown error")

    def _get_managers_request(self, org_unit):
        url = f"{self.config['hostname']}/{self.config['users_path']}"

        data = self._get_managers_xml(org_unit.oid)

        params = {
            "exclude": "subtype"
        }

        try:
            resp = requests.post(
                url,
                headers=self.headers,
                auth=self.auth,
                data=data,
                params=params,
                verify=self.requests_config['crt_path']
            )
        except requests.exceptions.Timeout as e:
            self.logger.error(e)
            raise err.IdmGetManagersError("request timetout")
        except requests.exceptions.RequestException as e:
            self.logger.error(e)
            raise err.IdmGetManagersError("request failed")
        except Exception as e:
            self.logger.error(e)
            raise Exception("unknown error")

        return org_unit, resp

    def _get_managers_decode(self, org_unit: Org, resp):
        try:
            return json.loads(
                resp.content)['object']['object']
        except json.JSONDecodeError as e:
            self.logger.error(e)
            raise err.IdmGetManagersError("json decode error")
        except KeyError:
            raise err.IdmGetManagersMissing(f"{org_unit.name} -> " +
                                            "missing managers")
        except TypeError as e:
            self.logger.error(e)
            raise err.IdmGetManagersError("invalid manager data type")
        except Exception as e:
            self.logger.error(e)
            raise Exception("unknown error")

    def _parse_manager(self, invalid_managers, raw_manager):
        try:
            if raw_manager['name']:
                manager = Manager(raw_manager['name'])
            else:
                raise ValueError("name")
        except (ValueError, KeyError):
            manager = Manager("")
            manager.problems['name'].append(str(raw_manager))
            invalid_managers.append(manager)

            raise err.IdmGetManagersMissing("get manager -> missing user name",
                                            raw_manager)

        try:
            if raw_manager['givenName'] and raw_manager['familyName']:
                manager.first_name = raw_manager['givenName']
                manager.last_name = raw_manager['familyName']
            else:
                raise ValueError("real name")
        except (ValueError, KeyError) as e:
            manager.first_name = "Unknown"
            manager.last_name = "User"

            manager.problems['real_name'].append(e)
            invalid_managers.append(manager)

            raise err.IdmGetManagersMissing(f"{manager.name} " +
                                            "manager -> first or last name" +
                                            " missing")

        try:
            if raw_manager['emailAddress']:
                manager.mail = raw_manager['emailAddress']
            else:
                raise ValueError("mail")
        except (ValueError, KeyError) as e:
            if manager in invalid_managers:
                index = invalid_managers.index(manager)
                manager.problems = invalid_managers[index].problems

                invalid_managers.pop(index)

            manager.problems['mail'].append(e)
            invalid_managers.append(manager)

            raise err.IdmGetManagersMissing(f"{manager.name} " +
                                            "manager -> mail missing")

        return manager

    def get_org_units(self, invalid_managers, users, org_units):
        self._get_org_unit_names(users, org_units)

        try:
            resp = self._get_org_unit_oids_request()
            self._get_org_unit_oids_decode(org_units, resp)
        except Exception as e:
            raise e

        with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
            futures = {executor.submit(self._get_managers_request, org_unit):
                       org_unit for org_unit in org_units}

            for future in concurrent.futures.as_completed(futures):
                try:
                    org_unit, resp = future.result()
                    resp_content = self._get_managers_decode(
                        org_unit,
                        resp
                    )
                except err.IdmError as e:
                    self.logger.warning(e)
                    continue
                except Exception as e:
                    raise e

                if not resp_content:
                    raise err.IdmGetManagersMissing(
                        f"{org_unit.name} -> no org data"
                    )

                for raw_manager in resp_content:
                    try:
                        potentional_manager = self._parse_manager(
                            invalid_managers,
                            raw_manager
                        )
                    except err.IdmGetManagersMissing as e:
                        self.logger.warning(e)
                        continue

                    if potentional_manager not in org_unit.managers:
                        org_unit.managers.append(potentional_manager)

                self.logger.info(
                    f"{org_unit.name} -> success"
                )
