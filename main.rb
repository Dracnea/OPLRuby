=begin
Samuel Witty and Nicholas Ashenfelter
Programming Project in Ruby
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
    Note that if an item is going to be added to the player's inventory, add a letter to denote it
    after the period and update the method Examine(t) in the player class to reflect this change.

    Editor's Note I would add a string array to the room that be the events
    and another string array that tells of the effect of those choices.
=end

class Room
        #initialize is called every time a new object of the class is created
    def initialize(name,des,links,examineTargets,useTargets)
        @name = name
        @descript = des
        @links = links
        @examineTargets = examineTargets
        @examineRes = []
        @useRes = []
        @useTargets = useTargets
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

    def add_use_res(res)
        @useRes.push(res)
    end

    def get_examine_ref(index)
        return @examineRes[index]
    end

    def get_use_ref(index)
        return @useRes[index]
    end

    def get_use_targets()
        return @useTargets
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
to the parameter that was passed to it. Also displays the description
of the new room.
Method get_current_room()
returns the current room the player is in
Method print_inventory()
prints the players inventory
Method add_to_invent(item)
adds the parameter item to the player's inventory
Method examine(T)
Chops off Examine and searches the current room to see
if it is an Examine Target, if it is, prints info
about it. If the target has a trailing char then it will add
an item to the player's inventory.
Method isGameOver()
Returns a boolean that refelcts if the game is over or not
=end
class Player
    def initialize(name,room, allRooms)
        @name = name
        @room = room
        @gameOver = false;
        @inventory = ["Nothing"]
        @allRooms = allRooms
    end

    def end_game
        @gameOver = true;
        puts("The lock pops off the door and tumbles to the ground as you turn the key. The inside of the shack is covered in a layer of dust and an old computer terminal sags against the back wall.
              \nYou walk over to it as it springs to life. A message sprawls out across the screen and suddenly everything makes sense. You very being, the meaning of life and the secrets of the universe all rolled into one.
              \nA tear rolls down your cheek, as you now understand the truth of this world. The world around fade from existence until the only remaining objects are the two words that set you free.\n")
        sleep(25)
        print("H")
        sleep(1)
        print("E")
        sleep(1)
        print("L")
        sleep(1)
        print("L")
        sleep(1)
        print("O ")
        sleep(1)
        print("\n")
        sleep(1)
        print("W")
        sleep(1)
        print("O")
        sleep(1)
        print("R")
        sleep(1)
        print("L")
        sleep(1)
        print("D")
        sleep(1)
    end

    def use(t)
        target = t[4,t.length].chomp
        puts("Target is " + target)
        if(@inventory.include?(target) && @room.get_use_targets.include?(target))
            found = @room.get_use_targets.index(target)
            rest = @room.get_use_ref(found)

            puts(rest)

            if(target == "Goggles")
                add_to_invent("Key")
                puts("You got a Key!!")
            end

            if(target == "Key")
                end_game
            end

        else
            puts("Either you don't have that item or you can do that...")
        end

    end

    def examine(t)
        target = t[8,t.length].chomp()
        if(@room.get_examineTargets().include?(target))
            found = @room.get_examineTargets().index(target)
            rest = @room.get_examine_ref(found)


            if(rest.slice(rest.length-1)!=".")
                puts(rest.slice(0,rest.length-1))

                case rest.slice(rest.length-1)
                when "R"
                    puts("You got a Rock!!!")
                    add_to_invent("Rock")
                when "G"
                    puts("You got Goggles!!")
                    add_to_invent("Goggles")
                else
                    puts "You got Nothing"
                end

            else
                puts(rest)
            end
        end
    end

    def isGameOver
        return @gameOver
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

        case room
        when room = "Field"
            room = @allRooms[0]
            @room = room
        when room = "Windmill"
            room = @allRooms[1]
            @room = room
        when room = "Shack"
            room = @allRooms[2]
            @room = room
        when room = "Lake"
            room = @allRooms[3]
            @room = room
        when room = "TrashPile"
            room = @allRooms[4]
            @room = room
        else
            puts("Movement failed")
        end
        puts(@room.get_room_des())
    end

    def get_current_room()
        return @room
    end

    def print_inventory()
        print("Your inventory includes the following:")
        for i in @inventory
            print(i.inspect)
        end
        puts() #wanted another line for spacing
    end

    def add_to_invent(item)
        if(@inventory[0]=="Nothing")
            @inventory[0]= item
        else
            @inventory.unshift(item)
        end
    end

    def get_invent()
        return @inventory
    end

end

=begin

=end

#public method that creates a buffer between text walls
def textLine
    puts("\n")
end

def cleanScreen
  system "clear"
  system "cls"
end

def titleScreen
  cleanScreen
  @tune = Gosu::Sample.new('titleScreen.wav')
  t = Thread.new {
      @tune.play(0.75, 1, true)
  }
  t.join
  puts "__Game Title__"
  puts "\n\n"
  puts "Created By Nick A and Sam W"
  puts "Version 1.0.0"
  puts "\n\n"
  puts "__Action Control Keywords__"
  puts "NOTE: CONTROLS ARE CASE SENSATIVE!"
  puts "\n"
  puts "Move: Use this command to move to a different area."
  puts "Examine: Use this command followed by a word to examine the object."
  puts "Use: Use this command as such 'use key' it might interact with something."
  puts "Inventory: Use this command to view the contents of your inventory."
  puts "Quit / Exit: Use this command to end the game."
  puts "\n\n"
  puts "Press Enter To Continue..."
  gets
  Thread.kill(t)
  cleanScreen
end

def intro
  puts "First let us begin by asking a couple of simple questions."
  sleep(2)
  puts "What is your name?\n"
  your_name = gets().chomp
  sleep(2)
  puts "How would you describe yourself in one word?"
  gets
  sleep(2)
  puts "I see."
  sleep(1)
  puts "Well then, #{your_name}"
  sleep(2)
  puts "In truth I dont really care about your answers."
  sleep(2)
  puts "What I really need you to do is..."
  sleep(4)
  puts "To snap out of it."
  sleep(2)
  cleanScreen
  return your_name
end

def roomSetup
  #Create the rooms and add refs
  sroom = Room.new("Field","You find yourself in the middle of an open field.",["Windmill","Shack","TrashPile"],["Feild","Billy Bob"],[])
  sroom.add_examine_res("You see the towering visage of Billy Bob The Bold standing in the distance.")
  sroom.add_examine_res("Hello friend! My name is Billy Bob. Would you like a rock? Of course you would!\nHere take one, I have a million of these bad boys.R")

  windmill = Room.new("Windmill","You find yourself infront of a towering Windmill. A strange little old man is standing at the entrance.",["Shack","Feild","Lake"],["Man","WindMill"],["Dollar"])
  windmill.add_examine_res("Hello there traveler, If you would like to enter my tower of mystery it costs a Dollar.\n If yah got no money, they you can suck a rock yah smuck! ")
  windmill.add_examine_res("The Windmill is quite decrepit. You notice that there is an ominous glow coming from inside.")

  shack = Room.new("Shack", "You see a small shack that is painted baby bird blue with white accents. A lock is holding the doors closed.",["Field","Windmill"],["Lock"],["Rock"])
  shack.add_examine_res("A slighty rusted padlock blocks the way. It might be rusted but you can't break it with your bare hands. It may be do-able if you had a pair of Bear-Hands...")
  shack.add_use_res("You try to smash the lock with your trusty rock but it has no effect.")

  lake = Room.new("Lake","You see a crystalline body of water sprawled before you. You see a key dangling from a stick in the middle of the pond. There is a sign that reads Caution, water will dissolve your skin in O(n^2).",["Windmill"],["Lake","Sign","Key"],["Goggles","Rock"])
  lake.add_examine_res("Nothing seems to ominous about this body of water except for the odd sign.")
  lake.add_examine_res("You squint and make out some additional text on the sign that says the water will dissolve your eyes in O(1) time, whatever that means.")
  lake.add_examine_res("A key on a stick in the lake, not much else to say about it.")
  lake.add_use_res("You strap on your goggles and swan dive out into the open water. A cooling sensation covers your body. You would best describe it as if your whole body was a mouth \nthat had just consumed an entire pack of peppermint gum and then decided to engorge yourself with a gallon of water to wash it down. \nYou quickly make it to the sign, grab the key and dolphin dive your way back to the shoreline.")
  lake.add_use_res("You take your rock in you fist and wind up your arm. Right before you send your rock to the bottom of the lake, you remember the good times you had with the rock,\nlike when it was given to you by a strange man named Billy Bob The Bold. You tuck the rock back into your pocket as you wipe a tear from your eye, you didn’t toss the rock, but you gained a friend. \nYou name the rock Gerald.")

  trashpile = Room.new("TrashPile","An overflowing mountain of unsavoriness. Discarded junk is strewn about, all of it broken or filled with a mysterious brown substance that won’t be named.",["Feild"],["TrashPile"],[""])
  trashpile.add_examine_res("You decide that you might find something useful, so you start poking around the trash heap. Eventually you find a pair of hot pink Goggles that have faded elephant prints on them.\nYou decide that they may come in handy if you ever meet a child on your adventure that you want to give pink eye, so you stash it into your pockets after vigorously scrubbing it in a basin of rainwater.G")
  return [sroom, windmill, shack, lake,trashpile]
end

def playGame
  rooms = roomSetup
  titleScreen
  your_name = intro
  playerOne = Player.new(your_name,rooms[0],rooms)
  puts playerOne.get_current_room().get_room_des()

  #Starts main gameplay loop

  puts "What would you like to do?\n"
  playerInput = gets().chomp

  while(!playerOne.isGameOver())

      if(playerInput == "Quit" || playerInput == "Exit")
          break;
      end

      if(playerInput == "Move")
          playerOne.get_move_options()
      end

      if(playerInput == "Inventory")
          playerOne.print_inventory()
          textLine()
      end
      #try Field
      if(playerInput.include?("Examine"))
          playerOne.examine(playerInput)
      end

      if(playerInput.include?("Use"))
          playerOne.use(playerInput)
      end


      puts "What would you like to do?\n"
      playerInput = gets().chomp
  end
end

playGame
