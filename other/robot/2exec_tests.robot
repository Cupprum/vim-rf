*** Settings ***
Library               Collections
Library               RequestsLibrary

Suite Setup           Create Session    jsonplaceholder    https://jsonplaceholder.typicode.com

*** Keywords ***
Input Name
   [Arguments]      ${name}
   Input Text       ${INPUT_NAME_FIELD} ${name}
   Hide Keyboard
Select Option
   [Arguments]      ${option}
   Click Element    xpath = //*[contains(@text, '${option}')]

*** Test Cases ***

Get Request Test
    Create Session    google             http://www.google.com

    ${resp_google}=   GET On Session     google             /           expected_status=200
    ${resp_json}=     GET On Session     jsonplaceholder    /posts/1

    Should Be Equal As Strings           ${resp_google.reason}    OK
    Dictionary Should Contain Value      ${resp_json.json()}    sunt aut facere repellat provident occaecati excepturi optio reprehenderit

Post Request Test
    &{data}=          Create dictionary  title=Robotframework requests  body=This is a test!  userId=1
    ${resp}=          POST On Session    jsonplaceholder     /posts    json=${data}
    
    Status Should Be                     201    ${resp}
    Dictionary Should Contain Key        ${resp.json()}     id
