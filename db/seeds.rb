# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

doctors = Doctor.create([{name: 'Hous', position: 'diagnostician', img: 'https://hips.hearstapps.com/digitalspyuk.cdnds.net/17/24/1497535738-hugh.jpg'},
                         {name: 'Cuddy', position: 'therapist', img: 'https://mtbifiction.files.wordpress.com/2015/06/dr-lisa-cuddy-dr-lisa-cuddy-32055718-1024-768.png'},
                         {name: 'Cameron', position: 'diagnostician', img: 'https://i.pinimg.com/originals/75/dc/a9/75dca9f5ba5eaf8c095942f5e02f555c.jpg'}])


users = User.create([{name: 'Ivan', email: 'ivan@gmail.com', password: '111111', role: 'admin'},
                     {name: 'Anna', email: 'anna@gmail.com', password: '111111', role: 'admin'},
                     {name: 'Roman', email: 'roman@gmail.com', password: '111111', role: 'user'},
                     {name: 'Petro', email: 'petro@gmail.com', password: '111111'}]
                    )