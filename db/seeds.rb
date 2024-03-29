# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

p = Product.create(title: 'tout-terrain',
                   description: 'Es gibt Neuigkeiten aus dem Hause tout terrain: mit dem Vasco ist jetzt der erste lupenreine Graveller am Start, mit einer auf Rennlenker zugeschnittenen, sportlichen Geometrie. Der Rahmen ist, wie immer bei tout terrain, aus Stahl und hat eine Vielzahl an Montagemöglichkeiten fürs Gepäck.',
                   image: 'https://velophil.test/wp-content/uploads/2021/01/velophil-berlin-tout-terrain-Vasco-GT-275_Gravelbike-150x150.jpg 150w,https://velophil.test/wp-content/uploads/2021/01/velophil-berlin-tout-terrain-Vasco-GT-275_Gravelbike-297x198.jpg 297w,https://velophil.test/wp-content/uploads/2021/01/velophil-berlin-tout-terrain-Vasco-GT-275_Gravelbike-1160x773.jpg 1160w,https://velophil.test/wp-content/uploads/2021/01/velophil-berlin-tout-terrain-Vasco-GT-275_Gravelbike-100x67.jpg 100w,https://velophil.test/wp-content/uploads/2021/01/velophil-berlin-tout-terrain-Vasco-GT-275_Gravelbike-1000x667.jpg 1000w,https://velophil.test/wp-content/uploads/2021/01/velophil-berlin-tout-terrain-Vasco-GT-275_Gravelbike-1000x773.jpg 1000w,https://velophil.test/wp-content/uploads/2021/01/velophil-berlin-tout-terrain-Vasco-GT-275_Gravelbike-1000x666.jpg 1000w,https://velophil.test/wp-content/uploads/2021/01/velophil-berlin-tout-terrain-Vasco-GT-275_Gravelbike-660x440.jpg 660w,https://velophil.test/wp-content/uploads/2021/01/velophil-berlin-tout-terrain-Vasco-GT-275_Gravelbike-660x660.jpg 660w,https://velophil.test/wp-content/uploads/2021/01/velophil-berlin-tout-terrain-Vasco-GT-275_Gravelbike-660x742.jpg 660w,https://velophil.test/wp-content/uploads/2021/01/velophil-berlin-tout-terrain-Vasco-GT-275_Gravelbike-373x248.jpg 373w,https://velophil.test/wp-content/uploads/2021/01/velophil-berlin-tout-terrain-Vasco-GT-275_Gravelbike-373x373.jpg 373w,https://velophil.test/wp-content/uploads/2021/01/velophil-berlin-tout-terrain-Vasco-GT-275_Gravelbike-373x420.jpg 373w',
                   price: 134_600)
p = Product.create(title: 'Stevens_8x',
                   description: 'Ausgesprochen edel, dieses Top-Modell aus der City Cross Reihe. Mit seinem sensationell geringen Gewicht und Top-Ausstattung bleiben keine Wünsche offen. Shimano Deore XT-Komponenten und seidenweich rollende Schwalbe G-One Reifen fordern zum Tempo machen auf. Der derzeit hellste b&m Scheinwerfer, der IQ-X mit 100 Lux, sorgt dafür, dass das auch bei Dunkelheit noch geht.  ',
                   image: 'https://velophil.test/wp-content/uploads/2018/07/Stevens_8x_lite_tour_gent_MY18-150x150.jpg 150w,https://velophil.test/wp-content/uploads/2018/07/Stevens_8x_lite_tour_gent_MY18-297x198.jpg 297w,https://velophil.test/wp-content/uploads/2018/07/Stevens_8x_lite_tour_gent_MY18-1160x773.jpg 1160w,https://velophil.test/wp-content/uploads/2018/07/Stevens_8x_lite_tour_gent_MY18-100x67.jpg 100w,https://velophil.test/wp-content/uploads/2018/07/Stevens_8x_lite_tour_gent_MY18-1000x667.jpg 1000w,https://velophil.test/wp-content/uploads/2018/07/Stevens_8x_lite_tour_gent_MY18-1000x773.jpg 1000w,https://velophil.test/wp-content/uploads/2018/07/Stevens_8x_lite_tour_gent_MY18-1000x666.jpg 1000w,https://velophil.test/wp-content/uploads/2018/07/Stevens_8x_lite_tour_gent_MY18-660x440.jpg 660w,https://velophil.test/wp-content/uploads/2018/07/Stevens_8x_lite_tour_gent_MY18-660x660.jpg 660w,https://velophil.test/wp-content/uploads/2018/07/Stevens_8x_lite_tour_gent_MY18-660x742.jpg 660w,https://velophil.test/wp-content/uploads/2018/07/Stevens_8x_lite_tour_gent_MY18-373x248.jpg 373w,https://velophil.test/wp-content/uploads/2018/07/Stevens_8x_lite_tour_gent_MY18-373x373.jpg 373w,https://velophil.test/wp-content/uploads/2018/07/Stevens_8x_lite_tour_gent_MY18-373x420.jpg 373w',
                   price: 184_600)
