//1.- Buscar las personas que sólo han actuado (no dirigido) (1909)
db.people.find({"hasActed":true,"hasDirected":{"$exists": false}}).count()

//2.- Buscar las personas que sólo han dirigido (no actuado) (341)
db.people.find({"hasDirected":true,"hasActed":{"$exists":false}}).count()

//3.- Buscar las personas que han actuado y dirigido (20)
db.people.find({"hasActed":true,"hasDirected":true}).count()

//4.- Buscar las personas que ni han actuado ni dirigido (29)
db.people.find({"hasActed":{"$exists":false},"hasDirected":{"$exists":false}}).count()

//1.- Buscar las personas con premios otorgados en el año 2001 (3)
db.bios.find({"awards.year":2001}).count()

//2.- Buscar las personas que hayan obtenido el premio 'Turing Award' (5)
db.bios.find({"awards.award":"Turing Award"}).count()

//3.- Buscar las personas que haya obtenido un premio del tipo 'National Medal of' (4)
db.bios.find({"awards.award":/National Medal of.*/}).count()

//4.- Buscar las personas con fecha de nacimiento de la que no conste su fecha de defunción (3)
db.bios.find({"birthYear":{"$exists":true},"deathYear":{"$exists":false}}).count()

//5.- Buscar las personas de la colección bios que destaquen en el terreno de OOP (2)
db.bios.find({"contribs":"OOP"}).count()

//6.- Buscar las personas de la colección bios que destaquen en el terreno de Java, Ruby o Python (3)
db.bios.find({"$or":[{"contribs":"Java"},{"contribs":"Ruby"},{"contribs":"Python"}]}).count()

//7.- Buscar las personas de la colección bios que destaquen en el terreno de OOP y Simula (2)
db.bios.find({"contribs":{"$all":["OOP","Simula"]}}).count()

//8.- Buscar las personas de la colección bios sin premios logrados (1)
db.bios.find({"awards":{"$exists":false}}).count()

//9.- Buscar las personas de la colección bios con 1 premio conseguido (1)
db.bios.find({"awards":{"$size":1}}).count()

//10.- Buscar las personas de la colección bios con 3 o más premios conseguidos (6)
db.bios.find({"awards.2":{"$exists":true}}).count()

//11.- Buscar las personas de la colección bios con entre 2 y 4 premios conseguidos (8)
> db.bios.find({"$or":[{"awards.1":{"$exists":true}},{"awards.2":{"$exists":true}},{"awards.3":{"$exists":true}}]}).count()

//1.- Buscar todos los libros con precio superior a 100 USD (7)
db.books.find({"price.msrp":{"$gt":100}}).count()

//2.- Buscar todos los libros publicados por "Martin Fowler" (4)
db.books.find({"author":"Martin Fowler"}).count()

//3.- Buscar los libros que tengan el tag 'programming', 'agile' y "java" (5)
db.books.find({"tags":{"$all":["programming","agile","java"]}}).count()

//4.- Buscar aquellos libros que han sido escritos por Martin Fowler y Kent Beck (2)
db.books.find({"author":{"$all":["Martin Fowler","Kent Beck"]}}).count()

//5.- Buscar los libros escritos por 3 autores (17)
db.books.find({"author":{"$size":3}}).count()

//6.- Buscar los libros escritos por mas de un autor (106)
db.books.find({"author.1":{"$exists":true}}).count()

//1.- Buscar aquellos paises donde el español es lenguaje nativa (24)
db.countries.find({"nativeLanguage":"spa"}).count()

//2.- Buscar aquellos paises donde el español es lenguaje oficial (21)
db.countries.find({"languages.spa":"Spanish"}).count()

//3.- Mostrar aquellos paises donde sólo el español es lengua oficial (y no hay más)
db.countries.find({languages:{"spa":"Spanish"}})


//edx students
//1) Estudiants de gènere masculí nascuts al 1993 (81)
db.students.find({"gender":"H","birth_year":1993}).count()

//2) Estudiants nascuts a la dècada dels 80 (936)
db.students.find({"$and":[{"birth_year":{"$gte":1980}},{"birth_year":{"$lte":1989}}]}).count()

//3) Estudiants de gènere femení nascuts a la dècada dels 90 (48)
db.students.find({"$and":[{"gender":"M"},{"birth_year":{"$gte":1990}},{"birth_year":{"$lte":1999}}]}).count()

