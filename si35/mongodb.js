use upc-si35

db.students.insertOne({last_name: "Campos",
                        first_name: "Julio"})

db.students.insertOne({last_name: "Fuentes",
                        first_name: "Marcos",
                        age: 18})

db.students.insertOne({last_name: "Paredes",
                        first_name: "Ana",
                        age: 19,
                        courses: ["Redes", "IHC", "Diseño de base datos"]})

db.students.deleteOne({first_name: "Julio", last_name: "Campos"})

db.students.updateOne({first_name: "Luis", last_name: "Fuentes"}, {$set:
    {city: 'Lima'}
  })

db.students.find().count()

db.students.find({age: { $gt: 17} })


use upc-si35

db.students.insertOne({last_name: "Campos",
                        first_name: "Julio"})

db.students.insertOne({last_name: "Fuentes",
                        first_name: "Marcos",
                        age: 18})

db.students.insertOne({last_name: "Paredes",
                        first_name: "Ana",
                        age: 19,
                        courses: ["Redes", "IHC", "Diseño de base datos"]})

db.students.deleteOne({first_name: "Julio", last_name: "Campos"})

db.students.updateOne({first_name: "Luis", last_name: "Fuentes"}, {$set:
    {city: 'Lima'}
  })

db.students.find().count()

db.students.find({age: { $gt: 17} })


use upc-si35
db.createCollection("alojamientos", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["nombre", "calificacion"],
            properties: {
                nombre: {
                    bsonType: "string"
                }
            }
        }
    }
})

db.alojamientos.insertOne({nombre: "Casa de campos"})
db.alojamientos.find()

db.getCollection("alojamientos").drop()

db.createCollection("alojamiento",
    {
        validator: {
            $jsonSchema: {
                bsonType: "object",
                required: ["nombre", "ubicacion","fecha","precio","anfitrion","servicios"],
                properties: {
                    nombre: {
                        bsonType: "string"
                    },
                    ubicacion: {
                        bsonType: "object",
                        required: ["ciudad", "pais"]
                    },
                    fecha: {
                        bsonType: "date",
                    },
                    precio: {
                        bsonType: "double"
                    },
                    anfitrion: {
                        bsonType: "object",
                        required: ["nombre"]
                    },
                    servicios: {
                        bsonType: "array",
                        items: {
                           bsonType: "string"
                        },
                        uniqueItems: true,
                        minItems: 1
                    }
                }
            }
        }
    }
)


db.runCommand({
    collMod: "alojamientos",
    validator: {
            $jsonSchema: {
                bsonType: "object",
                required: ["nombre", "ubicacion","fecha","precio","anfitrion","servicios"],
                properties: {
                    nombre: {
                        bsonType: "string"
                    },
                    ubicacion: {
                        bsonType: "object",
                        required: ["ciudad", "pais"]
                    },
                    fecha: {
                        bsonType: "date",
                    },
                    precio: {
                        bsonType: "double"
                    },
                    anfitrion: {
                        bsonType: "object",
                        required: ["nombre"]
                    },
                    servicios: {
                        bsonType: "array",
                        items: {
                           bsonType: "string"
                        },
                        uniqueItems: true,
                        minItems: 1
                    }
                }
            }
        },
})





db.alojamientos.insertOne({ nombre: "Casa de campo",
                            anfitrion: {
                                nombre: "Ximena"
                            },
                            precio: 99.99,
                            servicios: ["cocina", "aire acondicionado"],
                            ubicacion: {
                                ciudad: "Huancayo",
                                pais: "Perú"
                            },
                            fecha: new Date()
                           })




db.alojamientos.updateOne({nombre: "Casa de playa"}, {
        $set: {
            precio: 199.99
        }
})

db.alojamientos.find()