p = Product.create(title: 'Deore_XT_30g',
                   description: 'Leicht, schön und schnell ist es, das Topmodell unter den Trekkingrädern der Fahrradmanufaktur.',
                   image: 'https://velophil.test/wp-content/uploads/2018/03/08_T-700_Deore_XT_30g_Disc_Dia_DSC_8948-150x150.jpg 150w,https://velophil.test/wp-content/uploads/2018/03/08_T-700_Deore_XT_30g_Disc_Dia_DSC_8948-297x198.jpg 297w,https://velophil.test/wp-content/uploads/2018/03/08_T-700_Deore_XT_30g_Disc_Dia_DSC_8948-1160x773.jpg 1160w,https://velophil.test/wp-content/uploads/2018/03/08_T-700_Deore_XT_30g_Disc_Dia_DSC_8948-100x67.jpg 100w,https://velophil.test/wp-content/uploads/2018/03/08_T-700_Deore_XT_30g_Disc_Dia_DSC_8948-1000x667.jpg 1000w,https://velophil.test/wp-content/uploads/2018/03/08_T-700_Deore_XT_30g_Disc_Dia_DSC_8948-1000x773.jpg 1000w,https://velophil.test/wp-content/uploads/2018/03/08_T-700_Deore_XT_30g_Disc_Dia_DSC_8948-1000x666.jpg 1000w,https://velophil.test/wp-content/uploads/2018/03/08_T-700_Deore_XT_30g_Disc_Dia_DSC_8948-660x440.jpg 660w,https://velophil.test/wp-content/uploads/2018/03/08_T-700_Deore_XT_30g_Disc_Dia_DSC_8948-660x660.jpg 660w,https://velophil.test/wp-content/uploads/2018/03/08_T-700_Deore_XT_30g_Disc_Dia_DSC_8948-660x742.jpg 660w,https://velophil.test/wp-content/uploads/2018/03/08_T-700_Deore_XT_30g_Disc_Dia_DSC_8948-373x248.jpg 373w,https://velophil.test/wp-content/uploads/2018/03/08_T-700_Deore_XT_30g_Disc_Dia_DSC_8948-373x373.jpg 373w,https://velophil.test/wp-content/uploads/2018/03/08_T-700_Deore_XT_30g_Disc_Dia_DSC_8948-373x420.jpg 373w',
                   price: 2_234_600)
# 100.times do
#   Product.create(
#     title: Faker::Lorem.word,
#     description: Faker::Lorem.paragraphs(2),
#     price: Faker::Commerce.price,
#     image: Faker::Image.image
#   )
user = User.create! name: ENV['SHOPIFY_API_USER_NAME'], email: ENV['SHOPIFY_API_USER_EMAIL'], password: ENV['SHOPIFY_API_USER_PASSWORD'],
                    password_confirmation: ENV['SHOPIFY_API_USER_PASSWORD']
