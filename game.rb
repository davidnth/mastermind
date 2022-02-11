
# generates an array of 4 random numbers 
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
        @arr
    end 

    def guess(secret_code)
        @arr = input
        @tries -= 1
        clue(@arr, secret_code)
        @arr 
    end
    
    # feedback on the guess
    def clue(arr, secret_code)
        string = ''
        @arr.each_with_index do |val, index|
            string << 'o' if val == secret_code[index] 
            string << 'x'if secret_code.include? val unless val == secret_code[index] || string.count('x') == secret_code.count(val)
        end 
        clue = string.chars.sort.join
        p clue 
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
    string.chars.all? {|char| char.between?('1','6')} && string.length == 4
end 


def generate_code
    arr = Array.new(4).map {|k| k = rand(1..6)}
end

def game_over?(player, computer)
    if player.tries == 0
        puts 'You are out of guesses. Better luck next time!' 
        return true
    end
    if player.clue(player.arr, computer.code) == 'oooo' 
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

computer = Computer.new(generate_code)
p computer.code
player = Player.new
play_round(player, computer)

