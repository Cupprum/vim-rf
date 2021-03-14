*** Settings ***
Library                 Collections
Library                 RequestsLibrary
Library                 ./resources/python_keywords.py
Resource                ./resources/robot_keywords.robot
Resource                ./resources/suite.robot
Suite Setup             Run Keywords    Get Token
...                     AND             Delete Clients
Suite Teardown          Run Keywords    Delete Clients

*** Variables ***
${BASE_URL}             %{TEST_BASE_URL}
${protocol}=            openid-connect

*** Test Cases ***
Add Client Owners Success
    Set Test Variable   ${name}     client
    Create Client       ${name}     ${protocol}    ${USER1_BASE64}

    Create Session      idp-api     ${BASE_URL}
    Set Test Variable   &{headers}  Authorization=Basic ${USER1_BASE64}  Accept=application/json  Content-Type=application/json
        
    ${data}=            Catenate  SEPARATOR=
    ...                     {
    ...                         "owners": [
    ...                             "janko-mrkvicka",
    ...                             "john-doe"
    ...                         ]
    ...                     }
    ${resp}=            Post Request  idp-api  uri=api/v2/client/test_${name}_${protocol}_clientId/owners  headers=${headers}  data=${data}
    Status Should Be    201               ${resp}
    ${resp}=            To json           ${resp.content}

    Length Should Be    ${resp}[owners]   3
    Should Contain      ${resp}[owners]   %{TEST_USER_NAME1}     janko-mrkvicka    john-doe

    ${resp}=            Get Request  idp-api  uri=api/v2/client/test_${name}_${protocol}_clientId  headers=${headers}
    Status Should Be    200                             ${resp}
    ${resp}=            To json                         ${resp.content}
    Length Should Be    ${resp}[description][owners]    3
    Should Contain      ${resp}[description][owners]    %{TEST_USER_NAME1}     janko-mrkvicka    john-doe

    Remove Client       ${name}     ${protocol}    ${USER1_BASE64}

Add Client Owners Authentication Error
    Set Test Variable   ${name}     client
    Create Client       ${name}     ${protocol}    ${USER1_BASE64}

    Create Session      idp-api     ${BASE_URL}
    Set Test Variable   &{headers}  Authorization=Basic  Accept=application/json  Content-Type=application/json
        
    ${data}=            Catenate  SEPARATOR=
    ...                     {
    ...                         "owners": [
    ...                             "janko-mrkvicka",
    ...                             "john-doe"
    ...                         ]
    ...                     }
    ${resp}=            Post Request  idp-api  uri=api/v2/client/test_${name}_${protocol}_clientId/owners  headers=${headers}  data=${data}
    Status Should Be    401         ${resp}
    
    Remove Client       ${name}     ${protocol}    ${USER1_BASE64}

Add Client Owners Authorization Error
    Set Test Variable   ${name}     client
    Create Client       ${name}     ${protocol}    ${USER1_BASE64}

    Create Session      idp-api         ${BASE_URL}
    Set Test Variable   &{headers}  Authorization=Basic ${USER2_BASE64}  Accept=application/json  Content-Type=application/json
        
    ${data}=            Catenate  SEPARATOR=
    ...                     {
    ...                         "owners": [
    ...                             "janko-mrkvicka",
    ...                             "john-doe"
    ...                         ]
    ...                     }
    ${resp}=            Post Request  idp-api  uri=api/v2/client/test_${name}_${protocol}_clientId/owners  headers=${headers}  data=${data}
    Status Should Be    404         ${resp}
    
    Remove Client       ${name}     ${protocol}    ${USER1_BASE64}



