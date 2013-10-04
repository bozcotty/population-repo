class Setup
  attr_accessor :areas
  
  def initialize 
    csv = CSVReader.new("./free-zipcode-database.csv")
  end

end