//4) Estudiants que no hagin nascut l'any 1985 (3147)
db.students.find({"birth_year":{"$ne":1985}}).count()

//5) Estudiants nascuts el 1970, 1980 o 1990 (293)
db.students.find({"$or":[{"birth_year":1970},{"birth_year":1980},{"birth_year":1990}]}).count()

//6) Estudiants no nascuts el 1970, ni el 1980, ni el 1990 (2950)
db.students.find({"$nor":[{"birth_year":1970},{"birth_year":1980},{"birth_year":1990}]}).count()

//7) Estudiants nascuts un any parell (1684)
db.students.find({"birth_year":{"$mod":[2,0]}}).count()

//8) Estudiants nascuts un any inparell de la dècada dels 70 i de gènere femení (403)
db.students.find({"$and":[{"birth_year":{"$mod":[2,1]}},{"birth_year":{"$gte":1970}},{"birth_year":{"$lte":1979}},{"gender":"M"}]}).count()

//9)Estudiants amb un @mail que acabi en .net (47)
db.students.find({"email":/.*.net$/}).count()

//10)Estudiants amb un @mail que acabi en .org (16)
db.students.find({"email":/.org$/}).count()

//11)Estudiants amb DNI que comenci i acabi en lletra (244)

//12)Estudiants amb un nom que comenci per vocal (amb tots els accesnts possibles) (760)

//13)Estudiants amb un nom compost (470)
db.students.find({"name":/.* .*/}).count()

//14)Estudiants amb un nom de més de 13 caràcters (138)
db.students.find({"name":/.{13,}/i}).count()


db.students.aggregate([
    {
        "$match":{
            "$and":[{"birth_year":{"$gte":1988}},{"birth_year":{"$lte":1993}}]
        }
    },
    {
        "$group":{
            "_id":"$birth_year",
            "nstudents":{"$sum":1}
        }
    },
    {
        "$project":{
            "_id":0,
            "year":"$_id",
            "students":"$nstudents"
        }
    },
    {
        "$sort":{
            "year":-1
        }
    }
])

db.students.aggregate([
    {
        "$match":{
            "$and":[{"birth_year":{"$gte":1988}},{"birth_year":{"$lte":1993}}]
        }
    },
    {
        "$group":{
            "_id":{"birth_year":"$birth_year","gender":"$gender"},
            "nstudents":{"$sum":1}
        }
    },
    {
        "$project":{
            "_id":0,
            "year":"$_id.birth_year",
            "gender":"$_id.gender",
            "students":"$nstudents"
        }
    },
    {
        "$sort":{
            "year":-1
        }
    }
])


db.students.aggregate([
    {
        "$match":{
            "birth_year":{"$gte":1992,"$lte":1993}
        }
    },
    {
        "$group":{
            "_id":"$birth_year",
            "total": {"$sum":1},
            "males": {"$sum":{"$cond":[{"$eq":["$gender","H"]},1,0]}},
            "females": {"$sum":{"$cond":[{"$eq":["$gender","M"]},1,0]}}
        }
    },
    {
        "$project":{
            "_id":0,
            "year":"birth_year",
            "total":"$total",
            "males": "$males",
            "females": "$females",
            "malesper": {"$multiply":[{"$divide":["$males","$total"]},100]},
            "femalesper": {"$multiply":[{"$divide":["$females","$total"]},100]}
        }
    }
]).pretty()


db.stories.aggregate([
    {
        "$group":{
            "_id":"$container.name",
            "posts": {"$sum":1},
            "diggs": {"$sum":"$diggs"}
        }
    },
    {
        "$project":{
            "_id":0,
            "topic": "$_id",
            "posts": "$posts",
            "diggs": "$diggs"
        }
    },
    {
        "$sort":{
            "topic":-1
        }
    }
])


db.books.aggregate([
    {
        "$unwind":"$author"
    },
    {
        "$group":{
            "_id":"$author",
            "books": {"$sum":1}
        }
    },
    {
        "$project":{
            "_id":0,
            "author": "$_id",
            "books": "$books"
        }
    },
    {
        "$sort":{
            "books":-1
        }
    },
    {
        "$limit": 1
    }
])