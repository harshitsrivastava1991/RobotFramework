*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn




*** Test Cases ***
Open the techm url
    Open the techm url now
Enter any item in the search string
    Enter any item in the search string now


*** Keywords ***
Open the google.com url now
    Create Webdriver    Chrome
    Go To    https://www.techmahindra.com/

Enter any item in the search string now
    Wait Until Element Is Visible    //textarea[@id='APjFqb']
    Click Element    //textarea[@class='gLFyf']
    Input Text    //textarea[@class='gLFyf']    Harshit
    Click Button    (//input[@name='btnK'])[2]