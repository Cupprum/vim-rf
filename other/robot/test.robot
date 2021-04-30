*** Settings ***
Resource                1exec_tests.robot

*** Test Cases ***
Test Testcase
   [Tags] cloud
   Set Up And Open Android Application
   Input Name ${NAME}
   Select Option Use Testdroid Cloud
   Submit Selection
   Validate Correct Answer
