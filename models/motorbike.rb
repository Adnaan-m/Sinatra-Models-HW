class Motorbike

  attr_accessor :id, :make, :year, :model

  def self.open_connection
    conn = PG.connect( dbname: 'motorbikes')
  end

  # in the controller, we'll call the save method like movie.save so we can use self. To access the properties of the movie (eg title, year, actors)
  def save
    conn = Motorbike.open_connection
    # IF the class instance we are running the save process on has no ID then create, else update
    if !self.id
      sql = "INSERT INTO motorbikes (make, year, model) VALUES ('#{self.make}', '#{self.year}','#{self.model}')"
    else
      sql = "UPDATE motorbikes SET make= '#{self.make}', year='#{self.year}', model='#{self.model}' WHERE id='#{self.id}'"
    end
    conn.exec(sql)
  end

  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM motorbikes"
    results = conn.exec(sql)

    motorbikes = results.map do |tuple|
      self.hydrate tuple
    end
  end

  def self.find id
    conn = self.open_connection
    sql = "SELECT * FROM motorbikes WHERE id=#{id}"
    results = conn.exec(sql)

    motorbikes = self.hydrate results.first

    motorbikes

  end

  def self.destroy id
    conn = self.open_connection
    sql = "DELETE FROM motorbikes WHERE id = #{id}"
    conn.exec(sql)
  end

  def self.hydrate bike_data
    bike = Motorbike.new

    bike.id = bike_data['id']
    bike.make = bike_data['make']
    bike.year = bike_data['year']
    bike.model = bike_data['model']

    bike
  end

end
