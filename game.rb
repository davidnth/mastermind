
# generates an array of 4 random numbers 
class Computer
    attr_accessor :code

    def initialize(code)
        @code = code
    end 

end 

class Player
    attr_accessor :tries

    def initialize
        @tries = 12
    end 

    def guess
        puts "Enter a 4 digit code."
        arr = gets.to_i.digits.reverse
        @tries -= 1 
    end
     
    def clue(arr, code)
        string = ''
        arr.each_with_index do |val, index|
            string << 'o' if val == code[index] 
            string << 'x' if code.include? val unless val == code[index]
        end 
        p string.chars.sort.join 
    end 


end 

def code
    arr = Array.new(4).map {|k| k = rand(1..6)}
end

computer = Computer.new(code)
p computer.code