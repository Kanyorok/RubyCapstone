require_relative 'music/music'
require_relative 'music/genre'
require_relative 'book/book'
require_relative 'book/label'
require 'json'

class Mainclass
  def initialize
    load_music
    load_genres
    load_book
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

        @books << book_record
      end
    rescue JSON::ParserError => e
      # Handle JSON parsing errors (e.g., invalid JSON format)
      puts "Error parsing JSON: #{e}"
    end
  end

  def load_music
    @music = []
    return unless File.file?('./lib/jsonfiles/music.json') && !File.empty?('./lib/jsonfiles/music.json')

    song_data = JSON.parse(File.read('./lib/jsonfiles/music.json'))
    song_data.each do |song_info|
      @music << Music.new(song_info['publish_date'], song_info['on_spotify'], song_info['archived'])
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
        puts "#{index} ID: #{song.id}, Publish Date: #{song.publish_date},
        On Spotify: #{song.on_spotify}, Archived: #{song.archived}"
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

  def create_music(publish_date, on_spotify, archived)
    load_music
    music = Music.new(publish_date, on_spotify, archived)
    @music << music
    existing_songs = []
    existing_songs = JSON.parse(File.read('./lib/jsonfiles/music.json')) if File.file?('./lib/jsonfiles/music.json')
    existing_songs << { id: music.id, publish_date: music.publish_date, on_spotify: music.on_spotify,
                        archived: music.archived }
    # Write the combined data back to the file
    File.write('./lib/jsonfiles/music.json', JSON.pretty_generate(existing_songs))
  end

  def create_genre(name)
    load_genres
    genre = Genre.new(name)
    @genre << genre
    existing_genres = []
    existing_genres = JSON.parse(File.read('./lib/jsonfiles/genres.json')) if File.file?('./lib/jsonfiles/genres.json')
    existing_genres << { id: genre.id, name: genre.name }
    # Write the combined data back to the file
    File.write('./lib/jsonfiles/genres.json', JSON.pretty_generate(existing_genres))
  end
  
  def create_book(publisher, cover_state, publish_date, archived)
    load_book
    bookdata = Book.new(publisher, cover_state, publish_date, archived)
    @books << bookdata
    existing_books = []
    if File.file?('./lib/jsonfiles/books.json') && !File.empty?('./lib/jsonfiles/books.json')
      existing_books = JSON.parse(File.read('./lib/jsonfiles/books.json'))
    end
    existing_books << { id: bookdata.id, publisher: bookdata.publisher, cover_state: bookdata.cover_state, publish_date: bookdata.publish_date,
                        archived: bookdata.archived }
    # Write the combined data back to the file
    File.write('./lib/jsonfiles/books.json', JSON.pretty_generate(existing_books))
  end
end

