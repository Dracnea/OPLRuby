def cleanScreen
  system "clear"
  system "cls"
end

def titleScreen
  puts "__Game Title__"
  puts "\n\n"
  puts "Created By Nick A, Sam W, Tyler R, and Stefan"
  puts "Version 1.0.0"
  puts "\n\n"
  puts "Press Any Key To Continue..."
  gets
  cleanScreen
end

def intro
  puts "First let us begin by asking a couple of simple questions."
  sleep(2)
  puts "What is your name?"
  gets
  sleep(2)
  puts "How would you describe yourself in one word?"
  gets
  sleep(2)
  puts "I see. Thank you for your answers, but..."
  sleep(2)
  puts "In truth none of your choices matter."
  sleep(2)
  puts "In a game about choices, your choices dont really matter in the end."
  sleep(3)
  puts "This is the story of "
  sleep(3)
  puts "An average man who has found himself in a not so average situation."
  sleep(3)
  puts "In fact I think he's waking up now..."
  sleep(5)
  cleanScreen
end


titleScreen
intro
