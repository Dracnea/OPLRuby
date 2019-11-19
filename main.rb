def titleScreen
  puts "__Game Title__"
  puts "\n\n"
  puts "Created By Nick A, Sam W, Tyler R, and Stefan"
  puts "Version 1.0.0"
  puts "\n\n"
  puts "Press Any Key To Continue..."
  gets
  system "clear"
  system "cls"
end

def intro
  puts "First let us begin by asking a couple of simple questions."
  sleep(2)
  puts "What is your name?"
  gets
end


titleScreen
intro
