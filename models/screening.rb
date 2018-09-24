
require_relative("../db/sql_runner")
class Screening

  attr_reader :id, :film_id
  attr_accessor :max_seats, :seats_available, :start_time

  def self.find_all()
    sql = "SELECT * FROM screenings"
    screening_list = SqlRunner.run(sql)
    screening_array = screening_list.map {|screening| Screening.new(screening)}
    return screening_array
  end
#there must be a better way to do the next bits.
  def self.most_popular_view_key
    result = Ticket.find_all
    id_array = result.map{|screening| screening.screening_id}
    #can't take credit for the next line I had to look it up.
    counts = id_array.each_with_object(Hash.new(0)){|item, count| count[item] +=1}

    result = counts.each{|key, value|
      x= 0
      if
      value > x
      x=value
      end
        if value == x
        return key.to_i
        end}
        #return Screening.find_screening(result)
  end
# I can make it work if I bring the result out as below but not if it is written as above
  def self.show_popular_screening_details
      return Screening.find_screening(Screening.most_popular_view_key)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.delete_one(id)
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end
  def self.find_screening(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]

    screening_array = SqlRunner.run(sql, values).first
    Screening.new(screening_array)
  end

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @film_id = options["film_id"]
    @max_seats = options["max_seats"]
    @seats_available = options["seats_available"]
    @start_time = options["start_time"]
  end



  def save()
    sql = "INSERT INTO screenings (film_id, start_time, max_seats, seats_available) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@film_id, @start_time, @max_seats, @seats_available]
    add_screening = SqlRunner.run( sql, values ).first
    @id = add_screening['id'].to_i
  end

  def update
    sql = "UPDATE screenings SET (film_id, start_time, max_seats, seats_available) = ($1, $2) WHERE id = $5"
    values = [@film_id, @start_time, @max_seats, @seats_available, @id]

    SqlRunner.run(sql, values)
  end


end
