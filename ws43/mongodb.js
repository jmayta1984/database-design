use upc

db.students.insertOne(
    {
        last_name: "Paredes",
        first_name: "Carmen"
    }
)

db.students.insertOne(
    {
        last_name: "Miranda",
        first_name: "Luis",
        age: 18
    }
)

db.students.updateOne({first_name: "Carmen", last_name: "Paredes"}, {
    $set: {
        age: 17
    }
})

db.students.updateOne({first_name: "Luis", last_name: "Miranda"},{
    $unset: {
        age: ""
    }
})

db.students.deleteOne({first_name: "Carmen", last_name: "Paredes"})

db.students.insertOne({first_name: "Juan", last_name: "Quinta",
   ubicacion: {
        ciudad: "Lima",
        pais: "Peru"
   }
})

db.students.insertOne({first_name: "Jazmin", last_name: "Perez",
   ubicacion: {
        ciudad: "Lima",
        pais: "Peru"
   },
   cursos: [
        {nombre: "IHC", profesor: "Juan Valdivia"},
        {nombre: "Redes", profesor: "Carlos Fuentes"}
   ]
})

db.students.find()
