require 'pry-byebug'
require 'colorize'
class Computer
  attr_accessor :code

  def initialize(generate_code)
    @code = generate_code
  end
end

class Player
  attr_accessor :tries, :arr

  def initialize
    @tries = 12
  
  end

  # gets code from player, runs clue
  def guess(secret_code)
    @arr = input
    @tries -= 1
    p clue(secret_code)
    @arr
  end

  # returns feedback out of order
  def clue(secret_code)
    string = ''
    check_guess(@arr, secret_code, string)
    string.chars.sort.join
  end

  # generates feedback based off secret code and guess
  def check_guess(guess, secret_code, string)
    secret_sub = remove_matches(guess, secret_code, string)

    guess_sub = arr_sub(guess, secret_code)

    secret_sub.each do |val|
      if guess_sub.include?(val)
        string << 'x'
        guess_sub.delete_at(guess_sub.index(val))
      end
    end
  end

  # checks for exact matches and creates a subarray of the secret code without them
  def remove_matches(arr, secret_code, string)
    secret_code.select.with_index do |val, index|
      string << 'o' if val == arr[index]

      val unless val == arr[index]
    end
  end

  # checks for exact matches in the guess
  def arr_sub(guess, secret_code)
    guess.select.with_index do |val, index|
      val unless val == secret_code[index]
    end
  end
end

def input
  loop do
    puts 'Enter a 4-digit code.'
    num = gets.chomp

    return num.to_i.digits.reverse if valid_input?(num)

    puts 'You have incorrectly entered the code. Please try again.'
  end
end

def valid_input?(string)
  string.chars.all? { |char| char.between?('1', '6') } && string.length == 4
end

def generate_code
  Array.new(4).map { |k| k = rand(1..6) }
end

def game_over?(player, computer)
  if player.tries.zero?
    puts 'You are out of guesses. Better luck next time!'
    return true
  end
  if player.clue(computer.code) == 'oooo'
    puts 'You have successfully cracked the code. Nice!'
    return true
  end
  false
end

def play_round(player, computer)
  loop do
    puts "You have #{player.tries} tries remaining."
    player.guess(computer.code)
    break if game_over?(player, computer)
  end
end

# come back to this later
def creator_or_guesser
  puts "Enter '1' to be the guesser or '2' to be the creator."
  loop do
    selection = gets
    break if %w[1 2].include? selection
  end
end

computer = Computer.new(generate_code)
p computer.code
player = Player.new

play_round(player, computer)

