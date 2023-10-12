require_relative 'music/music'
require_relative 'music/genre'
require 'json'

class Mainclass
  def initialize
    load_music
    load_genres
    @add_genre = []
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

  def create_music(publish_date, on_spotify, archived, _genre_name = 'true')
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
end
