*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${BROWSER}    Chrome
${URL}        https://commoncents.vercel.app/
${USERNAME}   vinothinni+1@besquare.com.my
${PASSWORD}   \#Hello1234
${INVALID_PASSWORD}   @#kjul12
${MAIN_TITLE}    //*[@class="banner-title"][1]
${LOGIN_BUTTON}    //*[@class="MuiTypography-root MuiTypography-body1 navbar-login-btn css-9l3uo3"]
${LOGIN_POPUP}    //*[@class="auth-modal-box"]
${USERNAME_INPUT}    (//*[@class="MuiInputBase-input MuiOutlinedInput-input css-1x5jdmq"])[1]
${PASSWORD_INPUT}    //*[@class="MuiInputBase-input MuiOutlinedInput-input MuiInputBase-inputAdornedEnd css-1uvydh2"]
${EYE_ICON}    //*[@class="MuiButtonBase-root MuiIconButton-root MuiIconButton-edgeEnd MuiIconButton-sizeMedium css-slyssw"]
${LOGIN_BUTTON2}    (//*[text()="Login"])[3]
${PROFILE_ICON}    //*[@class="navbar-balance MuiBox-root css-0"]




*** Keyword ***
Login to Website
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5
    Wait Until Page Contains Element     ${MAIN_TITLE}    30
    Click Element     ${LOGIN_BUTTON} 
    Wait Until Page Contains Element    ${LOGIN_POPUP}        30
    Input Text    ${USERNAME_INPUT}     ${USERNAME}  
    Input Text    ${PASSWORD_INPUT}     ${PASSWORD} 
    Click Element    ${EYE_ICON}
    Click Element    ${LOGIN_BUTTON2}
    Wait Until Page Contains Element    ${PROFILE_ICON}    20




*** Test Cases ***

Create Post
   Login to Website
   Click Element    (//*[@class="MuiTypography-root MuiTypography-body1 navbar-item css-9l3uo3"])[3]
   Wait Until Page Contains Element    //*[@class="MuiCardContent-root css-1qw96cp"] 
   Input Text    //*[@class="MuiInputBase-input MuiFilledInput-input css-2bxn45"]    Testing10.5
   Input Text   (//*[@class="MuiInputBase-input MuiFilledInput-input MuiInputBase-inputMultiline css-qm8ja9"])[1]   Hellooooo10.5
   Click Element    (//*[@class="MuiButtonBase-root MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium MuiButton-root MuiButton-text MuiButton-textPrimary MuiButton-sizeMedium MuiButton-textSizeMedium css-1p2x1nd"])[1]
   
Like the Post
   Click Element     (//*[@class="MuiCardContent-root css-1qw96cp"])[2]
   Click Element    (//button[contains(@class, 'MuiIconButton-root') and contains(@class, 'css-1yxmbwk')])[1]
   Reload Page

Add Comment
   Wait Until Element Is Visible    (//*[@class="MuiCardContent-root css-1qw96cp"])[2]    10
   Input Text    (//textarea[contains(@class, 'MuiInputBase-inputMultiline')])[3]    Good Morning
   Click Element    xpath=//button[contains(., 'Comment')]
   Sleep    1s
   Click Element    (//div[contains(@class, 'forum-comments-card')])[1]
   # Delete comment
   Click Element    (//div[contains(@class, 'forum-comments-card')])[1]//button[contains(@class, 'MuiIconButton-root')]
   Reload Page

Delete the Post
   Wait Until Element Is Visible    (//*[@class="MuiCardContent-root css-1qw96cp"])[2]    10
   Click Element    (//div[contains(@class, 'forum-right-card')]//button[contains(@class, 'MuiIconButton-root')])[2]