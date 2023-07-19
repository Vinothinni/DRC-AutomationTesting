*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${BROWSER}          chrome
${URL}              https://commoncents.vercel.app/    
${USERNAME}   vinothinni+1@besquare.com.my
${PASSWORD}   \#Hello1234
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

*** Keywords ***
Login
    Wait Until Page Contains Element     ${MAIN_TITLE}    30
    Click Element     ${LOGIN_BUTTON} 
    Wait Until Page Contains Element    ${LOGIN_POPUP}        30
    Input Text    ${USERNAME_INPUT}     ${USERNAME}  
    Input Text    ${PASSWORD_INPUT}     ${PASSWORD} 
    Click Element    ${EYE_ICON}
    Click Element    ${LOGIN_BUTTON2}
    Wait Until Page Contains Element    ${PROFILE_ICON}    10
    
Reset Balance
   Open Browser       ${URL}      ${BROWSER}
   Maximize Browser Window
   Set Selenium Speed    0.5
   Login
   Click Element    //*[@class="navbar-auth MuiBox-root css-0"]
   Wait Until Page Contains Element    //*[@class="sidebar-container"]
   Click Element    (//button[@class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-sizeMedium MuiButton-containedSizeMedium css-1hw9j7s"])[1]
   Wait Until Page Contains Element    //*[@class="MuiPaper-root MuiPaper-elevation MuiPaper-rounded MuiPaper-elevation24 MuiDialog-paper MuiDialog-paperScrollPaper MuiDialog-paperWidthSm css-uhb5lp"]    25
   Click Element    //button[text()='Confirm']
   Reload Page
   ${element}=    Get Text    xpath=//div[@class="MuiBox-root css-0"]
   Log    ${element}

Check Trade History
   Click Element    //*[@class="navbar-auth MuiBox-root css-0"]
   Wait Until Page Contains Element    //*[@class="sidebar-container"]
   Click Element    //p[contains(text(), 'See full trade history')]
   Click Element    //*[@class="MuiDrawer-root MuiDrawer-modal MuiModal-root css-y28f86"]
   Wait Until Page Contains Element    css=.trade-date-picker
   Page Should Contain    No trade history available. Start trading now!

*** Test Cases ***

Reset the balance and check the trade history
    Login
    Reset Balance
    Check Trade History



   

