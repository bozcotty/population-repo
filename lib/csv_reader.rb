class CSVReader
  attr_accessor :fname, :headers
  

  def initialize(filename)
    @fname = filename
  end

  def headers=(header_str) 
    # is this for row 1? for a header we're either creating or-
    # the existing one in th csv db file?
    @headers = header_str.split(',') #creating comma sep values array?

    @headers.map! do |h| #doing two things at once:
      #map! and creating a block?

      h.gsub('"', '') #how am i running a string method on an array?

      h.strip! #same deal? explain new lines?

      h.underscore.to_sym #convert to a symbol. why to symbol?
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


def create_hash(values)
  h = {}
  @headers.each_with_index do |header, i|
    #remove new lines from the value
    value = values[i].strip.gsub('"', '')
    h[header] = value unless value.empty? 
  end
  h
end
