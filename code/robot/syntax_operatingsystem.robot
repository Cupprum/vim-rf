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
