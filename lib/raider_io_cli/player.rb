class RaiderIoCli::Player
  attr_accessor :guild, :info, :ilvl, :hoa, :prog, :recent_runs, :best_runs
  attr_reader :name, :server, :region

  def initialize(name, server, region)
    @name = name
    @server = server
    @region = region
    @recent_runs = []
    @best_runs = []
  end

end