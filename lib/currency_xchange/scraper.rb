class CurrencyXchange::Scraper

  @@list = []
  @@hash = {}
  @@hash2 = {}
  @@hash3 = {}
  @@currency = nil
  @@currency2 = nil
  @@amount = 1.0

  ##scrapes the index page of x-rates.com for the list of available currencies and their corresponding URL
  def self.scrape_index
    html = open("http://www.x-rates.com/")
    doc = Nokogiri::HTML(html)
    doc.css("ul.currencyList li a").each do |x|
      @@hash[x.text] = x.attr("href")
    end
    @@list = @@hash.keys
  end
  
  ##This provides the first input of the user, which can either be a search or the currency he wants to convert
  def self.process_main_input
    input = gets.chomp
      if input == "search"
        self.search_list
      elsif @@list.include?(input)
        @@currency = input
      else
        puts "Invalid entry. Please try again. Enter 'search' or name of currency"
        self.process_main_input
      end
  end  

  ##search method to run through the list of currencies
  def self.search_list
    results =[]
    puts "Enter starting letter of currency/country:"
    letter = gets.chomp
    if letter =~ /[a-zA-Z]/
      @@list.each do|currency| 
        if currency[0] == letter.upcase
          puts currency
          results << currency
        end
      end
      if results.size == 0
        puts "No results found."
      end
    else
      puts "Invalid letter. Try again"
       self.search_list
    end

    puts "Do you want to search again? Y/N"
       x = gets.chomp.upcase
       if x == "Y"
        search_list
      elsif x == "N"
        puts "Alright. Enter 'search' or name of currency"
        self.process_main_input
      else
        puts "Sorry. Invalid entry. Searching again..."
        self.search_list
      end
  end

  ##method to increase the amount of currency to convert
  def self.increase_amount
    puts "How many #{@@currency} do you want to convert? Commas(,) are not allowed. "
    num = gets.chomp.to_f
    @@amount = num
  end

  ##this method takes in the foreign currency for the output of the conversion
  def self.process_2nd_input
    puts "What currency do you like to convert to?"
    answer = gets.chomp
    if answer == @@currency
      puts "You can't have same currencies for conversion."
      self.process_2nd_input
    elsif @@list.include?(answer)
      @@currency2 = answer
    else
       puts "Invalid currency. Please try again:"
       self.process_2nd_input
    end
  end

  ##this method converts the local currency to the foreign currency using the amount given
  def self.convert
    html = open(@@hash[@@currency]+"&amount=#{@@amount}")#
    doc = Nokogiri::HTML(html)
    doc.css("table.tablesorter tbody tr").each do |x|
      @@hash2[x.css("td")[0].text] = x.css("td")[1].text
    end
    puts "Converting your money now..."
    puts " >> \n >>> \n >>>> \n >>>>>"
    puts " >>>>>> Your #{@@amount} in #{@@currency} is worth #{@@hash2[@@currency2]} in #{@@currency2}!"
    ##if the amount is more than 1, we show the base rate conversion of 1 local currency 
    if @@amount > 1.0
    html = open(@@hash[@@currency]+"&amount=1")#
    doc = Nokogiri::HTML(html)
    doc.css("table.tablesorter tbody tr").each do |x|
      @@hash3[x.css("td")[0].text] = x.css("td")[1].text
    end

    puts " \n >>>>>> 1 #{@@currency} is equal to #{@@hash3[@@currency2]} #{@@currency2}."
    end
  end

  
end





