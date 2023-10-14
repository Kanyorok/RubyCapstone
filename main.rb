require_relative 'lib/app_data'
require_relative 'lib/app'

inf = Mainclass.new

def main(inf)
  puts 'Welcome to the Catalog of my things App!'
  loop do
    puts ''
    ACTIONS.each_pair do |action_id, action|
      puts "#{action_id} - #{action[:prompt]}"
    end

    chosen_id = gets.chomp

    ACTIONS[chosen_id][:handler].call(inf)
    break if chosen_id == '0'
  end
end

main(inf)
