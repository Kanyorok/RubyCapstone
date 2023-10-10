def exit_message
  puts 'Thank you for using the library app!'
end

ACTIONS = {
  '1' => {
    prompt: 'Create a book'
  },
  '2' => {
    prompt: 'Create a music album'
  },
  '3' => {
    prompt: 'Create a game'
  },
  '4' => {
    prompt: 'List all books'
  },
  '5' => {
    prompt: 'List all music album'
  },
  '6' => {
    prompt: 'List all games'
  },
  '7' => {
    prompt: 'List all labels'
  },
  '8' => {
    prompt: 'List all genres'
  },
  '9' => {
    prompt: 'List all authors'
  },
  '0' => {
    prompt: 'Exit',
    handler: method(:exit_message)
  }
}.freeze
