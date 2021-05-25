Feature: Articles

    Background: Define URL
        Given url apiUrl
        * def tokenResponse=callonce read('classpath:helpers/CreateToken.feature') 
        * def token=tokenResponse.authToken

    Scenario: Create a new article
        Given path 'articles'
        And request {"article":{"tagList":[],"title":"bla bla","description":"test test","body": "body"}}
        When method Post
        Then status 200
        And match response.article.title == 'bla bla'

    Scenario: Create and delete article
        Given path 'articles'
        And request {"article":{"tagList":[],"title":"bla bla","description":"test test","body": "body"}}
        When method Post
        Then status 200
        * def articleId = response.article.slug

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'Delete Article'

        Given path 'articles',articleId
        When method Delete
        Then status 200

        Given params { limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'Delete Article'