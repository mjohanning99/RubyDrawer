#TexPlay Examples
require 'gosu'
require 'texplay'

class TexWindow < Gosu::Window
	def initialize
		$WIDTH = 800 #Screen Width
		$HEIGHT = 600 #Screen Height
		@size = 3  #The largest size that dots shall have

		super $WIDTH, $HEIGHT, true
		@background = TexPlay.create_blank_image(self, $WIDTH, $HEIGHT)
		@colours = [:white, :red, :orange, :green, :tyrian, :yellow, :turquoise, :cyan, :blue]
		$colour = @colours[rand(@colours.size)]
		$x = rand($WIDTH)
		$y = rand($HEIGHT)

	end

	def needs_cursor?
		false
	end

	def update
		if button_down? Gosu::KbEscape then
			close
		end
		$colour = @colours[rand(@colours.size)] #Random Colour Chooser, that updates all the time
		#$x = mouse_x
		#$y = mouse_y
		$x = rand($WIDTH)
		$y = rand($HEIGHT)
	end

	def draw
		@background.draw(0, 0, 0)
        
        $size = rand(@size)
		@background.paint {
		    circle $x, $y, $size, :color => $colour, :fill => true
			#line $x, $y, $x, $size, :color => $colour, :fill => true
 		}
end
end

TexWindow.new.show
