# Karate-DSL-Gatling
El Nombre completo del curso es Karate DSL: API Automation and Performance from Zero to Hero cuyo autor es Artem Bondar . Link del curso: https://bcp.udemy.com/course/karate-dsl-api-automation-and-performance-from-zero-to-hero

## Notas
En vez de usar metodos static , se puede trabajar con string
Clase DataGenerator.java 
   public  String getRandomUsername2() {
        Faker faker= new Faker();
        String username=faker.name().username();
        return username;
    }
SignUp.feature
* def jsFunction =
        """
            function () {
                var DataGenerator = Java.type('helpers.DataGenerator')
                var generator = new DataGenerator()
                return generator.getRandomUsername2()
            }
        """
* def randomUsername2 =  call jsFunction

Invocar randomUsername2
And request 
        """
            {
                "user": {
                    "email": #(randomEmail),
                    "password":"12250502",
                    "username": #(randomUsername2)
                }
            }
        """ 
And match response ==
        """
           { 
                "user": {
                    "id": "#number",
                    "email": #(randomEmail),
                    "createdAt": "#? timeValidator(_)",
                    "updatedAt": "#? timeValidator(_)",
                    "username": #(randomUsername2),
                    "bio": null,
                    "image": null,
                    "token": "#string"
                }
           } 
        """