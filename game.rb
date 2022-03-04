# player
class Player
  attr_accessor :tries, :arr, :current_feedback

  def initialize
    @tries = 12
  end

  # gets code from player, runs clue
  def guess(secret_code)
    @arr = input
    @tries -= 1
    p clue(secret_code)
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

# computer class is used when the player chooses to be the creator
class Computer < Player 
  attr_accessor :candidates, :arr

  def initialize
    super
    @candidates = (1111..6666).to_a.select { |num| num if num.digits.all? { |digit| digit.between?(1, 6) } }
  end

  def guess(secret_code)
    @arr = next_guess
    @tries -= 1
    @current_feedback = clue(secret_code)
    @arr
  end

  # returns 1122 on first guess and the first candidate otherwise
  def next_guess
    @tries == 12 ? [1, 1, 2, 2] : @candidates[0].digits.reverse
  end

  def filter_candidates
    @candidates = @candidates.select do |code|
      string = ''
      check_guess(code.digits.reverse, @arr, string)
      code if string == current_feedback
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
  Array.new(4).map { rand(1..6) }
end

def game_over?(player, secret_code)
  if player.tries.zero?
    puts 'You are out of guesses. Better luck next time!'
    return true
  end
  if player.clue(secret_code) == 'oooo'
    puts 'You have successfully cracked the code. Nice!'
    return true
  end
  false
end

def play_round(player, secret_code)
  loop do
    puts "You have #{player.tries} tries remaining."
    player.guess(secret_code)
    break if game_over?(player, secret_code)
  end
end

# player chooses to be creator or guesser
def creator?
  puts 'Would you like to be the creator or the guesser?'
  loop do
    selection = gets.chomp
    return true if selection == 'creator'
    return false if selection == 'guesser'

    puts 'Invalid selection. Do you want to be the creator or the guesser?'
  end
end

def computer_play(computer, secret_code)
  turns = 0
  loop do
    # puts "\nComputer has #{computer.tries} tries remaining" unless computer.tries == 12
    puts "Computer guesses: #{computer.guess(secret_code)}", "Feedback: #{computer.current_feedback}\n"
    puts "Computer has #{computer.tries} tries remaining.", "\n"
    computer.filter_candidates
    turns += 1 and sleep(1.5)
    break if computer.current_feedback == 'oooo'
  end

  puts "\nComputer figured out your code in #{turns} turns." if computer.current_feedback == 'oooo'
end

if creator?
  secret_code = input
  computer = Computer.new
  puts "Your code: #{secret_code}", "\n"
  computer_play(computer, secret_code)
else
  secret_code = generate_code

  player = Player.new

  play_round(player, secret_code)
end
