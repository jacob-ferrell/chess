require 'yaml'

class NewOrLoad
    def initialize
      new_or_load
    end
  
    def new_or_load
      puts "\nEnter 1 to play a new game, or press 2 to load an existing save:"
      choice = gets.chomp.to_i
      choice == 1 ? Game.new : choice == 2 ? load_save : invalid_input
    end
  
    def invalid_input
      puts "\nInvalid input."
      new_or_load
    end

    def load_save
      file_name = get_save_name
      file = YAML.load_file("saves/#{file_name}.yml")
      player_1 = file['current_player']
      player_2 = file['players'].reject { |player| player === player_1 }.first
      board = file['board']
      Game.new(player_1, player_2, board)
    end

    def get_save_name
      puts "\nEnter the name of the save you wish to load:"
      file = gets.chomp
      if File.exist?("saves/#{file}.yml")
        file
      else
        puts "\nThat save file does not exist"
        new_or_load 
      end
    end
  end