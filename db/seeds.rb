# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Ferrari = Constructor.create(name:'Ferrari', engine: 'Ferrari')
Mercedes = Constructor.create(name:'Mercedes', engine: 'Mercedes')
Red_Bull = Constructor.create(name:'Red Bull', engine: 'Renault')
Force_India = Constructor.create(name:'Force India', engine: 'Mercedes')

Driver.create(name:'Sebastian Vettel', number: 5, constructor: Ferrari)
Driver.create(name:'Kimi Raikkonen', number: 7, constructor: Ferrari)
Driver.create(name:'Lewis Hamilton', number: 44, constructor: Mercedes)
Driver.create(name:'Nico Rosberg', number: 6, constructor: Mercedes)
Driver.create(name:'Daniel Ricciardo', number: 3, constructor: Red_Bull)
Driver.create(name:'Daniil Kyvat', number: 26, constructor: Red_Bull)
Driver.create(name:'Nico Hulkenberg', number: 27, constructor: Force_India)
Driver.create(name:'Sergio Perez', number: 11, constructor: Force_India)