class RaiderIoCli::Cli
  
  def call
    puts "Welcome to the Raider.io CLI"
    puts "Follow the prompts to retrieve your character information."
    get_character_info
    fetch_character
    while @input != 'exit' || @input != "4"
      show_options
      get_user_input
      case @input
      when "1"
        @player.show_info
      when "2"
        @player.show_recent_runs
      when "3"
        select_dungeon
      end
    end
    quit
  end

  def get_character_info
    @info = []
    puts "Enter the character name"
    @info << get_user_input
    puts "Enter the server"
    @info << get_user_input
    puts "Enter the region (US/EU)"
    @info << get_user_input

    return @info if validate_character(@info[0], @info[1], @info[2])

    puts "The character you entered does not exist, press \"enter\" to try a different character, or type \"exit\" to quit."
    get_user_input
    get_character_info if @input == ""
  end

  def validate_character(name, server, region)
    RaiderIoCli::Scraper.validate_player(name, server, region)
  end

  def get_user_input
    @input = gets.strip
  end

  def fetch_character
    puts "Retrieving character information..."
    @player = RaiderIoCli::Scraper.scrape(@info[0], @info[1], @info[2])
    binding.pry
  end

  def show_options
    puts "Enter a number from the list of options below..."
    puts "1. Show character information"
    puts "2. Show recent runs"
    puts "3. Show best dungeon run"
    puts "4. Exit"
  end

  def select_dungeon

  end

  def quit
    RaiderIoCli::Scraper.unmount
    puts "Goodbye."
  end
end