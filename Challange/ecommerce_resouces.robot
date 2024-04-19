*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    XML
Library    Process
Library    Collections

*** Variables ***
${BROWSER}       Chrome
${URL}           https://www.saucedemo.com/
${USERNAME1}     standard_user
${PASSWORD}      secret_sauce
${INVALID_USERNAME}     teste
${INVALID_PASSWORD}      teste
${EMPTY_USERNAME}    
${EMPTY_PASSWORD}      
${USERNAME_BOX}   (//input[contains(@class,'input_error form_input')])[1]
${PASSWORD_BOX}   (//input[contains(@class,'input_error form_input')])[2]
${TITLE_PRODUCTS}        Products
${USERNAME_PASSWORD_INVALID}        Epic sadface: Username and password do not match any user in this service
${USERNAME_EMPTY_MESSAGE}        Epic sadface: Username is required
${PASSWORD_EMPTY_MESSAGE}     Epic sadface: Password is required
${PRODUT_IMAGE}        //img[contains(@alt,'Sauce Labs Backpack')]
${ADD_CART}        //button[@class='btn btn_primary btn_small btn_inventory'][contains(.,'Add to cart')]
${CART}        //a[@class='shopping_cart_link'][contains(.,'1')]
${YOUR_CART}        <div class="cart_quantity" data-test="item-quantity" style="outline: green dotted 2px !important;">1</div>
${CHECKOUT}        //button[@class='btn btn_action btn_medium checkout_button '][contains(.,'Checkout')]
${FIRST_NAME_BOX}        //input[contains(@placeholder,'First Name')]
${LAST_NAME_BOX}        //input[contains(@placeholder,'Last Name')]
${ZIP_CODE_NAME_BOX}        //input[contains(@placeholder,'Zip/Postal Code')]
${FIRST_NAME}        Thamirys
${LAST_NAME}        Oliveira
${ZIP_CODE_NAME}        2975309
${CONTINUE_CHECKOUT}        //input[contains(@type,'submit')]
${CHECKOUT_COMPLETE}        Checkout: Complete!        
${FINISH_CHECKOUT}        //button[@class='btn btn_action btn_medium cart_button'][contains(.,'Finish')]
${MENU_ICON}        //button[contains(.,'Open Menu')]
${LOGOUT}        //a[contains(@data-test,'logout-sidebar-link')]
${LOGIN}        //input[contains(@type,'submit')]
${FILTER}        //select[contains(@class,'product_sort_container')]
${AZ}        //option[@value='az'][contains(.,'Name (A to Z)')]
${LOHI}        //option[@value='lohi'][contains(.,'Price (low to high)')]
${PRODUCTS_NAMES}        css: .inventory_item_name
${REMOVE_PRODUCT}        //button[@class='btn btn_secondary btn_small cart_button'][contains(.,'Remove')]
${REMOVE_PRODUCT_TEXT}        //*[@id="shopping_cart_container"]/amove


*** Keywords ***
I open the browser to the homepage
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

I fill in the username field with valid credentials
    Clear Element Text        ${USERNAMEBOX} 
    Input Text        user-name        ${USERNAME1}

I fill in the password field with valid credentials
    Clear Element Text        ${PASSWORDBOX}     
    Input Password    password        ${PASSWORD}

I click on the "Login" button
    Click Button    login-button

I should be redirected to the products page
    Wait Until Page Contains    ${TITLE_PRODUCTS}

I fill in the username field with invalid credentials
    Clear Element Text        ${USERNAMEBOX} 
    Input Text        user-name        ${INVALID_USERNAME}

I fill in the password field with invalid credentials
    Clear Element Text        ${PASSWORDBOX}     
    Input Password    password        ${INVALID_PASSWORD}    

I fill in the username field with empty credentials
    Clear Element Text        ${USERNAMEBOX} 
    Input Text        user-name       ${EMPTY_USERNAME}

I fill in the password field with empty credentials
    Clear Element Text        ${PASSWORDBOX}     
    Input Password    password       ${EMPTY_PASSWORD}         

I should see an error message
    Wait Until Page Contains    ${USERNAME_PASSWORD_INVALID}

I should see an empty username error message
    Wait Until Page Contains   ${USERNAME_EMPTY_MESSAGE} 

I should see an empty password error message
    Wait Until Page Contains   ${PASSWORD_EMPTY_MESSAGE} 
    
I am logged in and on the products page
    I open the browser to the homepage
    I fill in the username field with valid credentials
    I fill in the password field with valid credentials
    I click on the "Login" button
    I should be redirected to the products page

I select a product to add to the cart
    Wait Until Page Contains Element    ${PRODUT_IMAGE}  
    Click Image    ${PRODUT_IMAGE}  

I click on the Add to cart button
    Click Button    ${ADD_CART} 

The product should be added to my cart
    Click Element    ${CART}
    Element Should Exist    ${YOUR_CART}

I am logged in and have items in my cart
    I am logged in and on the products page
    I select a product to add to the cart
    I click on the Add to cart button
    The product should be added to my cart

I click on the Checkout button
     Click Button        ${CHECKOUT}

I fill in the shipping and payment information correctly
    Input Text        ${FIRST_NAME_BOX}       ${FIRST_NAME}
    Input Text        ${LAST_NAME_BOX}        ${LAST_NAME}
    Input Text        ${ZIP_CODE_NAME_BOX}        ${ZIP_CODE_NAME}

I click on the Continue button
    Click Button        ${CONTINUE_CHECKOUT}

I click on the Finish button
    Click Button        ${FINISH_CHECKOUT}

The purchase should be successfully completed
    Wait Until Page Contains        ${CHECKOUT_COMPLETE}

I click on the menu icon
     Click Button        ${MENU_ICON}

I select Logout
    Wait Until Element Is Visible         ${LOGOUT}         timeout=5s
    Click Element        ${LOGOUT}

I should be redirected to the "Login" page
    Wait Until Page Contains Element   ${LOGIN}

I order a product "A to Z" from the filter
    Click Element        ${FILTER}
    Wait Until Element Is Visible        ${AZ}    timeout=3s
    Click Element         ${AZ}

 I should see the order ordered  
    @{product_elements}    Get WebElements        ${PRODUCTS_NAMES} 
    @{product_names}    Create List
    FOR    ${element}    IN    @{product_elements}
    ${product_name}    Get Text    ${element}
    Append To List    ${product_names}    ${product_name}
    END
    ${sorted_product_names}    Evaluate    sorted(${product_names})
    Lists Should Be Equal    ${product_names}    ${sorted_product_names}

I order a product "Price" from the filter
    Click Element        ${FILTER}
    Wait Until Element Is Visible        ${LOHI}    timeout=3s
    Click Element         ${LOHI}

I should see the order ordered for price
    ${precos}    Get WebElements    css: div.inventory_item_price[data-test="inventory-item-price"]
    ${lista_precos}    Create List
    FOR    ${preco}    IN    @{precos}
    ${texto_preco}    Get Text    ${preco}
    Append To List    ${lista_precos}    ${texto_preco}
    END
    ${lista_ordenada}    Set Variable    ${lista_precos}
    Evaluate    sorted($lista_precos)    # Ordene a lista original e armazene-a em uma nova variável
    Lists Should Be Equal    ${lista_precos}    ${lista_ordenada}    # Verifique se a lista original é igual à lista ordenada
    
I have items in my cart
    I am logged in and on the products page
    I select a product to add to the cart
    I click on the Add to cart button
    The product should be added to my cart

I click on the remove button
    Click Button    ${REMOVE_PRODUCT}

The product should be removed from my cart
    ${elements_count}=    Get Element Count    //*[@id="shopping_cart_container"]/a
    Should Be True    ${elements_count} > 0    Element count should be greater than zero