require_relative 'music/music'
require_relative 'music/genre'
require_relative 'book/book'
require_relative 'book/label'
require_relative 'games/game'
require 'json'

class Mainclass
  def initialize
    load_music
    load_genres
    load_book
    load_label
    @add_label = []
  end

  def load_label
    @label = []
    return unless File.file?('./lib/jsonfiles/labels.json') && !File.empty?('./lib/jsonfiles/labels.json')

    label_data = JSON.parse(File.read('./lib/jsonfiles/labels.json'))
    label_data.each do |label_info|
      @label << Label.new(label_info['label'], label_info['color'])
    end
  end

  def load_book
    @books = []
    json_file_path = './lib/jsonfiles/books.json'
    return unless File.file?(json_file_path) && !File.empty?(json_file_path)

    begin
      book_data = JSON.parse(File.read(json_file_path))

      book_data.each do |book_info|
        book_record = Book.new(
          book_info['publisher'],
          book_info['cover_state'],
          book_info['publish_date'],
          book_info['archived']
        )
        book_record.label = book_info['label']
        @books << book_record
      end
    rescue JSON::ParserError => e
      # Handle JSON parsing errors (e.g., invalid JSON format)
      puts "Error parsing JSON: #{e}"
    end
  end

  def load_game
    @games = []
    json_file_path = './lib/jsonfiles/games.json'
    return unless File.file?(json_file_path) && !File.empty?(json_file_path)

    begin
      game_data = JSON.parse(File.read(json_file_path))

      game_data.each do |game_info|
        game_record = Game.new(
          game_info['title'],
          game_info['multiplayer'],
          game_info['last_played_at'],
          game_info['publish_date'],
          game_info['archived']
        )

        @books << game_record
      end
    rescue JSON::ParserError => e
      # Handle JSON parsing errors (e.g., invalid JSON format)
      puts "Error parsing JSON: #{e}"
    end
  end

  def load_music
    @music = []

    # Check if the JSON file exists and is not empty
    json_file_path = './lib/jsonfiles/music.json'
    return unless File.file?(json_file_path) && !File.empty?(json_file_path)

    begin
      song_data = JSON.parse(File.read(json_file_path))

      song_data.each do |song_info|
        music_record = Music.new(
          song_info['publish_date'],
          song_info['on_spotify'],
          song_info['archived']
        )
        music_record.genre = song_info['genre']

        @music << music_record
      end
    rescue JSON::ParserError => e
      # Handle JSON parsing errors (e.g., invalid JSON format)
      puts "Error parsing JSON: #{e}"
    end
  end

  def load_genres
    @genre = []
    return unless File.file?('./lib/jsonfiles/genres.json') && !File.empty?('./lib/jsonfiles/genres.json')

    song_data = JSON.parse(File.read('./lib/jsonfiles/genres.json'))
    song_data.each do |song_info|
      @genre << Genre.new(song_info['name'])
    end
  end

  def list_music
    load_music
    if @music.empty?
      puts 'No new music recorded'
    else
      @music.each_with_index do |song, index|
        puts "
        #{index})
        ID: #{song.id},
        Publish Date: #{song.publish_date},
        On Spotify: #{song.on_spotify},
        Archived: #{song.archived},
        Genre: #{song.genre}
        "
      end
    end
  end

  def list_games
    load_game
    if @games.empty?
      puts 'No new games recorded'
    else
      puts "#{index} ID: #{game.id}, Publish Date: #{game.publish_date},
      Publisher: #{game.publisher}"
    end
  end

  def list_book
    load_book
    if @books.empty?
      puts 'No new books recorded'
    else
      @books.each_with_index do |book, index|
        puts "#{index} ID: #{book.id}, Publish Date: #{book.publish_date},
        Publisher: #{book.publisher}, Label: #{book.label}"
      end
    end
  end

  def list_genres
    load_genres
    if @genre.empty?
      puts 'No genres recorded'
    else
      @genre.each_with_index do |song, index|
        puts "#{index}) ID: #{song.id}, Genre Name: #{song.name}"
      end
    end
  end

  def list_labels
    load_label
    if @label.empty?
      puts 'No label recorded'
    else
      @label.each_with_index do |labels, index|
        puts "#{index}) ID: #{labels.id}, Label Name: #{labels.title}, Color Name: #{labels.color}"
      end
    end
  end

  def create_label(title, color)
    load_label
    label = Label.new(title, color)
    @label << label
    existing_labels = []
    if File.file?('./lib/jsonfiles/labels.json') && !File.empty?('./lib/jsonfiles/labels.json')
      existing_labels = JSON.parse(File.read('./lib/jsonfiles/labels.json'))
    end
    existing_labels << { id: label.id, label: label.title, color: label.color }
    # Write the combined data back to the file
    File.write('./lib/jsonfiles/labels.json', JSON.pretty_generate(existing_labels))
    @add_label = label.title
  end

  def create_genre(name)
    load_genres
    genre = Genre.new(name)
    @genre << genre
    existing_genres = []
    if File.file?('./lib/jsonfiles/genres.json') && !File.empty?('./lib/jsonfiles/genres.json')
      existing_genres = JSON.parse(File.read('./lib/jsonfiles/genres.json'))
    end
    existing_genres << { id: genre.id, name: genre.name }
    # Write the combined data back to the file
    File.write('./lib/jsonfiles/genres.json', JSON.pretty_generate(existing_genres))
    @add_genre = genre.name
  end

  def create_music(publish_date, on_spotify, archived)
    load_music
    new_gen = @add_genre
    music = Music.new(publish_date, on_spotify, archived)
    @music << music
    existing_songs = []
    if File.file?('./lib/jsonfiles/music.json') && !File.empty?('./lib/jsonfiles/music.json')
      existing_songs = JSON.parse(File.read('./lib/jsonfiles/music.json'))
    end
    existing_songs << { id: music.id, publish_date: music.publish_date, on_spotify: music.on_spotify,
                        archived: music.archived, genre: new_gen }
    # Write the combined data back to the file
    File.write('./lib/jsonfiles/music.json', JSON.pretty_generate(existing_songs))
  end

  def create_book(publisher, cover_state, publish_date, archived)
    load_book
    new_label = @add_label
    bookdata = Book.new(publisher, cover_state, publish_date, archived)
    @books << bookdata
    existing_books = []
    if File.file?('./lib/jsonfiles/books.json') && !File.empty?('./lib/jsonfiles/books.json')
      existing_books = JSON.parse(File.read('./lib/jsonfiles/books.json'))
    end
    existing_books << { id: bookdata.id, publisher: bookdata.publisher, cover_state: bookdata.cover_state,
                        publish_date: bookdata.publish_date, archived: bookdata.archived, label: new_label }
    # Write the combined data back to the file
    File.write('./lib/jsonfiles/books.json', JSON.pretty_generate(existing_books))
  end

  def create_game(title, multiplayer, last_played_at, publish_date, archived)
    load_game
    gamedata = Game.new(title, multiplayer, last_played_at, publish_date, archived)
    @games << gamedata
    existing_games = []
    if File.file?('./lib/jsonfiles/games.json') && !File.empty?('./lib/jsonfiles/games.json')
      existing_games = JSON.parse(File.read('./lib/jsonfiles/games.json'))
    end
    existing_games << { id: gamedata.id, multiplayer: gamedata.multiplayer, last_played_at: gamedata.last_played_at,
                        publish_date: gamedata.publish_date, archived: gamedata.archived }
    # Write the combined data back to the file
    File.write('./lib/jsonfiles/games.json', JSON.pretty_generate(existing_games))
  end
end
