require_relative 'lib/setup'
require_relative 'lib/analytics'

class Population
  attr_accessor :analytics

  def initialize
    areas = Setup.new().areas #a little confusing
    @analytics = Analytics.new(areas)
  end

  def menu
    system 'clear' #?
    puts "Population Menu"
    puts "_______________"
    @analytics.options.each do |opt|
      puts "#{opt[:menu_id]}. #{opt[:menu_title]}"
    end
  end

  def run
    stop = false
    while stop != :exit do
      self.menu
      print "Choice: "
      choice = gets.strip.to_i
      stop = @analytics.run(choice) #calling the run method from the analytics file
      if stop == :exit
        print "Exiting"
      else
        print "\nHit enter to continue "
        gets
      end
    end
  end


end

p = Population.new
p.run

