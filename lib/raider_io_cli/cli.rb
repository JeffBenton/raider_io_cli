class RaiderIoCli::Cli
  
  def call
    puts "Hello from the Cli class"
    RaiderIoCli::Scraper.scrape("Sikz", "Stormrage", "us")
  end
end