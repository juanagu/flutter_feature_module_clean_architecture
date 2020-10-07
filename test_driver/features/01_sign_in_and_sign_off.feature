Feature: Sign In & Sign Off

  Scenario: sign in with valid user successfuly 
    Given I have an app without session
    And I fill the "sign_in_username" field with "fake_username"
    And I fill the "sign_in_password" field with "fake_user_password"
    When I tap the "sign_in_button" button
    Then I expect the label 'welcome_label' to be present within 10 seconds
    And I expect the "welcome_label" to be "welcome"

  Scenario: sign off successfuly
    Given I have a user logged
    When I tap the "logout_button" button
    Then I expect the label "ask_to_confirm_sign_off" to be present within 1 seconds
    And I tap the "logout_accept_button" button
    And I expect the button "sign_in_username" to be present within 1 second

  Scenario: sign in with username only show password is required error
    Given I fill the "sign_in_username" field with "fake_username"
    And I fill the "sign_in_password" field with ""
    When I tap the "sign_in_button" button
    Then I expect the text 'password_is_required' to be present within 1 second

  Scenario: sign in with username only show username is required error
    Given I fill the "sign_in_username" field with ""
    And I fill the "sign_in_password" field with "fake_user_password"
    When I tap the "sign_in_button" button
    Then I expect the text 'username_is_required' to be present within 1 second

  Scenario: sign in with empty credentials show username and password is required error
    Given I fill the "sign_in_username" field with ""
    And I fill the "sign_in_password" field with ""
    When I tap the "sign_in_button" button
    Then I expect the text 'username_is_required' to be present within 1 second     
    And I expect the text 'password_is_required' to be present within 1 second
    And I restart the app
