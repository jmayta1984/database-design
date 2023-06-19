use demo-sv42

// Buscar todos los restaurantes que sirven comidad Irish
db.restaurants.find({cuisine: 'Irish'})

// Mostrar todos los restaurantes que sirven comida Irish en Queens
db.restaurants.find({cuisine: 'Irish', borough: 'Queens'})

// Indicar la cantidad de restaurantes que sirven comida Irish en Queens
db.restaurants.find({cuisine: 'Irish', borough: 'Queens'}).count()

db.restaurants.countDocuments({cuisine: 'Irish', borough: 'Queens'})

// Mostrar los nombres de los restaurantes que sirven comida Irish en Queens
db.restaurants.find({cuisine: 'Irish', borough: 'Queens'}, {name: 1, _id:0} )

// Indicar los distintos distritos de los restaurantes
db.restaurants.distinct("borough")

// Indicar los distintos tipos de cocina de los restaurantes
db.restaurants.distinct("cuisine")

// Indicar los distintos tipos de cocina de los restaurantes en Queens
db.restaurants.distinct("cuisine", {borough: "Queens"})

// Indicar la cantidad de restaurantes
db.restaurants.find().count()

// Indicar la cantidad de restaurantes en Bronx que sirvan comida Mexican
db.restaurants.find({borough: "Bronx", cuisine: "Mexican"}).count()

// Indicar los restaurnates que sirvan comida Irish y que se encuentren en Bronx o en Queens
db.restaurants.find({cuisine:'Irish',borough: {$in: ['Bronx', 'Queens'] }})

db.restaurants.find({$and: [
    {cuisine: 'Irish'},
    {borough: {$in: ['Bronx', 'Queens']} }
]})

db.restaurants.find({$and: [
    {cuisine: 'Irish'},
    {$or: [{borough: 'Bronx'},
         {borough: 'Queens'}]}

]})

// Indicar los restaurantes que no sirvan comida Irish ni se encuentran en Queens
db.restaurants.find({$and: [
    {cuisine: {$ne: 'Irish'}},
    {borough: {$ne: 'Queens'}}
]})

db.restaurants.find({$nor: [
    {cuisine: 'Irish'},
    {borough: 'Queens'}
]})


// Indicar los restaurantes que tienen al menos una calificia A
db.restaurants.find({"grades.grade": 'A'}).count()

// Indicar la cantidad de restaurantes por cada distrito

db.restaurants.aggregate([
    {
        $group: {
            _id: '$borough',
            quantity: {$count: {}}
        }
    }
])

// Indicar los distritos que tienen mas 500 restaurantes

db.restaurants.aggregate([
    {
        $group: {
            _id: '$borough',
            quantity: {$count: {}}
        }
    },
    {
        $match: {
            quantity: {$gt: 500}
        }
    },
    {
        $project:{
            quantity: 1,
            _id: 0,
            borough: '$_id'
        }
    }
])

// Indicar la cantidad de restaurantes por tipo de comida que se encuentran en Queens

db.restaurants.aggregate([
    {
        $match: {borough: 'Queens'}
    },
    {
        $group: {
            _id: '$cuisine',
            quantity: { $count:{} }
        }
    }
])
