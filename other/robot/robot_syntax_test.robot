*** Settings ***
Library                 Collections
Resource	            Collections
Variables	            Collections
Documentation	        Collections
Metadata	            Collections
Suite Setup	            Collections
Suite Teardown	        Collections
Force Tags	            Collections
Default Tags	        Collections
Test Setup	            Collections
Test Teardown	        Collections
Test Template	        Collections
Test Timeout	        Collections
Task Setup              Run Keywords   Test1 
...                     AND            Test2
Task Teardown           Collections
Task Template           Collections
Task Timeout            Collections

*** Variables ***
${BASE_URL}             %{TEST_BASE_URL}
${protocol}=            openid-connect
${VARIABLE_1}           VALUE1
${VARIABLE_2}           VALUE2

*** Keywords ***
Get Request Test
	[Arguments]		  ${name}
    Create Session    google             http://www.google.com

    ${resp_google}=   GET On Session     google             /           expected_status=200
    ${resp_json}=     GET On Session     jsonplaceholder    /posts/1

    Should Be Equal As Strings           ${resp_google.reason}    OK
    Dictionary Should Contain Value      ${resp_json.json()}    sunt aut facere repellat provident occaecati excepturi optio reprehenderit

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

# Standart Library
Syntax Buildin
    Call Method 
    Catenate 
    Comment 
    Continue For Loop 
    Continue For Loop If 
    Convert To Binary 
    Convert To Boolean 
    Convert To Bytes 
    Convert To Hex 
    Convert To Integer 
    Convert To Number 
    Convert To Octal 
    Convert To String 
    Create Dictionary 
    Create List 
    Evaluate 
    Exit For Loop 
    Exit For Loop If 
    Fail 
    Fatal Error 
    Get Count 
    Get Length 
    Get Library Instance 
    Get Time 
    Get Variable Value 
    Get Variables 
    Import Library 
    Import Resource 
    Import Variables 
    Keyword Should Exist 
    Length Should Be 
    Log 
    Log Many 
    Log To Console 
    Log Variables 
    No Operation 
    Pass Execution 
    Pass Execution If 
    Regexp Escape 
    Reload Library 
    Remove Tags 
    Repeat Keyword 
    Replace Variables 
    Return From Keyword 
    Return From Keyword If 
    Run Keyword 
    Run Keyword And Continue On Failure 
    Run Keyword And Expect Error 
    Run Keyword And Ignore Error 
    Run Keyword And Return 
    Run Keyword And Return If 
    Run Keyword And Return Status 
    Run Keyword If 
    Run Keyword If All Critical Tests Passed 
    Run Keyword If All Tests Passed 
    Run Keyword If Any Critical Tests Failed 
    Run Keyword If Any Tests Failed 
    Run Keyword If Test Failed 
    Run Keyword If Test Passed 
    Run Keyword If Timeout Occurred 
    Run Keyword Unless 
    Run Keywords 
    Set Global Variable 
    Set Library Search Order 
    Set Local Variable 
    Set Log Level 
    Set Suite Documentation 
    Set Suite Metadata 
    Set Suite Variable 
    Set Tags 
    Set Task Variable 
    Set Test Documentation 
    Set Test Message 
    Set Test Variable 
    Set Variable 
    Set Variable If 
    Should Be Empty 
    Should Be Equal 
    Should Be Equal As Integers 
    Should Be Equal As Numbers 
    Should Be Equal As Strings 
    Should Be True 
    Should Contain 
    Should Contain Any 
    Should Contain X Times 
    Should End With 
    Should Match 
    Should Match Regexp 
    Should Not Be Empty 
    Should Not Be Equal 
    Should Not Be Equal As Integers 
    Should Not Be Equal As Numbers 
    Should Not Be Equal As Strings 
    Should Not Be True 
    Should Not Contain 
    Should Not Contain Any 
    Should Not End With 
    Should Not Match 
    Should Not Match Regexp 
    Should Not Start With 
    Should Start With 
    Sleep 
    Variable Should Exist 
    Variable Should Not Exist 
    Wait Until Keyword Succeeds

Syntax Collections
    Append To List 
    Combine Lists 
    Convert To Dictionary 
    Convert To List 
    Copy Dictionary 
    Copy List 
    Count Values In List 
    Dictionaries Should Be Equal 
    Dictionary Should Contain Item 
    Dictionary Should Contain Key 
    Dictionary Should Contain Sub Dictionary 
    Dictionary Should Contain Value 
    Dictionary Should Not Contain Key 
    Dictionary Should Not Contain Value 
    Get Dictionary Items 
    Get Dictionary Keys 
    Get Dictionary Values 
    Get From Dictionary 
    Get From List 
    Get Index From List 
    Get Match Count 
    Get Matches 
    Get Slice From List 
    Insert Into List 
    Keep In Dictionary 
    List Should Contain Sub List 
    List Should Contain Value 
    List Should Not Contain Duplicates 
    List Should Not Contain Value 
    Lists Should Be Equal 
    Log Dictionary 
    Log List 
    Pop From Dictionary 
    Remove Duplicates 
    Remove From Dictionary 
    Remove From List 
    Remove Values From List 
    Reverse List 
    Set List Value 
    Set To Dictionary 
    Should Contain Match 
    Should Not Contain Match 
    Sort List

Syntax Datetime
    Add Time To Date 
    Add Time To Time 
    Convert Date 
    Convert Time 
    Get Current Date 
    Subtract Date From Date 
    Subtract Time From Date 
    Subtract Time From Time

Syntax Dialogs
    Execute Manual Step 
    Get Selection From User 
    Get Selections From User 
    Get Value From User 
    Pause Execution

Syntax Operating System
    Append To Environment Variable 
    Append To File 
    Copy Directory 
    Copy File 
    Copy Files 
    Count Directories In Directory 
    Count Files In Directory 
    Count Items In Directory 
    Create Binary File 
    Create Directory 
    Create File 
    Directory Should Be Empty 
    Directory Should Exist 
    Directory Should Not Be Empty 
    Directory Should Not Exist 
    Empty Directory 
    Environment Variable Should Be Set 
    Environment Variable Should Not Be Set 
    File Should Be Empty 
    File Should Exist 
    File Should Not Be Empty 
    File Should Not Exist 
    Get Binary File 
    Get Environment Variable 
    Get Environment Variables 
    Get File 
    Get File Size 
    Get Modified Time 
    Grep File 
    Join Path 
    Join Paths 
    List Directories In Directory 
    List Directory 
    List Files In Directory 
    Log Environment Variables 
    Log File 
    Move Directory 
    Move File 
    Move Files 
    Normalize Path 
    Remove Directory 
    Remove Environment Variable 
    Remove File 
    Remove Files 
    Run 
    Run And Return Rc 
    Run And Return Rc And Output 
    Set Environment Variable 
    Set Modified Time 
    Should Exist 
    Should Not Exist 
    Split Extension 
    Split Path 
    Touch 
    Wait Until Created 
    Wait Until Removed

Syntax Process
    Get Process Id 
    Get Process Object 
    Get Process Result 
    Is Process Running 
    Join Command Line 
    Process Should Be Running 
    Process Should Be Stopped 
    Run Process 
    Send Signal To Process 
    Split Command Line 
    Start Process 
    Switch Process 
    Terminate All Processes 
    Terminate Process 
    Wait For Process

Syntax Screenshot
    Set Screenshot Directory 
    Take Screenshot 
    Take Screenshot Without Embedding
