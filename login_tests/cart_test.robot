*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Products Page

*** Variables ***
${URL}           https://www.saucedemo.com/
${BROWSER}       chrome
${USERNAME}      standard_user
${PASSWORD}      secret_sauce
${DELAY}         0.3 seconds

*** Test Cases ***
Add Item To Cart
   Scenario: Add Item To Cart
    Click Add To Cart Button    Sauce Labs Backpack
    Verify Cart Badge Count    1

Scenario: Remove Item From Cart
    Click Add To Cart Button    Sauce Labs Backpack
    Click Remove Button    Sauce Labs Backpack
    Verify Cart Badge Not Visible

*** Keywords ***
Click Add To Cart Button
    [Arguments]    ${product}
    Click Element    xpath://div[text()='${product}']/ancestor::div[@class='inventory_item']//button

Click Remove Button
    [Arguments]    ${product}
    Click Element    xpath://div[text()='${product}']/ancestor::div[@class='inventory_item']//button

Verify Cart Badge Count
    [Arguments]    ${count}
    ${badge}=    Get Text    class:shopping_cart_badge
    Should Be Equal    ${badge}    ${count}

Verify Cart Badge Not Visible
    Element Should Not Be Visible    class:shopping_cart_badge