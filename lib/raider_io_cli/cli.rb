class RaiderIoCli::Cli
  
  def call
    puts "Welcome to the Raider.io CLI"
    puts "Follow the prompts to retrieve your character information."
    get_character_info
    fetch_character
    main_menu
    quit
  end

  def main_menu
    while @input != 'exit' && @input != "4"
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
  end

  def show_options
    puts "\n"
    puts "Enter a number from the list of options below..."
    puts "1. Show character information"
    puts "2. Show recent runs"
    puts "3. Show best dungeon run"
    puts "4. Exit"
  end

  def select_dungeon
    puts "Enter a dungeon name or number from the list below or type \"back\" to go back."
    RaiderIoCli::Dungeon.list_dungeons
    while @input != "back"
      get_user_input
      case @input.downcase
      when "1" || "ad" || "atal'dazar"
        @player.show_best_run('AD')
      when "2" || "fh" || "freehold"
        @player.show_best_run('FH')
      when "3" || "td" || "tol dagor"
        @player.show_best_run('TD')
      when "4" || "undr" || "the underrot"
        @player.show_best_run('UNDR')
      when "5" || "tos" || "temple of sethraliss"
        @player.show_best_run('TOS')
      when "6" || "wm" || "waycrest manor"
        @player.show_best_run('WM')
      when "7" || "kr" || "kings' rest"
        @player.show_best_run('KR')
      when "8" || "siege" || "siege of boralus"
        @player.show_best_run('SIEGE')
      when "9" || "ml" || "the motherlode!!"
        @player.show_best_run('ML')
      when "10" || "sots" || "shrine of the storm"
        @player.show_best_run('SOTS')
      when "list"
        RaiderIoCli::Dungeon.list_dungeons
      when "back"
        break
      else
        puts "Input not recognized, press \"enter\" to try again, or type \"back\" to go back."
        get_user_input
      end

      puts "\nEnter another dungeon, type \"list\" to display a list of dungeons, or type \"back\" to go back."

    end
  end

  def quit
    RaiderIoCli::Scraper.unmount
    puts "Goodbye."
  end
end