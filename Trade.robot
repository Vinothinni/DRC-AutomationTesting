
*** Settings ***
Library    SeleniumLibrary

Library    BuiltIn
*** Variables ***
${BROWSER}          chrome
${URL}              https://commoncents.vercel.app/    
${USERNAME}   commoncents@gmail.com
${PASSWORD}   Testing123.
${InvalidPassword}   @#kjul12
${MAIN_TITLE}    //*[@class="banner-title"][1]
${LOGIN_BUTTON}    //*[@class="MuiTypography-root MuiTypography-body1 navbar-login-btn css-9l3uo3"]
${LOGIN_POPUP}    //*[@class="auth-modal-box"]
${USERNAME_INPUT}    (//*[@class="MuiInputBase-input MuiOutlinedInput-input css-1x5jdmq"])[1]
${PASSWORD_INPUT}    //*[@class="MuiInputBase-input MuiOutlinedInput-input MuiInputBase-inputAdornedEnd css-1uvydh2"]
${EYE_ICON}    //*[@class="MuiButtonBase-root MuiIconButton-root MuiIconButton-edgeEnd MuiIconButton-sizeMedium css-slyssw"]
${LOGIN_BUTTON2}    (//*[text()="Login"])[3]
${PROFILE_ICON}    //*[@class="navbar-balance MuiBox-root css-0"]
${TRADE_HEADER}    (//*[@class="MuiTypography-root MuiTypography-body1 navbar-item css-9l3uo3"])[1]
${TRADE_BUY_FIELDS}    (//*[@class="MuiBox-root css-0"])[2]
${MARKET_TYPE_DROPDOWN}    (//*[@class="MuiSelect-select MuiSelect-outlined MuiInputBase-input MuiOutlinedInput-input css-qiwgdb"])[1]
${MARKET_TYPE}    //*[@class="MuiButtonBase-root MuiMenuItem-root MuiMenuItem-gutters Mui-selected MuiMenuItem-root MuiMenuItem-gutters Mui-selected css-1km1ehz"]
${CHART}    //*[@class="highcharts-background"]
${CHART_TYPE_DROPDOWN}    (//*[@class="MuiSelect-select MuiSelect-outlined MuiInputBase-input MuiOutlinedInput-input css-qiwgdb"])[2]       
${CHART_TYPE_TICK}    //*[@class="MuiButtonBase-root MuiMenuItem-root MuiMenuItem-gutters MuiMenuItem-root MuiMenuItem-gutters css-1km1ehz"]
${DURATION_DROPDOWN}    (//*[@class="MuiSelect-select MuiSelect-outlined MuiInputBase-input MuiOutlinedInput-input css-qiwgdb"])[3]         
${TICK_VALUE}    //*[@class="MuiSlider-mark css-1ejytfe"][2]   
${PAYOUT_OPTION}    //*[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium proposal-options css-1ujsas3"]
${AMOUNT_FIELD}     //*[@class="MuiInputBase-input MuiOutlinedInput-input css-1x5jdmq"]
${STATUS_WIN_OR_LOST}     xpath=//div[contains(@class, 'MuiCard-root') and contains(@class, 'proposal-summary-card')]
${STATUS_LOST}    //*[text()="You Lost:\ud83d\ude1e"]

${RANKING_LIST_1_XPATH}    //div[@class="leaderboard-tthree MuiBox-root css-0"]/ol[@class="leaderboard-tthree-list"]/li[1]
${RANKING_LIST_2_XPATH}    //div[@class="leaderboard-list bottom MuiBox-root css-0"]
${USER_NAME_XPATH}         .//p[1]
${USER_BALANCE_XPATH}      .//p[2]


*** Test Cases ***
User buy trade and check whether win/loss
    [Documentation]    Verify that the user wins the trade when choosing "Higher" and spot value is higher/ choosing "Lower" and spot value is lower
    Open Browser       ${URL}      ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5
    Login              
    Go To Trade Page
    Set Market Types
    Set Chart Types
    Set Duration Types
    Select Tick
    Choose Payout or Stake Contract
    Input Amount
    Click On Higher Option
    Display the Status
    Get Leaderboard Position
    View Trade History  
    # Reset Balance


*** Keywords ***
 
Login
    Open Browser       ${URL}      ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5
    Wait Until Page Contains Element     ${MAIN_TITLE}    30
    Click Element     ${LOGIN_BUTTON} 
    Wait Until Page Contains Element    ${LOGIN_POPUP}        30
    Input Text    ${USERNAME_INPUT}     ${USERNAME}  
    Input Text    ${PASSWORD_INPUT}     ${PASSWORD} 
    Click Element    ${EYE_ICON}
    Click Element    ${LOGIN_BUTTON2}
    Wait Until Page Contains Element    ${PROFILE_ICON}    10
                 
Go To Trade Page
   Click Element    ${TRADE_HEADER}
   Wait Until Page Contains Element    ${TRADE_BUY_FIELDS}    30 
Set Market Types
   Click Element    ${MARKET_TYPE_DROPDOWN}
   Click Element    ${MARKET_TYPE}   
   Wait Until Element Is Visible    ${CHART}  20
Set Chart Types 
   Click Element    ${CHART_TYPE_DROPDOWN}
   # Click Element    //*[@class="MuiButtonBase-root MuiMenuItem-root MuiMenuItem-gutters Mui-selected MuiMenuItem-root MuiMenuItem-gutters Mui-selected css-1km1ehz"]
   Click Element    ${CHART_TYPE_TICK}
   Wait Until Element Is Visible   ${CHART}    40
Set Duration Types 
    Click Element    ${DURATION_DROPDOWN}
    Click Element    //li[contains(text(), 'Ticks')]
    Wait Until Element Is Visible    ${CHART}    20

Select Tick
    Click Element    ${TICK_VALUE}
   
Choose Payout or Stake Contract
   Click Button    ${PAYOUT_OPTION} 

Input Amount
   Press Keys    ${AMOUNT_FIELD}    CTRL+a+BACKSPACE  
   Input text    ${AMOUNT_FIELD}    100
Click On Higher Option
    Click Button        //button[text()='Higher']

Click On Lower Option
    Click Button        //button[text()='Lower']

Display the Status
    Wait Until Page Contains Element    xpath=//*[@class="MuiPaper-root MuiPaper-elevation MuiPaper-rounded MuiPaper-elevation1 MuiCard-root proposal-summary-card css-s18byi"]    30
    ${card_element}    Get Webelement    xpath=//*[@class="MuiPaper-root MuiPaper-elevation MuiPaper-rounded MuiPaper-elevation1 MuiCard-root proposal-summary-card css-s18byi"]
    ${status_element}    Get Webelement    xpath=.//p[@class='MuiTypography-root MuiTypography-body1 css-9l3uo3']
    ${status}    Get Text    ${status_element}
    Run Keyword If    '${status}' == 'You Lost:\u2639'    Log    Status: Loss
    ...    ELSE IF    '${status}' == 'You Won!'    Log    Status: Win
    ...    ELSE    Fail    Unexpected status value: ${status}

Get Leaderboard Position
    Wait Until Page Contains Element    xpath=//*[@class="MuiPaper-root MuiPaper-elevation MuiPaper-rounded MuiPaper-elevation1 MuiCard-root proposal-summary-card css-s18byi"]    30
    Click Element    //*[@class="navbar-auth MuiBox-root css-0"]
    Wait Until Page Contains Element    //*[@class="sidebar-container"]
    Click Element    //p[contains(text(), 'See full leaderboard')]
    Click Element    //*[@class="MuiDrawer-root MuiDrawer-modal MuiModal-root css-y28f86"]
    Wait Until Page Contains Element    //h6[text()='Leaderboard']


View Trade History   
    Click Element    //*[@class="navbar-auth MuiBox-root css-0"]
    Wait Until Page Contains Element    //*[@class="sidebar-container"]
    Click Element    //p[contains(text(), 'See full trade history')]
    Click Element    //*[@class="MuiDrawer-root MuiDrawer-modal MuiModal-root css-y28f86"]
    # Click Element    //p[contains(@class, 'trade-history-nav')]
    Wait Until Page Contains Element    css=.trade-date-picker
    Click Element    css=.trade-date-picker
    Input Text    css=.trade-date-picker    18/07/2023
    Click Element    (//*[@class="MuiPaper-root MuiPaper-elevation MuiPaper-rounded MuiPaper-elevation1 MuiCard-root trade-main-card css-s18byi"])[1]
    Wait Until Page Contains Element    //*[@class="trade-history-box MuiBox-root css-0"]    20
    Click Element   //*[@class="MuiBackdrop-root MuiModal-backdrop css-919eu4"]
    
# Reset Balance
#    Wait Until Page Contains Element    css=.trade-date-picker    20
#    Click Element    //*[@class="navbar-auth MuiBox-root css-0"]
#    Wait Until Page Contains Element    //*[@class="sidebar-container"]
#    Click Element    //*[@class="MuiBackdrop-root MuiModal-backdrop css-919eu4"]
#    Click Element    (//button[@class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium css-1hw9j7s"])[1]
#    Wait Until Page Contains Element    //*[@class="MuiPaper-root MuiPaper-elevation MuiPaper-rounded MuiPaper-elevation24 MuiDialog-paper MuiDialog-paperScrollPaper MuiDialog-paperWidthSm css-uhb5lp"]    25
#    Click Element    //button[text()='Confirm']
#    Reload Page
#    Wait Until Page Contains Element    xpath=//div[@class="navbar-balance MuiBox-root css-0"]
#    ${element}=    Get Text    xpath=//div[@class="navbar-balance MuiBox-root css-0"]
#    Should Be Equal As Strings    ${element}    100000.00 USD

  
Logout
   Click Element    //*[@class="navbar-auth MuiBox-root css-0"]
   Wait Until Page Contains Element    //*[@class="sidebar-container"]
   Click Element    //button[text()='Log Out']
   Wait Until Page Contains Element    //*[id="logout-confirmation-dialog-title"]
   Click Element    //button[text()='Confirm']
   Wait Until Page Contains Element     ${MAIN_TITLE}    30
