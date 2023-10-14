require_relative '../games/game'
require_relative '../games/author'
require 'json'

module GameModule
  def add_game
    print 'Title: '
    title = gets.chomp

    print 'Is the game multiplayer? (yes/no): '
    multiplayer_input = gets.chomp.downcase
    multiplayer = multiplayer_input == 'yes'

    print 'Last Played Date: '
    play_date = gets.chomp

    # Input validation
    date_pattern = %r{\A\d{4}/\d{2}/\d{2}\z}
    until play_date.match?(date_pattern)
      puts "\nPlease enter the date in the format: YYYY/MM/DD"
      play_date = gets.chomp
    end

    # parse publish_date into Date object
    last_played_at = Date.parse(play_date)

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

    print 'Archived (Y/N): '
    archived_input = gets.chomp.upcase
    archived = archived_input == 'Y'

    game = Game.new(title, multiplayer, last_played_at, publish_date, archived)
    @games << game

    puts 'Author First and last name:'
    print 'FirstName: '
    author_first_name = gets.chomp
    print('LastName: ')
    author_last_name = gets.chomp
    author = Author.new(author_first_name, author_last_name)
    @authors << author
    puts 'Game added successfully with author'
  end

  def load_games
    gamefile = './lib/jsonfiles/game.json'.freeze
    if File.exist?(gamefile) && !File.empty?(gamefile)
      JSON.parse(File.read(gamefile)).map do |game_info|
        Game.new(game_info['title'],
                 game_info['multiplayer'],
                 game_info['last_played_at'],
                 game_info['publish_date'],
                 game_info['archived'])
      end
    else
      []
    end
  end

  def save_games
    gamefile = './lib/jsonfiles/game.json'.freeze
    game_data = @games.map do |game|
      {
        'title' => game.title.to_s,
        'multiplayer' => game.multiplayer.to_s,
        'last_played_at' => game.last_played_at.to_s,
        'publish_date' => game.publish_date.to_s,
        'archived' => game.archived.to_s
      }
    end
    # Save the combined data back to the JSON file
    File.write(gamefile, JSON.pretty_generate(game_data))
  end
end
