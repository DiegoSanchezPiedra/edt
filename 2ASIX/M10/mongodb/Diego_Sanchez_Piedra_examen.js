//Diego Alessandro Sanchez Piedra
//isx2031424

//1.
db.movies.find({"$and":[{"$or":[{"actors.name":"Harrison Ford"},{"actors.name":"Michelle Pfeiffer"}]},{"$or":[{"directors.name":"Tim Burton"},{"directors.name":"Andrew Davis"}]}]}).count()
2

db.movies.find({"$and":[{"$or":[{"actors.name":"Harrison Ford"},{"actors.name":"Michelle Pfeiffer"}]},{"$or":[{"directors.name":"Tim Burton"},{"directors.name":"Andrew Davis"}]}]}).pretty()
{
	"_id" : "0106977",
	"name" : "Fugitive, The",
	"year" : 1993,
	"rating" : "PG-13",
	"runtime" : 130,
	"genre" : "AMT",
	"earnings_rank" : 158,
	"actors" : [
		{
			"id" : "0000148",
			"name" : "Harrison Ford"
		},
		{
			"id" : "0000169",
			"name" : "Tommy Lee Jones"
		},
		{
			"id" : "0000688",
			"name" : "Sela Ward"
		},
		{
			"id" : "0000194",
			"name" : "Julianne Moore"
		},
		{
			"id" : "0001592",
			"name" : "Joe Pantoliano"
		}
	],
	"directors" : [
		{
			"id" : "0001112",
			"name" : "Andrew Davis"
		}
	]
}
{
	"_id" : "0103776",
	"name" : "Batman Returns",
	"year" : 1992,
	"rating" : "PG-13",
	"runtime" : 126,
	"genre" : "AYRT",
	"actors" : [
		{
			"id" : "0000474",
			"name" : "Michael Keaton"
		},
		{
			"id" : "0000362",
			"name" : "Danny DeVito"
		},
		{
			"id" : "0000201",
			"name" : "Michelle Pfeiffer"
		},
		{
			"id" : "0000686",
			"name" : "Christopher Walken"
		},
		{
			"id" : "0001284",
			"name" : "Michael Gough"
		}
	],
	"directors" : [
		{
			"id" : "0000318",
			"name" : "Tim Burton"
		}
	]
}

//2.
db.books.find({"$or":[{"$and":[{"author":{"$size":3}},{"$or":[{"author":"Martin Fowler"},{"author":"Sam Ruby"}]}]},{"$and":[{"author":{"$size":5}},{"$or":[{"author":"Martin Fowler"},{"author":"Sam Ruby"}]}]}]},{"_id":0,"title":1,"author":1}).count()
2

db.books.find({"$or":[{"$and":[{"author":{"$size":3}},{"$or":[{"author":"Martin Fowler"},{"author":"Sam Ruby"}]}]},{"$and":[{"author":{"$size":5}},{"$or":[{"author":"Martin Fowler"},{"author":"Sam Ruby"}]}]}]},{"_id":0,"title":1,"author":1}).pretty()
{
	"author" : [
		"Martin Fowler",
		"Kent Beck",
		"John Brant",
		"William Opdyke",
		"Don Roberts"
	],
	"title" : "Refactoring: Improving the Design of Existing Code"
}
{
	"author" : [
		"Sam Ruby",
		"David Thomas",
		"David Heinemeier Hansson"
	],
	"title" : "Agile Web Development with Rails"
}

//3.
db.books.find({"$and":[{"title":/^Ag/},{"publicationYear":{"$lt":2011}},{"tags.18":{"$exists":true}},{"tags":/.*agile.*/},{"tags":/.*software.*/}]},{"_id":0,"publicationYear":1,"author":1}).count()
1

db.books.find({"$and":[{"title":/^Ag/},{"publicationYear":{"$lt":2011}},{"tags.18":{"$exists":true}},{"tags":/.*agile.*/},{"tags":/.*software.*/}]},{"_id":0,"publicationYear":1,"author":1}).pretty()
{ "author" : [ "Mike Cohn" ], "publicationYear" : 2006 }

//4.
db.tweets.find({"$and":[{"entities.hashtags.0":{"$exists":true}},{"entities.hashtags.text":"love"},{"user.followers_count":{"$gt":555}}]},{"_id":0,"user.name":1,"entities.hashtags":1,"user.followers_count":1}).count()
1

