class CurrencyXchange::CLI


  def start
    puts "\n <<<<<<<<        CURRENCY X-CHANGE         >>>>>>>>\n "
    puts "\n <<<<<<<<    LIVE RATES from x-rates.com   >>>>>>>>\n "
    puts "You can choose from the following, or search for your local currency in our directory"
    puts " \n___________________________________________________________"
    puts "    US Dollar     |       Euro        |    British Pound \n-----------------------------------------------------------\n   Indian Rupee   | Australian Dollar |   Canadian Dollar \n-----------------------------------------------------------\n Singapore Dollar |    Swiss Franc    |  Malaysian Ringgit "
    puts "___________________________________________________________\n "
    puts "Let's start, what's your currency?"
    puts "---------------------------------\n "
    puts "If you like to search for other currencies, please type 'search': "
    CurrencyXchange::Scraper.scrape_index
    CurrencyXchange::Scraper.process_main_input
    CurrencyXchange::Scraper.increase_amount
    CurrencyXchange::Scraper.process_2nd_input
    CurrencyXchange::Scraper.convert
    again
  end

  def again
  	puts " \n-------------------------------------"
    puts "Awesome. What do you want to do next? "
    puts "-------------------------------------"
    puts " \nWould you like to convert to another currency?            - enter 1"
    puts "Would you like to select a new currency?                  - enter 2"
    puts "Would you like to change the amount you want to convert?  - enter 3"
    puts "Enter any key to terminate the program:"
    
    key = gets.chomp
    if key == "1"
      CurrencyXchange::Scraper.process_2nd_input
      CurrencyXchange::Scraper.convert
      self.again
    elsif key == "2"
      puts "Enter your currency or search through our list"
      CurrencyXchange::Scraper.process_main_input
      CurrencyXchange::Scraper.increase_amount
      CurrencyXchange::Scraper.process_2nd_input
      CurrencyXchange::Scraper.convert
      self.again
    elsif key == "3"
      CurrencyXchange::Scraper.increase_amount
      CurrencyXchange::Scraper.convert
      self.again
    else
      puts "Thank you for using 'Currency X-Change' Goodbye!"
    end
  end

end
 
