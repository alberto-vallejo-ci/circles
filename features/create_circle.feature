@javascript

Feature: Create Circle

  Background:
    Given A circle exists

  Scenario: A user visit home page
    When I visit home page
    Then I see "2" circles
     And I see the existing circle

  Scenario: Two users visit home page
    When I am on browser "alfa"
    Then I visit home page
     And I see "2" circles
    When I am on browser "bravo"
    Then I visit home page
     And I see "3" circles
    When I am on browser "alfa"
     And I see "3" circles

