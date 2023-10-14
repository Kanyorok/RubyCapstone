require_relative 'app_data'
require 'date'

Mainclass.new

def created_label(inf)
  print 'Do you want to add a a label to this book? (Y/N)'
  want_label = gets.chomp.upcase

  return unless want_label == 'Y'

  print 'Label Title: '
  label_title = gets.chomp

  print 'Label Color: '
  label_color = gets.chomp

  inf.create_label(label_title, label_color)
end

def created_book(inf)
  print 'Publisher: '
  pub = gets.chomp

  print 'Cover State: '
  covrstate = gets.chomp

  print 'Publish Date: '
  pdate = gets.chomp.upcase

  date_pattern = %r{\A\d{4}/\d{2}/\d{2}\z}
  until pdate.match?(date_pattern)
    puts "\nPlease enter the date in the format: YYYY/MM/DD"
    pdate = gets.chomp
  end

  # parse publish_date into Date object
  publish_date = Date.parse(pdate)

  print 'Archived (Y/N): '
  archived_input = gets.chomp.upcase
  archived = archived_input == 'Y'

  created_label(inf)
  inf.create_book(pub, covrstate, publish_date, archived)
  puts 'Book added successfully'
end

def created_author(inf)
  print 'Do you want to add the author of the game? (Y/N)'
  want_author = gets.chomp.upcase

  return unless want_author == 'Y'

  print 'First name: '
  author_fname = gets.chomp

  print 'Last name: '
  author_lname = gets.chomp

  inf.create_author(author_fname, author_lname)
end

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
  on_spotify_input = gets.chomp.upcase
  on_spotify = on_spotify_input == 'Y'

  print 'Archived (Y/N): '
  archived_input = gets.chomp.upcase
  archived = archived_input == 'Y'

  created_genre(inf)

  inf.create_music(publish_date, on_spotify, archived)
  puts 'Album created successfully'
end

def created_game(inf)
  inf.add_game
end

def created_genre(inf)
  print 'Do you want to add a genre to this song? (Y/N)'
  want_genre = gets.chomp.upcase

  return unless want_genre == 'Y'

  print 'Genre name: '
  genre_name = gets.chomp

  inf.create_genre(genre_name)
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
