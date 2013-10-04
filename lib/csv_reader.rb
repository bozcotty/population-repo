class CSVReader
  attr_accessor :fname, :headers
  

  def initialize(filename)
    @fname = filename
  end

  def headers=(header_str) 
    # this is named headers for row 1 of the csv
    
    @headers = header_str.split(',') #creating comma sep values array of row 1

    @headers.map! do |h| #the do/end bloc is required with the map! method

      h.gsub('"', '') #even though working withing an array, we're running  
      #string methods on the individual strings within the array
      #here, we're taking away quotes around the strings

      h.strip! #same deal - a string method on individual strings within the array
      #here, we're taking out any possible new lines in the string

      h.underscore.to_sym #convert to a symbol. (:symbol) - a lesser memory hog than a class
    end
     
  end
  def create_hash(values)
    h = {}
    @headers.each_with_index do |header, i|
      #remove new lines from the value
      value = values[i].strip.gsub('"', '')
      h[header] = value unless value.empty? 
    end
    h
  end

  def read
    f = File.new(@fname, 'r')

    self.header = f.readline #grab the headers (readline is a module that reads
      #one inputted line)

    #loop over the lines
    while(!f.eof? && next_line = f.readline) #"while file is not at end of file AND
      # next_line???? is.....
      # need to discuss next_line
      values = next_line.split(',')
      hash = create_hash(values)
      yield(hash)
    end
  end

end


class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    tr(" ", "_").
    downcase
  end
end


