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
    Add Time To Date 
    Add Time To Time 
    Convert Date 
    Convert Time 
    Get Current Date 
    Subtract Date From Date 
    Subtract Time From Date 
    Subtract Time From Time
