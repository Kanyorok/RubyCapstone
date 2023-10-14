module GenreModule
  def save_genre
    genre_data = []
    @genres.each do |genre|
      genre_data << { genre: genre.name }
    end
    File.write('./lib/jsonfiles/genres.json', JSON.pretty_generate(genre_data))
  end

  def load_genre
    genrefile = './lib/jsonfiles/genres.json'.freeze
    if File.exist?(genrefile) && !File.empty?(genrefile)
      JSON.parse(File.read(genrefile)).map do |gen|
        Genre.new(gen['genre'])
      end
    else
      []
    end
  end

  def list_all_genres
    if @genres.empty?
      puts 'No labels found'
    else
      puts 'List of labels'
    end
    @genres.each_with_index do |geninfo, i|
      print "\n #{i + 1}) Genre: ", geninfo.genre
      puts ' '
    end
  end
end
