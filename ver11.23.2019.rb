=begin
Samuel Witty 
Programming project in ruby
=end


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
        @inventory = ["nothing"]
        @allRooms = allRooms
    end

    def use(t)
        target = t[4,t.length].chomp
        puts("Target is " + target)
        if(@inventory.include?(target) && @room.get_use_targets.include?(target))
            found = @room.get_use_targets.index(target)
            rest = @room.get_use_ref(found)
            puts(rest)
        else
            puts("Either you don't have that item or you can do that...")
        end

    end

    def examine(t)
        target = t[8,t.length].chomp
        if(@room.get_examineTargets().include?(target))
            found = @room.get_examineTargets().index(target)
            rest = @room.get_examine_ref(found)
            
            
            if(rest.slice(rest.length-1)!=".")
                puts(rest.slice(0,rest.length-1))
                
                case rest.slice(rest.length-1)
                when "R"
                    puts("You got a Rock!!!")
                    add_to_invent("Rock")
                else
                    puts "You got nothing"
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
        when room = "Feild"
            room = @allRooms[0]
            @room = room
        when room = "Windmill"
            room = @allRooms[1]
            @room = room
        when room = "Shack"
            room = @allRooms[2]
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
        if(@inventory[0]=="nothing")
            @inventory[0]= item
        else
            @inventory.unshift(item)
        end
    end

    def get_invent()
        return @inventory
    end

end

#public method that creates a buffer between text walls
def textLine
    puts("**")
    puts("*")
    puts("**\n")
end


#Create the rooms and add refs
sroom = Room.new("Feild","You find yourself in the middle of an open feild.",["Windmill","Shack"],["Feild","Billy Bob"],[])
sroom.add_examine_res("You see the towering visage of Billy Bob The Bold standing in the feild.")
sroom.add_examine_res("Hello friend! My name is Billy Bob. Would you like a rock? Of course you would!\nHere take one, I have a million of these bad boys.R")

windmill = Room.new("Windmill","You find yourself infront of a towering windmill. A man appears to be standing infront of the entrance.",["Shack","Feild","Lake"],["Man","WindMill"],["Dollar"])
windmill.add_examine_res("Hello there travaler, If you would like to enter my tower of mystery it costs a Dollar.\n If yah got no money, they you can suck a rock yah smuck! ")
windmill.add_examine_res("The Windmill is quite decrepit, However there is an ominous glow coming from inside.")

shack = Room.new("Shack", "You see a small shack that is painted baby bird blue with white accents. A lock is holding the doors closed.",["Feild","Windmill"],["Lock"],["Rock"])
shack.add_examine_res("A slighty rusted padlock blocks the way. It might be rusted but you can't break it with your bare hands. Might be do-able if you had a pair of Bear-Hands...")
shack.add_use_res("You try to smash the lock with your trusty rock but it has no effect on the lock.")

puts "Welcome to our little text adventure, note that this game is case-sensitive."
puts "The actions that you can preform revolve around the following keywords."
puts "Move: Use this command to move to a different area."
puts "Examine: Use this command followed by a word to examine the object."
puts "Use: Use this command as such 'use key' it might interact with something."
puts "Inventory: Use this command to view the contents of your inventory."
puts "Quit:Use this comman to end the game"
puts "Now what is your name?"


your_name = gets()
textLine()
puts "Hello #{your_name}"

playerOne = Player.new(your_name,sroom,[sroom,windmill,shack])
puts playerOne.get_current_room().get_room_des()



#Starts main gameplay loop

puts "What would you like to do?"
playerInput = gets().chomp

while(!playerOne.isGameOver())

    if(playerInput == "Quit")
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


    puts "What would you like to do?"
    playerInput = gets().chomp
end
