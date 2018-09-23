require('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

Screening.delete_all
Ticket.delete_all
Film.delete_all
Customer.delete_all



customer1 = Customer.new({"name" => "Gillian", "funds" => 50})
customer1.save()
customer2 = Customer.new({"name" => "Dana", "funds" => 100})
customer2.save()
customer3 = Customer.new({"name" => "Evie", "funds" => 20})
customer3.save()
customer4 = Customer.new({"name" => "Pixie", "funds" => 5})
customer4.save()
customer5 = Customer.new({"name" => "Peter", "funds" => 15})
customer5.save()
customer6 = Customer.new({"name" => "Andrew", "funds" => 150})
customer6.save()

film1 = Film.new({"title" => "Steel Magnolias", "price" => 5})
film1.save()
film2 = Film.new({"title" => "Speed", "price" => 5})
film2.save()
film3 = Film.new({"title" => "Buddy", "price" => 3})
film3.save()
film4 = Film.new({"title" => "Scream", "price" => 4})
film4.save()
film5 = Film.new({"title" => "Star Trek", "price" => 7})
film5.save()

screening1 = Screening.new({"film_id" => film1.id, "max_seats" => 5, "seats_available" => 5, "start_time" => "12:00"})
screening1.save()
screening2 = Screening.new({"film_id" => film2.id, "max_seats" => 5, "seats_available" => 5, "start_time" => "17:00"})
screening2.save()
screening3 = Screening.new({"film_id" => film3.id, "max_seats" => 5, "seats_available" => 5, "start_time" => "00:00"})
screening3.save()
screening4 = Screening.new({"film_id" => film4.id, "max_seats" => 5, "seats_available" => 5, "start_time" => "16:00"})
screening4.save()

ticket1 = Ticket.new({"film_id" => film1.id, "customer_id" => customer3.id, "screening_id" => screening1.id})
ticket1.save()
ticket2 = Ticket.new({"film_id" => film4.id, "customer_id" => customer1.id, "screening_id" => screening4.id})
ticket2.save()
ticket3 = Ticket.new({"film_id" => film3.id, "customer_id" => customer2.id, "screening_id" => screening3.id})
ticket3.save()
ticket4 = Ticket.new({"film_id" => film1.id, "customer_id" => customer5.id,  "screening_id" => screening1.id})
ticket4.save()
ticket5 = Ticket.new({"film_id" => film2.id, "customer_id" => customer3.id, "screening_id" => screening2.id})
ticket5.save()
ticket6 = Ticket.new({"film_id" => film3.id, "customer_id" => customer1.id, "screening_id" => screening3.id})
ticket6.save()
ticket7 = Ticket.new({"film_id" => film2.id, "customer_id" => customer4.id, "screening_id" => screening2.id})
ticket7.save()
ticket8 = Ticket.new({"film_id" => film1.id, "customer_id" => customer4.id, "screening_id" => screening1.id})
ticket8.save()











binding.pry
nil
