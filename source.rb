require 'gosu'
require 'texplay'

class Window < Gosu::Window
	def initialize
		super(1022, 600, false)
		@background = TexPlay.create_blank_image(self, 1022, 580)
		$colour = :black #Default brush colour
		$colour1 = :black #Default background colour
		print "Brush Size: "
		$size = gets.chomp.to_f
		@cursor = Gosu::Image.new(self, "lib/brush.png", false)
		@delete = Gosu::Image.new(self, "lib/delete.png", false)
		@paint = true
		@deleting = false
		@font = Gosu::Font.new(self, Gosu::default_font_name, 20)
		@colour_translate = {:black => "Schwarz", :red => "Rot", :blue => "Blau", :green => "Gruen", :orange => "Orange", :cyan => "Hellblau", :yellow => "Gelb", :turquoise => "Tuerkis", :brown => "Braun", :tyrian => "Tyrian"}
	end


	#def needs_cursor?
	#	true
	#end

	def update
	end

	def draw
		@font.draw("Brush Size: #{$size}", 10, 580, 3, 1.0, 1.0, 0xff00ffff)
		@font.draw("Colour: #{$colour}/#{@colour_translate[$colour]}", 155, 580, 3, 1.0, 1.0, 0xff00ffff)
		@font.draw("Colours: black, red, blue, green, orange, cyan, yellow, turquoise, tyrian, brown", 370, 580, 3, 1.0, 1.0, 0xff00ffff)
		if @paint == true then
		@cursor.draw(mouse_x, mouse_y - 16, 1)
	    end
	    if @deleting == true then
	    	@delete.draw(mouse_x, mouse_y - 16, 1)
	    end
		@background.draw(0, 0, 0)
		
		#Selecting colour via the Keyboard 
		$colour = :black if button_down? Gosu::Kb1
		$colour = :red if button_down? Gosu::Kb2
		$colour = :blue if button_down? Gosu::Kb3
		$colour = :green if button_down? Gosu::Kb4
		$colour = :orange if button_down? Gosu::Kb5
		$colour = :cyan if button_down? Gosu::Kb6
		$colour = :yellow if button_down? Gosu::Kb7
		$colour = :turquoise if button_down? Gosu::Kb8
		$colour = :tyrian if button_down? Gosu::Kb9
		$colour = :brown if button_down? Gosu::Kb0


		$x = mouse_x
		$y = mouse_y
		def button_down(id)
		        $size += 1 if id == Gosu::MsWheelUp
		        $size -= 1 if id == Gosu::MsWheelDown
		        $size += 1 if id == Gosu::KbUp
		        $size -= 1 if id == Gosu::KbDown
		        	
		    if id == Gosu::KbF then
		    puts "Colours: green, red, blue, black, orange, cyan, purple, yellow, turquoise, tyrian, brown, yellow"
			   print "What colour: "
			   colour = gets.chomp!
			   case colour
			   when "green"
			   	$colour1 = :green
			   when "red"
			   	$colour1 = :red
			   when "blue"
			   	$colour1 = :blue
			   when "black"
			   	$colour1 = :black
			   when "orange"
			   	$colour1 = :orange
			   when "cyan"
			   	$colour1 = :cyan
			   when "purple"
			   	$colour1 = :purple
			   when "yellow"
			   	$colour1 = :yellow
			   when "turquoise"
			   	$colour1 = :turquoise
			   when "tyrian"
			   	$colour1 = :tyrian
			   when "brown"
			   	$colour1 = :brown
			   end
		    end
		end
		 
		if button_down? Gosu::MsLeft then
		@paint = true
		@deleting = false
		@background.paint {
			circle $x, $y, $size, :color => $colour, :fill => true
			
			#Enable this to enable Vertical Line drawing
			#line $x, $y, $x, $size, :color => $colour, :fill => true
 		}
	    end
	    if button_down? Gosu::MsRight then
	    @paint = false
		@deleting = true
		@background.paint {
			circle $x, $y, $size + 2, :color => $colour1, :fill => true
		}
	    end
	    if button_down? Gosu::MsMiddle then
	    		$colour1 = :white
	    		@background.paint {
			      circle 0, 0, 1500, :color => :white, :fill => true
		}
	end
	if @deleting == true then
		if button_down? Gosu::KbRightShift then
		@background.paint {
			circle $x, $y, $size + 2, :color => :black, :fill => false
			#circle $x, $y, $size + 2, :color => $colour1, :fill => false
		}
	end
	end
end
end

window = Window.new
window.show
