*** Settings ***
Resource    ecommerce_resouces.robot
Library    SeleniumLibrary
Library    OperatingSystem
Test Teardown        Close Browser



*** Test Cases ***
Login Test
    [Tags]        login
    [Documentation]    Testa o processo de login do usuário
    Given I open the browser to the homepage
    When I fill in the username field with valid credentials
    And I fill in the password field with valid credentials
    And I click on the "Login" button
    Then I should be redirected to the products page


Login Test Invalid Username
    [Tags]        login
    [Documentation]    Testa o processo de login do usuário quando digitado username invalido
    Given I open the browser to the homepage
    When I fill in the username field with invalid credentials
    And I fill in the password field with valid credentials
    And I click on the "Login" button
    Then I should see an error message  

Login Test Invalid Password
    [Tags]        login
    [Documentation]    Testa o processo de login do usuário quando digitado password invalido
    Given I open the browser to the homepage
    When I fill in the username field with valid credentials
    And I fill in the password field with invalid credentials
    And I click on the "Login" button
    Then I should see an error message     

Login Test Invalid Username And Password
    [Tags]        login
    [Documentation]    Testa o processo de login do usuário quando digitado username e password invalido
    Given I open the browser to the homepage
    When I fill in the username field with invalid credentials
    And I fill in the password field with invalid credentials
    And I click on the "Login" button
    Then I should see an error message    

Login Test Empty Username 
    [Tags]        login
    [Documentation]    Testa o processo de login quando username vazio
    Given I open the browser to the homepage
    When I fill in the username field with empty credentials
    And I fill in the password field with valid credentials
    And I click on the "Login" button
    Then I should see an empty username error message

Login Test Empty Password 
    [Tags]        login
    [Documentation]    Testa o processo de login quando password vazio
    Given I open the browser to the homepage
    When I fill in the username field with valid credentials
    And I fill in the password field with empty credentials
    And I click on the "Login" button
    Then I should see an empty password error message

Login Test Empty Username And Password 
    [Tags]        login
    [Documentation]    Testa o processo de login quando username e password vazio
    Given I open the browser to the homepage
    When I fill in the username field with empty credentials
    And I fill in the password field with empty credentials
    And I click on the "Login" button
    Then I should see an empty username error message

Add To Cart Test
    [Tags]        cart
    [Documentation]    Testa a adição de um produto ao carrinho
    Given I am logged in and on the products page
    When I select a product to add to the cart
    And I click on the Add to cart button
    Then The product should be added to my cart

Checkout Test
    [Tags]        checkout
    [Documentation]    Testa o processo de checkout
    Given I am logged in and have items in my cart
    When I click on the Checkout button
    And I fill in the shipping and payment information correctly
    And I click on the Continue button
    And I click on the Finish button
    Then The purchase should be successfully completed

Logout Test
    [Tags]        logout
    [Documentation]    Testa o processo de logout do usuário
    Given I am logged in and on the products page
    When I click on the menu icon
    And I select Logout
    Then I should be redirected to the "Login" page

Filter Products Test
    [Tags]        filter_produts
    [Documentation]    Testa a filtragem de produtos por ordem alfabética
    Given I am logged in and on the products page
    When I order a product "A to Z" from the filter
    Then I should see the order ordered    

Sort Products Test
    [Tags]        filter_produts
    [Documentation]    Testa a ordenação de produtos por preço
    Given I am logged in and on the products page
    When I order a product "Price" from the filter
    Then I should see the order ordered for price    


Remove Product from Cart Test
    [Tags]     remove_product
    [Documentation]    Testa a remoção de um produto do carrinho
    Given I have items in my cart
    When I click on the remove button
    Then The product should be removed from my cart



