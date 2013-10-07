class Analytics
  attr_accessor :options

  def initialize(areas)
    @areas = 
    set_options
  end

  def set_options
    @options = []

    @options << {:menu_id => 1, :menu_title =>'Areas Count', :method => how_many }
    @options << {:menu_id => 2, :menu_title => 'Smallest Population (non 0)', :method => :smallest_pop }
    @options << {:menu_id => 3, :menu_title => 'Larest Population', :method => :largest_pop }
    @options << {:menu_id => 4, :menu_title => 'How many zips in California?', :method => :california_zips }
    @options << {:menu_id => 5, :menu_title => 'Information for a given zip', :method => :zip_info }
    @options << {:menu_id => 6, :menu_title => 'Exit', :method => :exit }
  end

  def run(choice)
    opt = @options.select {|o| o[menu_id] == choice}.first  #what is the .first doing here?
    if opt.nil?
      print "Invalid choice"
    elsif opt[:method] != :exit #if the option chosen is valid and not Exit, 
      self.send opt[:method] #run the chosen option
      :done  #what is this?
    else
      opt[:method] #otherwise, exit

    end
  end

  def how_many
    print "There are #{areas.length} areas"
  end

  def smallest_pop
    sorted = @areas.sort do |x, y|
      x.estimated_population <=> y.estimated_population
    end

    smallest = sorted.drop_while { |i| i.estimated_population == 0}.first #drops all zips with 0 pop?
    print "#{smallest.city}, #{smallest.state} has the smallest population of #{smallest.estimated_population}."
  end

  def largest_pop
    sorted = @areas.sort do |x, y|
      x.estimated_population <=> y.estimated_population
    end

    largest = sorted.reverse.drop_while { |i| i.estimated_population == 0}.first
    print "#{largest.city}, #{largest.state} has the largest population of #{largest.estimated_population}."
  end

  def california_zips
    c = @areas.count {|a| a.state == "CA"}
    print "There are #{c} zip code matches in California."
  end

  def zip_info
    print "Enter zip:"

    zip = gets.strip.to_i 
    zips = @areas.select {|a| a.zipcode == zip}
    unless zips.empty?
      print ""
      zips.each {|z| print z}
    else
      print "Zip not found"
    end
  end


end

