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
