require_relative("../db/sql_runner")

class Ticket

  attr_reader :id, :film_id, :customer_id, :screening_id


  def self.find_all()
    sql = "SELECT * FROM tickets"
    tickets_return = SqlRunner.run(sql)
    ticket_array = tickets_return.map {|ticket| Ticket.new(ticket)}
    return ticket_array
  end

  def self.find_one(id)
    sql = "SELECT * from tickets WHERE id = $1"
    values = [id]
    ticket_return = SqlRunner.run(sql, values).first
    ticket_array = Ticket.new(ticket_return)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.delete_one(id)
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [id]
    SqlRunner.run(sql,values)
  end

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id']
    @customer_id = options['customer_id']
    @screening_id = options['screening_id']
  end

  def save()
    sql = "INSERT INTO tickets
    (film_id, customer_id, screening_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@film_id, @customer_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

# no update as there isn't anything on ticket to update, everything is fixed

  def update_customer_funds()
    film_cost = Film.find_film_cost(@film_id)

    sql = "UPDATE customers SET funds = (funds - $1) WHERE customers.id = $2"
    values = [film_cost, @customer_id]

    SqlRunner.run(sql, values)
  end

  def update_seats_available
    #this might actually sit in screening but I think it should be in ticket, you update when the ticket is sold much like customer
    sql = "UPDATE screenings SET (film_id, start_time, max_seats, seats_available) = (film_id, start_time, max_seats, (seats_available-1)) WHERE id = $1"
    values = [@screening_id]
    SqlRunner.run(sql, values)
  end


end
