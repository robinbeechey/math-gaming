require 'colorize'

@player1 = {
  lives: 3,
  score: 0,     
  name: [],
}

# @player1 = Player.new

@player2 = {
  lives: 3,
  score: 0,
  name: [],
}

# @player2 = Player.new


#game_controller, controls game loop and restart, 
#GETS : players name
#GETS : game_starter



def game_controller

  @game = true
  
  ask_for_players_name

    while @game == true

      game_starter

      puts "Want to play again? y/n"

      @restart = gets.chomp


      if @restart == 'n'

        @game = false

      elsif @restart == 'y'

        @game = true

      else

        puts "What?"
        @game = false

      end

    end 

end



#game_starter loops question for player then evaluates its if score 0
# then player 2.

def game_starter

  loop do 

  question_player1
     

      if (@player1[:lives] == 0 || @player2[:lives] == 0)

          puts "Game over! The winner is #{@player2[:name]}!".colorize(:light_blue)
          puts "Final score #{@player1[:name]} : #{@player1[:score]}, #{@player2[:name]} : #{@player2[:score]}".colorize(:blue)
          
          break

      end

       
  question_player2

      if (@player1[:lives] == 0 || @player2[:lives] == 0)

          puts "Game over! The winner is #{@player1[:name]}".colorize(:light_blue)
          puts "Final score #{@player1[:name]} : #{@player1[:score]}, #{@player2[:name]} : #{@player2[:score]}".colorize(:blue)

       break
          
    
      end 

  end    

end








#generates number asks question adds point, or deducts life

def question_player1    

  generate_number

  puts "#{@player1[:name]} what is #{@number} + #{@number2}"
  @player_answer = gets.chomp.to_i

          if @player_answer == @answer

            puts "Correct!".colorize(:green)

            @player1[:score] += 1

          else              

            @player1[:lives] -= 1                  

            puts "Thats incorrect, your current score is #{@player1[:score]}".colorize(:red)

          end

end



#same as question 1

def question_player2    

  generate_number

  puts "#{@player2[:name]} what is #{@number} + #{@number2}"
  @player_answer = gets.chomp.to_i

          if @player_answer == @answer

            puts "You got it".colorize(:green)

            @player2[:score] += 1
                    
          else              

            @player2[:lives] -= 1                  

            puts "Thats incorrect, your current score is #{@player2[:score]}".colorize(:red)

          end

end



#asks for players name, and puts it in hash

def ask_for_players_name

  puts "Player 1 type in your name"

   input1 = gets.chomp
   @player1[:name] = input1

  puts "Player 2 type in your name"

   input2 = gets.chomp
   @player2[:name] = input2

end


#generates random number, figures the sum of both

def generate_number
  
    @number = rand(1..20)
    @number2 = rand(1..20)
    @answer = @number + @number2

end

#initializer
game_controller




