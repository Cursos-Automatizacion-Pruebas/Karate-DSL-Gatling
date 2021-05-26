Feature: Sign Up new user

    Background: Preconditions
        Given url apiUrl


    Scenario: New user Sign Up
        Given def userData = {"email":"karateUser250502@test.com","username":"tester250502"}
        Given path 'users'
        And request 
        """
            {
                "user": {
                    "email": #(userData.email),
                    "password":"12250502",
                    "username": #(userData.username)
                }
            }
        """ 
        When method Post
        Then status 200


