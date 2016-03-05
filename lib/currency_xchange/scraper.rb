class CurrencyXchange::Scraper

@list = []
@list2 = []
@hash = {}
@hash2 = {}
@currency = nil
@currency2 = nil
@amount = 1.0

def start
  html = open("http://www.x-rates.com/")
  doc = Nokogiri::HTML(html)
  doc.css("ul.currencyList li a").each do |x|
    @hash[x.text] = x.attr("href")
  end
  @list = @hash.keys

  puts "\n <<<<<<<<     HOW MUCH IS MY MONEY IN?     >>>>>>>>\n "
  puts "\n <<<<<<<<    LIVE RATES from x-rates.com   >>>>>>>>\n "
  puts "You can choose from the following, or search for your local currency in our directory"
  puts " \n___________________________________________________________"
  puts "    US Dollar     |       Euro        |    British Pound \n-----------------------------------------------------------\n   Indian Rupee   | Australian Dollar |   Canadian Dollar \n-----------------------------------------------------------\n Singapore Dollar |    Swiss Franc    |  Malaysian Ringgit "
  puts "___________________________________________________________\n "
  puts "Let's start, what's your currency?"
  puts "---------------------------------\n "
  puts "If you like to search for other currencies, please type 'search': "
  input = gets.chomp
    if input == "search"
      search_list
    else 
      process_input(input)
      @currency = input
      increase_amount
    end
  
  process_input2
  
end  

def increase_amount
  puts "How many #{@currency} do you want to convert? Commas(,) are not allowed. "
  num = gets.chomp.to_f
  @amount = num
end

def again?
  puts " \n-------------------------------------"
  puts "Awesome. What do you want to do next? "
  puts "-------------------------------------"
  puts " \nWould you like to convert to another currency?            - enter 1"
  puts "Would you like to select a new currency?                  - enter 2"
  puts "Would you like to change the amount you want to convert?  - enter 3"
  puts "Enter any key to terminate the program:"
  key = gets.chomp
  if key == "1"
    process_input2
  elsif key == "2"
    start
  elsif key == "3"
    increase_amount
    convert
  else
    puts "Thank you for using 'How much is my money in?'Goodbye."
  end
end

def convert
  html = open(@hash[@currency]+"&amount=#{@amount}")#
  doc = Nokogiri::HTML(html)
  doc.css("table.tablesorter tbody tr").each do |x|
    @hash2[x.css("td")[0].text] = x.css("td")[1].text
  end
  
  puts "Your #{@amount} in #{@currency} is worth #{@hash2[@currency2]} in #{@currency2}!"
  again?
end

def search_list
  results =[]
  puts "Enter starting letter of currency/country:"
  letter = gets.chomp
  if letter =~ /[a-zA-Z]/
    @list.each do|currency| 
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
     search_list
  end

  puts "Do you want to search again? Y/N"
     x = gets.chomp.upcase
     if x == "Y"
      search_list
    elsif x == "N"
      puts "Alright. Reloading the CLI..."
      start
    else
      puts "Sorry. Invalid entry. Searching again..."
      search_list
    end
end


def process_input(answer)
  if @list.include?(answer)
    puts "Loading currency list..."
  else
     puts "Invalid currency. Starting over..."
     start 
  end
end

def process_input2
  puts "What currency do you like to convert to?"
  answer = gets.chomp
  if answer == @currency
    puts "You can't have same currencies for conversion."
    process_input2
  elsif @list.include?(answer)
    puts "Converting your money now..."
    puts " >> \n >>> \n >>>> \n >>>>> \n "
    @currency2 = answer
    convert
  else
     puts "Invalid currency. Please try again:"
     process_input2 
  end
end

end





