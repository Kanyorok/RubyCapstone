require_relative '../book/book'
require_relative '../book/label'
require 'json'

module BookModule
  def create_book
    print 'Publisher: '
    pub = gets.chomp

    print 'Cover State: '
    covrstate = gets.chomp

    print 'Publish Date: '
    pdate = gets.chomp.upcase

    date_pattern = %r{\A\d{4}/\d{2}/\d{2}\z}
    until pdate.match?(date_pattern)
      puts "\nPlease enter the date in the format: YYYY/MM/DD"
      pdate = gets.chomp
    end

    # parse publish_date into Date object
    publish_date = Date.parse(pdate)

    print 'Archived (Y/N): '
    archived_input = gets.chomp.upcase
    archived = archived_input == 'Y'

    books = Book.new(pub, covrstate, publish_date, archived)
    @existing_books << books

    print 'Do you want to add a a label to this book? (Y/N)'
    want_label = gets.chomp.upcase

    return unless want_label == 'Y'

    print 'Label Title: '
    label_title = gets.chomp

    print 'Label Color: '
    label_color = gets.chomp

    labelinfo = Label.new(label_title, label_color)
    @labels << labelinfo
    puts 'Book added successfully'
  end

  def load_book
    bookfile = './lib/jsonfiles/books.json'.freeze
    if File.exist?(bookfile) && !File.empty?(bookfile)
      JSON.parse(File.read(bookfile)).map do |book_info|
        Book.new(book_info['publisher'],
                 book_info['cover_state'],
                 book_info['publish_date'],
                 book_info['archived'])
      end
    else
      []
    end
  end

  def save_book
    bookfile = './lib/jsonfiles/books.json'.freeze
    book_data = @existing_books.map do |book|
      {
        'publisher' => book.publisher.to_s,
        'cover_state' => book.cover_state.to_s,
        'publish_date' => book.publish_date.to_s,
        'archived' => book.archived.to_s
      }
    end
    # Save the combined data back to the JSON file
    File.write(bookfile, JSON.pretty_generate(book_data))
  end
end
