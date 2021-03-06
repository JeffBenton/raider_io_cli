class RaiderIoCli::Scraper
  
  @@browser = Watir::Browser.new(:chrome, headless: true)
  BASE_URL = "https://raider.io/characters"

  def self.scrape(name, server, region)
    url = "#{BASE_URL}/#{region}/#{server}/#{name}"
    @@browser.goto url
    @@browser.window.resize_to(1920, 1080)
    player = RaiderIoCli::Player.new(name, server, region)
    self.scrape_player(player)
    self.scrape_recent_runs(player)
    self.scrape_best_runs(player)
    player
  end

  def self.validate_player(name, server, region)
    url = "#{BASE_URL}/#{region}/#{server}/#{name}"
    @@browser.goto url
    !@@browser.div(class: "slds-modal__header").h2.exists?
  end

  def self.scrape_player(player)
    player.guild = @@browser.div(class: "slds-text-body--regular").text
    player.info = @@browser.h3(class: ["slds-text-body--regular", "rio-text-shadow--normal"]).text
    player.ilvl = @@browser.spans(class: ["rio-badge", "rio-badge-size--small"]).first.text.delete " Item Level"
    player.score = @@browser.divs(class: "rio-guild-rankings-table").last.span(class: "text-muted").exists? ?
                       @@browser.divs(class: "rio-guild-rankings-table").last.span(class: "text-muted").text : 0
    player.hoa = @@browser.spans(class: ["rio-badge", "rio-badge-size--small"]).last.exists? ?
                     @@browser.spans(class: ["rio-badge", "rio-badge-size--small"]).last.text.delete(" Heart of Azeroth Level") : 0
    player.prog = @@browser.divs(class: "slds-p-horizontal--x-small")[1].exists? ?
                      @@browser.divs(class: "slds-p-horizontal--x-small")[1].text.split("\n").first : "N/A"
    player.format_score(player.score) unless player.score == 0
  end

  def self.scrape_recent_runs(player)
    @@browser.sections(class: "rio-sidebar-section")[1].tbody.trs.each do|run|
      info = run.text.split("\n")
      info[0] = info[0].split(" ")
      info.flatten!
      player.recent_runs << RaiderIoCli::Dungeon.new(name: nil, nick_name: info[1], date: info[2], level: info[0], stars: run.is(class: "fa-star").length)
    end
  end

  def self.scrape_best_runs(player)
    @@browser.tbodys(class: "rio-striped").each do |dungeon|
      name = dungeon.td(data_label: "Dungeon Name").text.strip
      level = dungeon.td(data_label: "Mythic Level").text
      clear_time = dungeon.td(data_label: "Clear Time").text
      score = dungeon.td(data_label: "Score").text
      world_rank = dungeon.td(data_label: "World Rank").text
      region_rank = dungeon.td(data_label: "Region Rank").text
      affixes = dungeon.td(data_label: "Weekly Affixes").as.collect { |affix| affix.rel.delete "affix=" }
      stars = dungeon.is(class: "fa-star").length

      run = RaiderIoCli::Dungeon.new(name: name, nick_name: nil, date: nil, level: level, stars: stars)
      run.clear_time = clear_time
      run.score = score
      run.world_rank = world_rank
      run.region_rank = region_rank
      run.add_affixes(affixes)
      player.add_best_run(run)
    end
  end

  def self.unmount
    @@browser.close
  end
end
