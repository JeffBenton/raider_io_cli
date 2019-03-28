class RaiderIoCli::Player
  attr_accessor :guild, :info, :ilvl, :hoa, :score, :prog, :recent_runs
  attr_reader :name, :server, :region, :best_runs

  def initialize(name, server, region)
    @name = name.capitalize
    @server = server
    @region = region
    @recent_runs = []
    @best_runs = {}
  end

  def show_info
    puts "#{@name} #{@guild}"
    puts "#{@info}"
    puts "#{@ilvl} ilvl #{@hoa} HoA lvl"
    puts "M+ Score: #{@score}"
    puts "Raid Progression: #{prog}"
  end

  def format_score(score)
    @score = score[1..score.length-2].delete(",").to_f.round
  end

  def show_recent_runs
    if @score == 0
      puts "No recent runs detected."
      return
    end
    @recent_runs.each do|run|
      puts "#{run.level}#{run.stars} #{run.nick_name} #{run.date}"
    end
  end

  def add_best_run(run)
    @best_runs[run.nick_name.to_sym] = run
  end

  def show_best_run(nick_name)
    @best_runs[nick_name.to_sym].display_run
  end
end