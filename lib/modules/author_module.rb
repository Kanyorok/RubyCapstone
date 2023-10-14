module AuthorModule
    def save_authors
      authors_data = []
      @authors.each do |author|
        authors_data << { first_name: author.first_name, last_name: author.last_name }
      end
      File.write('./lib/jsonfiles/authors.json', JSON.pretty_generate(authors_data))
    end
  
    def load_authors
      authorfile = './lib/jsonfiles/authors.json'.freeze
      if File.exist?(authorfile) && !File.empty?(authorfile)
        JSON.parse(File.read(authorfile)).map do |author|
          Author.new(author['first_name'], author['last_name'])
        end
      else
        []
      end
    end
  
    def list_all_authors
      if @authors.empty?
        puts 'No author found'
      else
        puts 'List of Authors'
      end
      @authors.each_with_index do |author, i|
        print "\n #{i + 1}) First Name: ", author.first_name, ', '
        print '-- Last Name: ', author.last_name
        puts " "
      end
    end
  end
  