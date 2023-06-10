// base de datos -> colecciones -> documentos -> campos (llave/valor)

use airbnb

db.createCollection("alojamientos", {
	validator: {
		$jsonSchema: {
			bsonType: "object",
			required: ["nombre", "servicios", "ubicacion", "precio", "anfitrion"],
			properties: {
				nombre: {
					bsonType: "string"
				},
				servicios: {
					bsonType: "array",
					items: {
						bsonType: "string"
					}
				},
				ubicacion: {
					bsonType: "object",
					required: ["ciudad", "pais"],
					properties: {
						ciudad: {
							bsonType: "string"
						}
					}
				}
			}
		}
	}
})

db.alojamientos.insertOne(
    {
        nombre: "Casa de campo",
        anfitrion: "Ximena",
        precio: 199.99,
        servicios: ["cocina", "aire acondicionado"],
        ubicacion: {
            ciudad: "Lima",
            pais: "Peru"
        }
    }
)


db.alojamientos.insertOne(
    {
        nombre: "Casa de playa",
        anfitrion: false,
        precio: 399.99,
        servicios: ["WiFi", "aire acondicionado"],
        ubicacion: {
            ciudad: "Piura",
            pais: "Peru"
        }
    }
)
db.alojamientos.find()
