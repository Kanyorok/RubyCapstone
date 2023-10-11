require_relative 'music/music'
require_relative 'music/genre'
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
