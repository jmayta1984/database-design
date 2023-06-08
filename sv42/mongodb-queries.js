use demo

db.restaurants.find()

db.restaurants.find({cuisine: "American "})

db.restaurants.updateMany({cuisine: "American "}, { $set:{cuisine: "American"} })

db.restaurants.find({cuisine: "American", borough: "Queens"})

// Indicar el nombre de los restaurantes que se encuentran en Queens y sirven comida
// americana

db.restaurants.find(
    {cuisine: "American", borough: "Queens"},
    {_id: 0,name: 1}
    )

// Indicar todos los tipos de comida que preparan los restaurantes

db.restaurants.distinct("cuisine")

// Mostrar los nombre de los restaurantes y los distritos en los cuales se encuentra ubicados
db.restaurants.find({},{name:1, borough:1})

// Indicar los diferentes distritos donde se ubican los restaurantes
db.restaurants.distinct("borough")

// Indicar los distintos tipos de comida que se sirven en el distrito de Bronx

db.restaurants.distinct("cuisine", {"borough": "Bronx"})

// Indicar la cantidad de restaurantes que sirven comida Italian y se encuentran en Queens
db.restaurants.countDocuments({cuisine: "Italian", borough: "Queens"})

db.restaurants.find({cuisine: "Italian", borough: "Queens"}).count()

// Indicar los restaurantes que sirven como Irish

db.restaurants.find({cuisine: "Irish"})

db.restaurants.find({cuisine: {$eq: "Irish"}})

// Indicar todos los restaurantes que no sirven comida Mexican

db.restaurants.find({cuisine: {$ne: "Mexican"}})

// Indicar todos los restaurantes que sirven comida Mexican o comida Irish

db.restaurants.find({cuisine: {$in: ["Mexican", "Irish"]}})

// Indicar todos los restaurantes que no sirven comida Mexican ni comida Irish
db.restaurants.find({cuisine: {$nin: ["Mexican", "Irish"]}})

// Indicar los restaurantes que sirven comida Italian pero no se encuentran Bronx
db.restaurants.find({$and:
                    [{cuisine: "Italian"},
                    {borough: {$ne:"Bronx"}}]})

// Indicar todos los restaurantes que tienen al menos una calificación de A

db.restaurants.find({"grades.grade": "A"})

// Indicar todos los restaurantes que tienen al menos un punto mayor a 50

db.restaurants.find({"grades.score":{$gt: 50}})
