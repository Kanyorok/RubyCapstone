require_relative './music/music'
require_relative './music/genre'
require 'json'

class Mainclass
  def initialize
    load_music
  end

  def load_music
    @music = []
    return unless File.file?('./lib/jsonfiles/music.json') && !File.empty?('./lib/jsonfiles/music.json')

    song_data = JSON.parse(File.read('./lib/jsonfiles/music.json'))
    song_data.each do |song_info|
      @music << Music.new(song_info['publish_date'], song_info['on_spotify'])
    end
  end

  def list_music
    load_music
    if @music.empty?
      puts 'No new music recorded'
    else
      @music.each_with_index do |song, index|
        puts "#{index} ID: #{song.id}, Publish Date: #{song.publish_date}, On Spotify: #{song.on_spotify}"
      end
    end
  end

  def create_music(publish_date, on_spotify)
    load_music
    music = Music.new(publish_date, on_spotify)
    @music << music
    existing_songs = []
    existing_songs = JSON.parse(File.read('./lib/jsonfiles/music.json')) if File.file?('./lib/jsonfiles/music.json')
    existing_songs << { id:music.id, publish_date: music.publish_date, on_spotify: music.on_spotify }
    # Write the combined data back to the file
    File.write('./lib/jsonfiles/music.json', JSON.pretty_generate(existing_songs))
  end
end