db.tweets.find({"$and":[{"entities.hashtags.0":{"$exists":true}},{"entities.hashtags.text":"love"},{"user.followers_count":{"$gt":555}}]},{"_id":0,"user.name":1,"entities.hashtags":1,"user.followers_count":1}).pretty()
{
	"entities" : {
		"hashtags" : [
			{
				"text" : "love",
				"indices" : [
					37,
					42
				]
			},
			{
				"text" : "hate",
				"indices" : [
					43,
					48
				]
			},
			{
				"text" : "sex",
				"indices" : [
					49,
					53
				]
			},
			{
				"text" : "celebrity",
				"indices" : [
					54,
					64
				]
			},
			{
				"text" : "Gossip",
				"indices" : [
					65,
					72
				]
			}
		]
	},
	"user" : {
		"name" : "Hot Celebrity",
		"followers_count" : 558
	}
}

//5.
    //resposta amb $limit 20
db.tweets.aggregate([
    {
        "$group":{
            "_id":"$user.name",
            "tweets_totals":{"$sum":1}
        }
    },
    {
        "$project":{
            "_id":0,
            "nom usuari":"$_id",
            "num de tweets escrits":"$tweets_totals"
        }
    },
    {
        "$sort":{
            "num de tweets escrits":-1
        }
    },
    {
        "$limit":20
    }
])
{ "nom usuari" : "Mysteriously Unnamed", "num de tweets escrits" : 21 }
{ "nom usuari" : "Sarah", "num de tweets escrits" : 21 }
{ "nom usuari" : "Ana Carolina", "num de tweets escrits" : 17 }
{ "nom usuari" : "Camila", "num de tweets escrits" : 17 }
{ "nom usuari" : "Laura", "num de tweets escrits" : 16 }
{ "nom usuari" : "Alex", "num de tweets escrits" : 15 }
{ "nom usuari" : "Kate", "num de tweets escrits" : 13 }
{ "nom usuari" : "Amanda", "num de tweets escrits" : 12 }
{ "nom usuari" : "Bruna", "num de tweets escrits" : 12 }
{ "nom usuari" : "Nicole", "num de tweets escrits" : 11 }
{ "nom usuari" : "Jessica", "num de tweets escrits" : 11 }
{ "nom usuari" : "Amy", "num de tweets escrits" : 11 }
{ "nom usuari" : "✔ Verified Belieber", "num de tweets escrits" : 11 }
{ "nom usuari" : "Chris", "num de tweets escrits" : 10 }
{ "nom usuari" : "Andrea", "num de tweets escrits" : 9 }
{ "nom usuari" : "Juliana", "num de tweets escrits" : 9 }
{ "nom usuari" : "Samantha", "num de tweets escrits" : 9 }
{ "nom usuari" : "Courtney", "num de tweets escrits" : 9 }
{ "nom usuari" : "Kelly", "num de tweets escrits" : 9 }
{ "nom usuari" : "Mike", "num de tweets escrits" : 9 }

    //resposta sense $limit
db.tweets.aggregate([
    {
        "$group":{
            "_id":"$user.name",
            "tweets_totals":{"$sum":1}
        }
    },
    {
        "$project":{
            "_id":0,
            "nom usuari":"$_id",
            "num de tweets escrits":"$tweets_totals"
        }
    },
    {
        "$sort":{
            "num de tweets escrits":-1
        }
    }
])
{ "nom usuari" : "Sarah", "num de tweets escrits" : 21 }
{ "nom usuari" : "Mysteriously Unnamed", "num de tweets escrits" : 21 }
{ "nom usuari" : "Ana Carolina", "num de tweets escrits" : 17 }
{ "nom usuari" : "Camila", "num de tweets escrits" : 17 }
{ "nom usuari" : "Laura", "num de tweets escrits" : 16 }
{ "nom usuari" : "Alex", "num de tweets escrits" : 15 }
{ "nom usuari" : "Kate", "num de tweets escrits" : 13 }
{ "nom usuari" : "Amanda", "num de tweets escrits" : 12 }
{ "nom usuari" : "Bruna", "num de tweets escrits" : 12 }
{ "nom usuari" : "✔ Verified Belieber", "num de tweets escrits" : 11 }
{ "nom usuari" : "Amy", "num de tweets escrits" : 11 }
{ "nom usuari" : "Jessica", "num de tweets escrits" : 11 }
{ "nom usuari" : "Nicole", "num de tweets escrits" : 11 }
{ "nom usuari" : "Chris", "num de tweets escrits" : 10 }
{ "nom usuari" : "Courtney", "num de tweets escrits" : 9 }
{ "nom usuari" : "Fernanda", "num de tweets escrits" : 9 }
{ "nom usuari" : "Juliana", "num de tweets escrits" : 9 }
{ "nom usuari" : "Andrea", "num de tweets escrits" : 9 }
{ "nom usuari" : "Mike", "num de tweets escrits" : 9 }
{ "nom usuari" : "Kelly", "num de tweets escrits" : 9 }
Type "it" for more
