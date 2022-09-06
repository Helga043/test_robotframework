*** Settings ***
Library             SeleniumLibrary
Documentation       Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}          Chrome
${SIGNINBUTTON}     //*[@type='submit']/span[1]
${EMAILINPUT}       //*[@id='login']
${PASSWORDINPUT}    //*[@id='password']
${PAGELOGODASH}     //div[contains(@class, 'MuiToolbar-root')]
${PAGELOGOLOGIN}    //*[@id='__next']/form/div/div[1]/h5
${INVALIDDATAMESSAGE}        xpath=//span[contains(@class, 'MuiTypography-root')]
${SIGNOUTBUTTON}    //*[text()='Sign out']
${ADDPLAYERBUTTON}  //*[text()='Add player']
${PLAYERNAME}       //input[@name = 'name']
${PLAYERSURNAME}    //input[@name = 'surname']
${PLAYERAGE}        //input[@name = 'age']
${PLAYERLEG}        //*[@id='mui-component-select-leg']
${PLAYERLEFTLEG}    //li[@data-value='left']
${PLAYERPOSITION}   //input[@name='mainPosition']
${SUBMITBUTTON}     //button[@type='submit']/span[1]
${NEWPLAYER}        xpath=//ul[2]/div[1]/div/span[contains(text(),'James Bond')]
${TEST}             //*[@id="__next"]/div[1]/div/div/div/ul[2]/div[1]/div[2]/span
${LANGUAGEBUTTON}   //ul[2]/div[1]/div[2]/span

*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
    [Teardown]    close browser

Invalid data
    Open login page
    Type invalid login
    Type invalid password
    Click on the submit button
    Assert login page
#    Assert invalid data message
    [Teardown]    close browser
Empty password
    Open login page
    Type in email
    Type empty password
    Click on the submit button
    Assert login page
    [Teardown]    close browser
Login out
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
    Click on the sign out button
    Assert login page
    [Teardown]    close browser
Add player
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
    Click on the add player button
    Type player name
    Type player surname
    Select player age
    Choose leg
    Type main position
    Click submit
    Assert new player in menu
    [Teardown]    close browser
Change language
    Open login page
    Type in email
    Type in password
    Click on the submit button
    Assert dashboard
    Click language button
    Assert dashboard
    [Teardown]    close browser



*** Keywords ***
Open login page
    Open browser        ${LOGIN URL}    ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    Input Text   ${EMAILINPUT}   user01@getnada.com
Type in password
    Input text  ${PASSWORDINPUT}    Test-1234
Click on the submit button
    Click element   ${SIGNINBUTTON}
Assert dashboard
    wait until element is visible   ${PAGELOGODASH}
    title should be                 Scouts panel
    capture page screenshot         alert.png
Type invalid login
    input text    ${EMAILINPUT}     login
Type invalid password
    input text    ${PASSWORDINPUT}  Pass123
Assert login page
    wait until element is visible   ${PAGELOGOLOGIN}
    title should be                 Scouts panel - sign in
    capture page screenshot         alert2.png
#Assert invalid data message
#    wait until element is visible    ${INVALIDDATAMESSAGE}
#    element text should be           Invalid Login or Password
#    capture page screenshot          alert3.png
Type empty password
    input text    ${PASSWORDINPUT}  ${EMPTY}
Click on the sign out button
    click element   ${SIGNOUTBUTTON}
Click on the add player button
    click element    ${ADDPLAYERBUTTON}
Type player name
    input text    ${PLAYERNAME}     James
Type player surname
    input text    ${PLAYERSURNAME}  Bond
Select player age
    input text    ${PLAYERAGE}      11/11/1920
Choose leg
    click element    ${PLAYERLEG}
    click element    ${PLAYERLEFTLEG}
Type main position
    input text    ${PLAYERPOSITION}     captain
Click submit
    click element    ${SUBMITBUTTON}
Assert new player in menu
    wait until element is visible    ${TEST}
#    wait until element is visible    ${NEWPLAYER}
#    element text should be    ${NEWPLAYER}  James Bond
    capture page screenshot    alert4.png
Click language button
    click element    ${LANGUAGEBUTTON}
