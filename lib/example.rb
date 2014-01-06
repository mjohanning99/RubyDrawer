#TexPlay Examples
require 'gosu'
require 'texplay'

class TexWindow < Gosu::Window
	def initialize
		$WIDTH = 600 #Screen Width (not larger than 1022)
		$HEIGHT = 300 #Screen Height (not larger than 1022)
		@size = 3 #The largest size that dots shall have 
		$filled = false #Filled dots? (only use true or false value)

		super $WIDTH, $HEIGHT, false
		$player = Player.new(self)
		@background = TexPlay.create_blank_image(self, $WIDTH, $HEIGHT)
		@colours = [:white, :red, :orange, :green, :tyrian, :yellow, :turquoise, :cyan, :blue] #You can add or delete colours here
		$colour = @colours[rand(@colours.size)]
		$x = rand($WIDTH)
		$y = rand($HEIGHT)

	end

	def needs_cursor?
		false
	end

	def update
		#$player.tp(mouse_x, mouse_y)
		if button_down? Gosu::KbEscape then
			close
		end
		if button_down? Gosu::KbW then $player.forward end
		if button_down? Gosu::KbA then $player.left end
		if button_down? Gosu::KbD then $player.right end
		if button_down? Gosu::KbS then $player.backwards end
		$colour = @colours[rand(@colours.size)] #Random Colour Chooser, that updates all the time
		#$x = mouse_x
		#$y = mouse_y
		$x = rand($WIDTH)
		$y = rand($HEIGHT)

	end

	def draw
		$player.draw
		$player.touched_wall?
		@background.draw(0, 0, 0)
        
        $size = rand(@size)

		@background.paint {
		    circle $x, $y, $size, :color => $colour, :fill => $filled
			#line $x, $y, $size, $y, :color => $colour, :fill => $filled
 		}

 		@background.paint {
 			circle $player.x, $player.y, $size + 25, :color => :black, :fill => true
 		}
end
end



class Player
	def initialize(window)
		@x = @y = 0
		@image = Gosu::Image.new(window, "delete.png", false)
	end

  def touched_wall?
  	if @x >= $WIDTH - 10 then
  		tp($WIDTH - 20, @y)
  	end
  	if @x <= $WIDTH - $WIDTH + 10 then
  		tp($WIDTH - $WIDTH + 20, @y)
  	end
  	if @y >= $HEIGHT - 10 then
  		tp(@x, $HEIGHT - 20)
  	end
  	if @y <= $HEIGHT - $HEIGHT + 10 then
  		tp(@x, $HEIGHT - $HEIGHT + 20)
  	end
  end

	def tp(x, y)
		@x, @y = x, y
	end

	def draw
		@image.draw(@x, @y, 1)
	end

	def right
		@x += 5
	end

	def left
		@x -= 5
	end

	def forward
		@y -= 5
	end

	def backwards
		@y += 5
	end

	def x
		@x
	end

	def y
		@y
	end

end

TexWindow.new.show
