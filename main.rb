=begin
Nicholas Ashenfelter and Samuel Witty
Programming Project Game In Ruby
=end
require 'gosu'

=begin
    Class Room shall be the instances that the player will move through
    to complete the adventure.
    variables
    -name: name of the room
    -descript: short desctription of the room
    -links: an array that contain the possible rooms that the player can move to from this room
    -examineTargets: an array that contains different objects in the room that can be examined
    Methods
    -get_name(): returns the name of the room
    -get_room_des(): returns a description of the room
    -get_links(): returns the different rooms that are connected to this one
    -get_examineTargets(): returns an array of the different thing in the room that can be examined
    -get_examine_ref(): returns the discription of the object in the room that is being examined

    Editor's Note I would add a string array to the room that be the events
    and another string array that tells of the effect of those choices.

    Methods
=end

#clears the command line to make the game look cleaner
def cleanScreen
  system "clear"
  system "cls"
end

#creates a buffer between text walls
def textLine
    puts("**")
    puts("*")
    puts("**\n")
end

class Room
        #initialize is called every time a new object of the class is created
    def initialize(name,des,links,examineTargets)
        @name = name
        @descript = des
        @links = links
        @examineTargets = examineTargets
        @examineRes = []
    end


    def get_name()
        return @name
    end

    def get_room_des()
        return @descript
    end

    def get_link()
        return @links
    end

    def get_examineTargets()
        return @examineTargets
    end

    def add_examine_res(res)
        @examineRes.push(res)
    end

    def get_examine_ref(index)
        puts @examineRes[index]
    end
end

=begin

The player class holds the player's name,
inventory, the current room and the boolean
gameOver that controls when the game loop ends.
Method get_move_options prints that possible movement
options for the current room and askes for a vaild
option
Method move_to changes the room that the player is in
to the parameter that was passed to it.
Method get_current_room()
returns the current room the player is in
Method print_inventory()
prints the players inventory
Method add_to_invent(item)
adds the parameter item to the player's inventory
Method examine(T)
Chops off Examine and searches the current room to see
if it is an Examine Target, if it is, prints info
about it
=end
class Player
    def initialize(name,room)
        @name = name
        @room = room
        @gameOver = false;
        @inventory = ["nothing"]
    end

    def examine(t)
        target = t[8,t.length].chomp
        if(@room.get_examineTargets().include?(target))
            print(@room.get_examine_ref(0))
        end
    end

    def get_move_options()
        #add space
        textLine()
        for i in @room.get_link()
            puts (i.inspect)
        end
        puts "Where would you like to move?"
        going_to = gets().chomp
        possiblelinks = @room.get_link()

        while(!possiblelinks.include?(going_to))
            puts "Invalid Entry, try again..."
            going_to = gets().chomp
        end
        move_to(going_to)
    end

    def move_to(room)
        puts"moving to #{room}"
        @room = room
    end

    def get_current_room()
        return @room
    end

    def print_inventory()
        print("Your inventory includes the following:")
        for i in @inventory
            print(i.inspect)
        end
        puts() #wanted another line fore spacing
    end

    def add_to_invent(item)
        if(@inventory[0]=="nothing")
            @inventory[0]= item
        else
            @inventory.unshift(item)
        end
    end

end


def titleScreen
  cleanScreen
  @tune = Gosu::Song.new('E:\OPLRuby\intro.wav')
  @tune.play(looping = true)
  puts "__Game Title__"
  puts "\n\n"
  puts "Created By Nick A, Sam W, Tyler R, and Stefan"
  puts "Version 1.0.0"
  puts "\n\n"
  puts "__Action Control Keywords__"
  puts "\n"
  puts "Move: Use this command to move to a different area."
  puts "Examine: Use this command followed by a word to examine the object."
  puts "Use: Use this command as such 'use key' it might interact with something."
  puts "Inventory: Use this command to view the contents of your inventory."
  puts "\n"
  puts "NOTE: CONTROLS ARE CASE SENSATIVE!"
  puts "\n\n"
  puts "Press Any Key To Continue..."
  gets().chomp
  cleanScreen
end

def intro
  puts "First let us begin by asking a couple of simple questions."
  sleep(2)
  puts "What is your name?"
  gets().chomp
  sleep(2)
  puts "How would you describe yourself in one word?"
  gets().chomp
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
