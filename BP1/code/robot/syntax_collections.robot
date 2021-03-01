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
${TEST_VARIABLE}             %{testvariable}

*** Test Cases ***
Add Client Owners Success
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
