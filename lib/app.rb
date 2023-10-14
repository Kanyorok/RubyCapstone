require_relative 'app_data'
require 'date'

Mainclass.new

def created_book(inf)
  inf.create_book
end

def created_music(inf)
  inf.create_music
end

def created_game(inf)
  inf.add_game
end

def list_music(inf)
  puts 'The Music Data'
  puts ''
  inf.list_music
end

def list_authors(inf)
  inf.list_all_authors
  puts ''
end

def list_games(inf)
  puts 'The Games Data'
  puts ''
  inf.list_games
end

def list_books(inf)
  puts 'The books Data'
  puts ''
  inf.list_book
end

def list_games(inf)
  puts 'The games Data'
  puts ''
  inf.list_games
end

def list_labels(inf)
  puts 'The labels Data'
  puts ''
  inf.list_labels
end

def list_genres(inf)
  puts 'The genre Data'
  puts ''
  inf.list_genres
end

def exit_message(inf)
  inf.save_data
  puts 'Saving Data...'
  puts 'Thank you for using our catalogue app!'
end

ACTIONS = {
  '1' => {
    prompt: 'Create a book',
    handler: method(:created_book)
  },
  '2' => {
    prompt: 'Create a music album',
    handler: method(:created_music)
  },
  '3' => {
    prompt: 'Create a game',
    handler: method(:created_game)
  },
  '4' => {
    prompt: 'List all books',
    handler: method(:list_books)
  },
  '5' => {
    prompt: 'List all music album',
    handler: method(:list_music)
  },
  '6' => {
    prompt: 'List all games',
    handler: method(:list_games)
  },
  '7' => {
    prompt: 'List all labels',
    handler: method(:list_labels)
  },
  '8' => {
    prompt: 'List all genres',
    handler: method(:list_genres)
  },
  '9' => {
    prompt: 'List all authors',
    handler: method(:list_authors)
  },
  '0' => {
    prompt: 'Exit',
    handler: method(:exit_message)
  }
}.freeze
