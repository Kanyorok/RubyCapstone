require_relative 'music/music'
require_relative 'music/genre'
require_relative 'book/book'
require_relative 'book/label'
require 'json'

class Mainclass
  def initialize
    load_music
    load_genres
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
end


class Mainclass
  def initialize
  load_book
  load_label
 end
 
 def load_book
  @book = []
  return unless File.file?('./lib/jsonfiles/books.json') && !File.empty?('./lib/jsonfiles/books.json')
  
  title_data = JSON.parse(File.read('./lib/jsonfiles/books.json'))
  title_data.each do |title_info|
    @book << Book.new(title_info['publish_date'],  title_info['archived'])
  end
  
 end

   def load_label
    @label = []
    return unless File.file?('./lib/jsonfiles/label.json') && !File.empty?('./lib/jsonfiles/labels.json')

    title_data = JSON.parse(File.read('./lib/jsonfiles/label.json'))
    title_data.each do |title_info|
      @label << Label.new(title_info['name'])
    end
  end

  def list_book
    load_book
    if @book.empty?
      puts 'No new book recorded'
    else
      @book.each_with_index do |book, index|
        puts "#{index} ID: #{book.id}, Publish Date: #{book.publish_date}, color: #{book.color}
         Archived: #{book.archived}"
      end
    end
  end


def create_book(publish_date, archived)
    load_book
    music = Book.new(publish_date, archived)
    @book << book
    existing_title = []
    existing_title = JSON.parse(File.read('./lib/jsonfiles/books.json')) if File.file?('./lib/jsonfiles/books.json')
    existing_titles << { id: book.id, publish_date: book.publish_date, 
                        archived: book.archived }
    # Write the combined data back to the file
    File.write('./lib/jsonfiles/books.json', JSON.pretty_generate(existing_books))
  end


  def list_labels
    load_labels
    if @label.empty?
      puts 'No labels recorded'
    else
      @label.each_with_index do |book, index|
        puts "#{index}) ID: #{title.id}, Labels title: #{book.title}"
      end
    end
  end

  def create_label(title)
    load_label
    label = Label.new(name)
    @label << label
    existing_label = []
    existing_label = JSON.parse(File.read('./lib/jsonfiles/genres.json')) if File.file?('./lib/jsonfiles/genres.json')
    existing_labelS << { id: label.id, title: label.title }
    # Write the combined data back to the file
    File.write('./lib/jsonfiles/labels.json', JSON.pretty_generate(existing_labels))
  end
end