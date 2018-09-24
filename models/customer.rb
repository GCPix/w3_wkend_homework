require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def self.find_all()
    sql = "SELECT * FROM customers"
    customers_list = SqlRunner.run(sql)
    customer_array = customers_list.map {|customer| Customer.new(customer)}
    return customer_array
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.delete_one(id)
    sql = "DELETE FROM customers WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end
  def self.find_customer(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]

    customer_array = SqlRunner.run(sql, values).first
    Customer.new(customer_array)
  end

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    add_customer = SqlRunner.run(sql, values).first
    @id = add_customer['id'].to_i
  end

  def update
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]

    SqlRunner.run(sql, values)
  end

  def list_films_seen
    sql = "SELECT * from films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    film_list = results.map{|film| Film.new(film)}
  end

  def count_tickets_bought
    return list_of_films = list_films_seen.count

  end




end
