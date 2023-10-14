require_relative '../music/music'
require_relative '../music/genre'
require 'json'

module MusicModule
  def create_music
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

    musicinfo = Music.new(publish_date, on_spotify, archived)
    @music << musicinfo

    print 'Do you want to add a genre to this song? (Y/N)'
    want_genre = gets.chomp.upcase

    return unless want_genre == 'Y'

    print 'Genre name: '
    genre_name = gets.chomp

    genreinfo = Genre.new(genre_name)
    @genres << genreinfo
    puts 'Music created successfully'
  end

  def load_music
    musicfile = './lib/jsonfiles/music.json'.freeze
    if File.exist?(musicfile) && !File.empty?(musicfile)
      JSON.parse(File.read(musicfile)).map do |music_info|
        Music.new(music_info['publish_date'],
                  music_info['on_spotify'],
                  music_info['archived'])
      end
    else
      []
    end
  end

  def save_music
    musicfile = './lib/jsonfiles/music.json'.freeze
    music_data = @music.map do |song|
      {
        'publish_date' => song.publish_date.to_s,
        'on_spotify' => song.on_spotify.to_s,
        'archived' => song.archived.to_s
      }
    end
    # Save the combined data back to the JSON file
    File.write(musicfile, JSON.pretty_generate(music_data))
  end
end
