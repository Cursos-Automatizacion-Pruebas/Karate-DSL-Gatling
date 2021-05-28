@debug
Feature: Sign Up new user

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def timeValidator = read('classpath:helpers/timeValidator.js')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        * url apiUrl

    Scenario: New user Sign Up
        Given path 'users'
        And request 
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "password":"12250502",
                    "username": #(randomUsername)
                }
            }
        """ 
        When method Post
        Then status 200
        And match response ==
        """
           { 
                "user": {
                    "id": "#number",
                    "email": #(randomEmail),
                    "createdAt": "#? timeValidator(_)",
                    "updatedAt": "#? timeValidator(_)",
                    "username": #(randomUsername),
                    "bio": null,
                    "image": null,
                    "token": "#string"
                }
           } 
        """
    Scenario Outline:  Validate Sign Up error
        Given path 'users'
        And request 
        """
            {
                "user": {
                    "email": "<email>",
                    "password":"<password>",
                    "username": "<username>"
                }
            }
        """ 
        When method Post
        Then status 422
        And match response == <errorResponse>
        Examples:
            | email                   | password    | username              | errorResponse                                                                         |
            | #(randomEmail)          | karate123   | karateUser123         | {"errors":{"username":["has already been taken"]}}                                    |
            | karateUser1@test.com    | karate123   | #(randomUsername)     | {"errors":{"email":["has already been taken"]}}                                       |
            | karateUser1             | karate123   | #(randomUsername)     | {"errors":{"email":["is invalid"]}}                                                   |
            | #(randomEmail)          | karate123   | karate123312312318901 | {"errors":{"username":["is too long (maximum is 20 characters)"]}}                    |
            | #(randomEmail)          | kar         | #(randomUsername)     | {"errors":{"password":["is too short (minimum is 8 characters)"]}}                   |
            |                         | karate123   | #(randomUsername)     | {"errors":{"email":["can't be blank"]}}                                               |
            | #(randomEmail)          |             | #(randomUsername)     | {"errors":{"password":["can't be blank"]}}                                            |
            | #(randomEmail)          | karate123   |                       | {"errors":{"username":["can't be blank","is too short (minimum is 1 character)"]}}   |