use demo-cc47

// Mostrar todos los restaurantes
db.restaurants.find()

// Buscar todos los restaurantes que sirven comida American
db.restaurants.updateMany({cuisine: 'American '}, {$set: {cuisine: 'American'} })

db.restaurants.find({cuisine: 'American'})

// Buscar todos los restaurantas que sirven comida American y se encuentran en Queens
db.restaurants.find({cuisine: 'American', borough:'Queens'})

// Indicar la cantidad de todos los restaurantas que sirven comida American y se encuentran en Queens
db.restaurants.find({cuisine: 'American', borough:'Queens'}).count()

db.restaurants.countDocuments({cuisine: 'American', borough:'Queens'})

// Mostrar los nombres de los restaurantes que sirven comida Irish en Queens
db.restaurants.find({cuisine: 'Irish', borough: 'Queens'}, {name: 1, _id: 0})

// Indicar los distintos de tipos de comida que sirven
db.restaurants.distinct('cuisine')

// Indicar los distritos donde se sirve comida peruana
db.restaurants.distinct('borough', {cuisine: 'Peruvian'})

// Indicar todos los restaurantes que no sirven comida Mexican y se encuentran en Bronx
db.restaurants.find({borough: 'Bronx', cuisine: {$ne: 'Mexican'} })

// Indicar todos los restaurantes que se encuentran en Bronx o en Queens
db.restaurants.find({borough: {$in: ['Bronx', 'Queens']} })

db.restaurants.find({$or:[{borough: 'Bronx'},
                            {borough: 'Queens'}
                         ]  } )

db.restaurants.find({$or:[{borough: {$eq: 'Bronx'}},
                            {borough: {$eq: 'Queens'}}
                         ]  } )

// Indicar los restaurantes que no sirven comida Irish ni se encuentran en Queens
db.restaurants.find({cuisine: {$ne: 'Irish'}, borough: {$ne: 'Queens'}  })

db.restaurants.find({$and: [
                    {cuisine: {$ne: 'Irish'}},
                    {borough: {$ne: 'Queens'}}

]})

db.restaurants.find({$nor: [
    {cuisine: 'Irish'},
    {borough: 'Queens'}
]})

//Indicar los restaurantes que tienes al menos una calificación A
db.restaurants.find({"grades.grade": 'A' })

// Indicar los restaurantes que tiene 3 calificaciones
db.restaurants.find({grades:{$size:3} })

// Indicar los restaurantes que tienen al menos 4 calificaciones
db.restaurants.find({grades:{$gte:{$size: 4} }})

// Indicar la cantidad de restaurantes por cada distrito
db.restaurants.aggregate(
    [
     {
        $group: {
            _id: '$borough',
            quantity: {
                $count: {}
            }
        }
     }
    ]
)

// Indicar la cantidad de restaurantes por tipo de comida
db.restaurants.aggregate(
    [
       {$group: {
        _id: '$cuisine',
        quantity: {
            $count:{}
        }
       }}
    ]
)


// Indicar los distritos que tienen más de 500 restaurantes
db.restaurants.aggregate(
    [
     {
        $group: {
            _id: '$borough',
            quantity: {
                $count: {}
            }
        }
     },
     {
        $match : {
            quantity: {$gt: 500}
        }
     }
   ]
)


// Indicar la cantidad de restaurants por tipo de comida que se encuentren en Queens

db.restaurants.aggregate(
    [
       {
        $match: {
            borough:'Queens'
        }
       },
       {$group: {
        _id: '$cuisine',
        quantity: {
            $count:{}
        }
       }}
    ]
)
