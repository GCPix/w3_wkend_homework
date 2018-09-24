require_relative("../db/sql_runner")
require('pry')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def self.find_all()
    sql = "SELECT * FROM films"
    film = SqlRunner.run(sql)
    film_array = film.map {|film| Film.new(film)}
    return film_array
  end
  def self.find_film_cost(id)
      film = find_film(id)
      film_cost = film.price
  end
  def self.find_film(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]

    film_array = SqlRunner.run(sql, values).first
    Film.new(film_array)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.delete_one(id)
    sql = "DELETE FROM films WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)

  end

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end

  def update
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)

  end

  def list_customer_detail
    sql = "SELECT c.* FROM customers c INNER JOIN tickets t ON c.id = t.customer_id WHERE t.film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    customer_array = customers.map{|customer| Customer.new(customer)}
      return customer_array

  end

  def count_customers
    return customer_count = list_customer_detail.count
  end


end
