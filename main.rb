require_relative 'lib/app'

def main()
  puts 'Welcome to the School Library App!'
  loop do
    puts ''
    ACTIONS.each_pair do |action_id, action|
      puts "#{action_id} - #{action[:prompt]}"
    end

    chosen_id = gets.chomp

    ACTIONS[chosen_id][:handler].call
    break if chosen_id == '0'
  end
end

main
