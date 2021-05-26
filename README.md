# Karate-DSL-Gatling
El Nombre completo del curso es Karate DSL: API Automation and Performance from Zero to Hero cuyo autor es Artem Bondar . Link del curso: https://bcp.udemy.com/course/karate-dsl-api-automation-and-performance-from-zero-to-hero

## Notas
HomePage.feature
And match response.articles[*].favoritesCount contains 1
También puede verificar la parte de la cadena si lo necesita, si proporcionará una estrella en lugar del índice de su karate, Karate examinará los valores antiguos de su matriz y agrupará los valores para cada valor

#And match response.articles[*].author.bio contains null
And match response..bio contains null
Ambos son validos
