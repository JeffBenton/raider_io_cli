class RaiderIoCli::Scraper
  
  @@browser = Watir::Browser.new(:chrome, headless: true)
  BASE_URL = "https://raider.io/characters"
  # raider.io/character/#{region}/#{server}/#{name}
  
  def self.scrape(name, server, region)
    puts "hello"
    url = "#{BASE_URL}/#{region}/#{server}/#{name}"
    @@browser.goto url
    self.scrape_player(url)
  end
  
  def self.scrape_player(url)
    binding.pry
  end
  
  def self.unmount
    @@browser.close
  end
end
