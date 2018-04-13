require 'gosu'

class WhackARuby < Gosu::Window

  def initialize
      super 800,600,false
      self.caption = "Whack the Ruby!"
      # drwaing the gem and placing it
      @image = Gosu::Image.new('ruby.png')
      @x = 200
      @y = 200
      @width = 50
      @height = 43
      # making the gem move about the screen- numbers here can be updated to make game easier or harder
      @velocity_x = 5
      @velocity_y = 5
      # This creates the gem blinking
      @visible = 0
    end

    def draw()
      # if the gem is updated below with params then draw it to screen
      if @visible > 0
      @image.draw(@x-@width/2, @y-@height/2,1)
      end

    end

    def update()
      # this method makes the gem move about the screen and blink it numbers here can be updated to make it easier or harder
      @x  += @velocity_x
      @y  += @velocity_y
      @velocity_x *= -1 if @x + @width/2 >800 || @x-@width / 2<0
      @velocity_y *= -1 if @y + @height/2 >600 || @y- @height / 2<0
      @visible -= 1
      @visible = 30 if @visible <-10 &&rand <0.01
    end

end

window = WhackARuby.new
window.show
