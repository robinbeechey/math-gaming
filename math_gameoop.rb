require 'pry'
require 'colorize'

class Player

  attr_accessor :name, :lives, :score

  def initialize(name)
    @name = name
    @lives = 3
    @score = 0
  end

  def reset
    @lives = 3
  end

  def gain_point
    @score += 1
  end

  def lose_lives
    @lives -= 1
  end

end

module ExceptionErrors
  class InvalidInputError < StandardError
  end
end


class Game

  include ExceptionErrors

  def start
    @players = []
    create_players
    loop do
    players_in_game = @players.length
      while players_in_game > 1        
          @players.each do |player|
            @player = player
            if @player.lives > 0 && players_in_game > 1
              create_question
              if answer_correct?
                puts "Thats right!".colorize(:green)
                @player.gain_point
              else
                puts "Wrong! the answer was #{@answer}".colorize(:red)
                @player.lose_lives
              end
              if @player.lives == 0
                puts "#{@player.name.upcase}!, you're out with a final score of #{@player.score}".colorize(:blue)
                players_in_game -= 1
              end
            end
          end
      end

      @players.each do |player|
        @player = player
        if @player.lives > 0
          puts "The Winner is #{@player.name.upcase}! with a score of #{@player.score}".colorize(:green)
        end
      end
      break if play_again == false
    end
  end


  def play_again
    puts "Keep playing? y/n"
    input = gets.chomp
    if input == 'y'
      puts "If you would like to start all over hit 'start' or 'again' to just reset lives".blue
      input = gets.chomp
      case input
        when 'start' then start 
        when 'again' then reset_lives
        else puts "try again" 
        play_again  
      end          
    else
      false
    end
  end


  def reset_lives
    @players.each do |player|
      player.reset
    end
    players_in_game = @players.length
  end


  def answer_correct?
    guess = gets.chomp.to_i
    guess == @answer
  end


  # def create_question
  #   num1 = rand(1..4)
  #   num2 = rand(1..4)
  #   puts "#{@player.name} what is #{num1} + #{num2}".light_blue
  #   @answer = num1 + num2
  # end

  def create_question
    num1 = rand(1..20)
    num2 = rand(1..20)
    generate_sign = rand(1..3)
    if generate_sign == 1
      puts "#{@player.name} what is #{num1} + #{num2}".light_blue
      @answer = num1 + num2
    elsif generate_sign == 2
      puts "#{@player.name} what is #{num1} x #{num2}".light_blue
      @answer = num1 * num2
    elsif generate_sign == 3
      puts "#{@player.name} what is #{num1} - #{num2}".light_blue
      @answer = num1 - num2
    end
  end


  def create_players
    puts "Select how many players".black.on_light_green
    number_of_players = gets.chomp.to_i
    begin
      if (number_of_players > 1 && number_of_players <= 8)
         number_of_players.times do
          puts "Enter your name".white.on_light_blue 
          players_name = gets.chomp
          @players << Player.new(players_name)
        end    
      else
        raise InvalidInputError, 'There must be more than one and less than 8'.white.on_light_red.blink  
      end
        rescue InvalidInputError => e
        puts e.message
        create_players
    end

  end


end



new_game = Game.new
new_game.start





