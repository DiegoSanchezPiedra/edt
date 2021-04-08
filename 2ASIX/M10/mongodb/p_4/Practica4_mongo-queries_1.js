//edx.students
//1) Estudiants de gènere masculí nascuts al 1993 (81)
> db.students.find({"gender":"H","birth_year":1993}).count()
> db.students.find({"$and":[{"gender":"H"},{"birth_year":1993}]}).count()

//2) Estudiants nascuts a la dècada dels 80 (936)
> db.students.find({"$and": [{"birth_year": {$gt: 1979}},{"birth_year": {$lt: 1990}}]}).count()
> db.students.find({"birth_year": {$gt: 1979},"birth_year": {$lt: 1990}}).count() //no funciona ???

//3) Estudiants de gènere femení nascuts a la dècada dels 90 (48)
> db.students.find({"$and": [{"gender":"M"},{"birth_year": {$gt: 1989}},{"birth_year": {$lt: 2000}}]},{_id:0,gender:1}).count()

//4) Estudiants que no hagin nascut l'any 1985 (3147)
> db.students.find({"birth_year": {$ne: 1985}}).count()

//5) Estudiants nascuts el 1970, 1980 o 1990 (293)
> db.students.find({"$or": [{"birth_year": 1970},{"birth_year": 1980},{"birth_year": 1990}]}).count()

//6) Estudiants no nascuts el 1970, ni el 1980, ni el 1990 (2950)
> db.students.find({"$nor": [{"birth_year": 1970},{"birth_year": 1980},{"birth_year": 1990}]}).count()
> db.students.find({"$and": [{"birth_year": {"$ne": 1970}},{"birth_year": {"$ne": 1980}},{"birth_year": {"$ne": 1990}}]}).count()
> db.students.find({"birth_year": {"$nin": [1970,1980,1990]}}).count()

//7) Estudiants nascuts un any parell (1684)
> db.students.find({"birth_year": {$mod: [2,0]}}).count()

//8) Estudiants nascuts un any inparell de la dècada dels 70 i de gènere femení (403)
> db.students.find({"$and": [{"birth_year": {$mod: [2,1]}},{"birth_year": {$gt: 1969}},{"birth_year": {$lt: 1980}},{"gender": "M"}]}).count() //en principi està be però em surt un resultat diferent

//9)Estudiants amb un @mail que acabi en .net (47)
> db.students.find({"email": /\.net$/i}).count() //em dona 48 registres

//10)Estudiants amb un @mail que acabi en .org (16)
> db.students.find({"email": /\.org$/i}).count()

//11)Estudiants amb DNI que comenci i acabi en lletra (244)
db.students.find({"dni": /^[A-Z].*[A-Z]$/i})
db.students.find({"$and": [{"$dni": /^[A-Z]/i},{"$dni": /[A-Z]$/i}]}) //no hi ha el camp "dni"

//12)Estudiants amb un nom que comenci per vocal (amb tots els accesnts possibles) (760)
> db.students.find({"$or": [{"name": /^a/i},{"name": /^á/i},{"name": /^à/i},{"name": /^â/i},{"name": /^ã/i},{"name": /^ä/i}]}).count()

//13)Estudiants amb un nom compost (470)
> db.students.find({"name": /.* .*/i}).count()
> db.students.find({"name": / /i}).count()
> db.students.find({"name": /.+\s.+/}).count()
> db.students.find({"name": /\s/},{"name": true})

//14)Estudiants amb un nom de més de 13 caràcters (138)
> db.students.find({"name": /.{13,}/}).count()
> db.students.find({"$where": "this.name.length >= 13"}).count()

//15)Estudiants amb 4 o més vocals en els seu nom (705)
> db.students.find({"name": /.*[aeiouàáèéìíòóùú]{2,}.*/i}).count() //està be pero per dues vocal seguides
> b.students.find({"name": /.*[aeiouàáèéìíòóùú].*[aeiouàáèéìíòóùú].*[aeiouàáèéìíòóùú].*[aeiouàáèéìíòóùú].*/i}).count()
//edx.bios
//16)Desenvolupadors que hagin fet contribucions en OOP (2)
> db.bios.find({"contribs": {$all: ['OOP']}}).count()

//17)Desenvolupadors que hagin fet contribucions en OOP o Java (3)
> db.bios.find({"$or": [{"contribs": {"$all": ['Java']}},{"contribs": {"$all": ['OOP']}}]}).count()

//18)Desenvolupadors que hagin fet contribucions en OOP i Simula (2)
> db.bios.find({"contribs": {"$all": ['OOP','Simula']}}).count()
> db.bios.find({"$or": [{"contribs": ['Simula','OOP']},{"contribs": ['OOP','Simula']}]}).count()