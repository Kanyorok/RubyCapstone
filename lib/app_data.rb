require_relative 'music/music'
require_relative 'music/genre'
require_relative 'book/book'
require_relative 'book/label'
require_relative 'games/game'
require_relative 'games/author'
require_relative 'modules/game_module'
require_relative 'modules/author_module'
require_relative 'modules/book_module'
require_relative 'modules/label_module'
require_relative 'modules/music_module'
require_relative 'modules/genre_module'
require 'json'

class Mainclass
  include GameModule
  include AuthorModule
  include BookModule
  include LabelModule
  include MusicModule
  include GenreModule

  def initialize
    @genres = []
    @music = []
    @labels = []
    @author_info = []
    @authors = []
    @games = []
    @existing_books = []
    load_data
  end

  def load_data
    @games = load_games
    @authors = load_authors
    @existing_books = load_book
    @labels = load_label
    @music = load_music
    @genres = load_genre
  end

  def save_data
    save_games
    save_authors
    save_book
    save_label
    save_music
    save_genre
  end

  def list_games
    if @games.empty?
      puts 'No new games recorded'
    else
      @games.each_with_index do |game, index|
        puts "#{index})
        Title: #{game.title},
        Multiplayer: #{game.multiplayer},
        Last Played: #{game.last_played_at},
        Publish Date: #{game.publish_date},
        Archived: #{game.archived}"
      end
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

  def list_book
    if @existing_books.empty?
      puts 'No new books recorded'
    else
      @existing_books.each_with_index do |book, index|
        puts "#{index}) ID: #{book.id}, Publish Date: #{book.publish_date},
        Publisher: #{book.publisher}"
      end
    end
  end

  def list_genres
    if @genres.empty?
      puts 'No genres recorded'
    else
      @genres.each_with_index do |song, index|
        puts "#{index}) ID: #{song.id}, Genre Name: #{song.name}"
      end
    end
  end

  def list_labels
    if @labels.empty?
      puts 'No label recorded'
    else
      @labels.each_with_index do |labels, index|
        puts "#{index}) ID: #{labels.id}, Label Name: #{labels.title}, Color Name: #{labels.color}"
      end
    end
  end
end
