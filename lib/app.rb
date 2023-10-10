require_relative './app_data'
require 'date'

inf = Mainclass.new

def created_music(inf)
  print 'Publish Date: '
  publish_date = gets.chomp
	# Input validation
	date_pattern = %r{\A\d{4}/\d{2}/\d{2}\z}
	until publish_date.match?(date_pattern)
		puts "\nPlease enter the date in the format: YYYY/MM/DD"
		publish_date = gets.chomp
	end
	# parse publish_date into Date object
	publish_date = Date.parse(publish_date)
  print 'On Spotify (Y/N): '
  on_spotify = gets.chomp.upcase
  inf.create_music(publish_date, on_spotify)
  puts 'Album created successfully'
end

def list_music(inf)
  puts 'The Music Data'
  puts ''
  inf.list_music
end

def exit_message(_inf)
  puts 'Thank you for using our catalogue app!'
end

ACTIONS = {
  '1' => {
    prompt: 'Create a book'
  },
  '2' => {
    prompt: 'Create a music album',
		handler: method(:created_music)
  },
  '3' => {
    prompt: 'Create a game'
  },
  '4' => {
    prompt: 'List all books'
  },
  '5' => {
    prompt: 'List all music album',
    handler: method(:list_music)
  },
  '6' => {
    prompt: 'List all games'
  },
  '7' => {
    prompt: 'List all labels'
  },
  '8' => {
    prompt: 'List all genres'
  },
  '9' => {
    prompt: 'List all authors'
  },
  '0' => {
    prompt: 'Exit',
    handler: method(:exit_message)
  }
}.freeze
