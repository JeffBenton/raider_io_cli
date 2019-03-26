class RaiderIoCli::Scraper
  
  @@browser = Watir::Browser.new(:chrome, headless: true)
  BASE_URL = "https://raider.io/characters"
  # raider.io/character/#{region}/#{server}/#{name}
  
  def self.scrape(name, server, region)
    url = "#{BASE_URL}/#{region}/#{server}/#{name}"
    @@browser.goto url
    @@browser.window.resize_to(1920, 1080)
    player = RaiderIoCli::Player.new(name, server, region)
    self.scrape_player(player)
    self.scrape_recent_runs(player)
    self.scrape_best_runs(player)
    binding.pry
  end
  
  def self.scrape_player(player)
    player.guild = @@browser.div(class: "slds-text-body--regular").text
    player.info = @@browser.h3(class: ["slds-text-body--regular", "class-color--1", "rio-text-shadow--normal"]).text
    player.ilvl = @@browser.spans(class: ["rio-badge", "rio-badge-size--small"]).first.text.delete " Item Level"
    player.hoa = @@browser.spans(class: ["rio-badge", "rio-badge-size--small"]).last.text.delete " Heart of Azeroth Level"
    player.prog = @@browser.divs(class: "slds-p-horizontal--x-small").last.text.split("\n").first
  end

  def self.scrape_recent_runs(player)
    recent_runs = []
    @@browser.sections(class: "rio-sidebar-section")[1].tbody.trs.each do|run|
      recent_runs << run.text.split("\n")
      recent_runs.last << run.is(class: "fa-star").length
    end

    recent_runs.each do |run|
      info = run.first.split(" ")
      player.recent_runs << RaiderIoCli::Dungeon.new(name: nil, nick_name: info.last, date: run[1], level: info.first, stars: run.last)
    end
  end

  def self.scrape_best_runs(player)
    @@browser.tbodys(class: "rio-striped").each do |dungeon|
      name = dungeon.td(data_label: "Dungeon Name").text.strip,
      level = dungeon.td(data_label: "Mythic Level").text,
      clear_time = dungeon.td(data_label: "Clear Time").text,
      score = dungeon.td(data_label: "Score").text,
      world_rank = dungeon.td(data_label: "World Rank").text,
      region_rank = dungeon.td(data_label: "Region Rank").text,
      affixes = dungeon.td(data_label: "Weekly Affixes").as.collect { |affix| affix.rel.delete "affix=" },
      stars = dungeon.is(class: "fa-star").length

      run = RaiderIoCli::Dungeon.new(name: name, nick_name: nil, date: nil, level: level, stars: stars)
      run.clear_time = clear_time
      run.score = score
      run.world_rank = world_rank
      run.region_rank = region_rank
      run.add_affixes(affixes)

      player.best_runs << run
    end
  end

  def self.unmount
    @@browser.close
  end
end
