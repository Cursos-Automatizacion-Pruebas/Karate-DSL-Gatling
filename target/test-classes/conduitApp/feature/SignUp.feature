Feature: Sign Up new user

    Background: Preconditions
        Given url apiUrl

@debug
    Scenario: New user Sign Up
        Given def userData = {"email":"karateUser250501@test.com","username":"tester250501"}
        Given path 'users'
        And request 
        """
            {
                "user": {
                    "email": #(userData.email),
                    "password":"12345670",
                    "username": #(userData.username)
                }
            }
        """ 
        When method Post
        Then status 200


