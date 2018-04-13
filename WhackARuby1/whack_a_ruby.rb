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
      @velocity_x = 1
      @velocity_y = 1
      # This creates the gem blinking
      @visible = 0
      # Add hammer Image
      @hammer_image = Gosu::Image.new('hammer.png')
      # this creates a new font and size for the score
      @font = Gosu::Font.new(45)
      # this is the score variable
      @score = 0
      @font = Gosu::Font.new(27)
      @playing = true
      @start_time = 0

    end

    def draw()
      # if the gem is updated below with params then draw it to screen
      if @visible > 0
        @image.draw(@x-@width/2, @y-@height/2,1)
      end
      # allow mouse to control hammer Image
      @hammer_image.draw(mouse_x - 40, mouse_y - 10, 1)
      # detect a mouse click and color the screen green if hit red if missed- not working at the moment
      #     if @hit == 0
      #     c = Gosu::Color::NONE
      #   elsif @hit == 1
      #     c = Gosu::Color::GREEN
      #   elsif @hit == -1
      #     c = Gosu::Color::RED
      #   end
      #   # draw quad is a gosu method that requires 12 params to drwa a quadrilateral  this method will draw the color around the window
      # draw_quad(0,0,c,800,0,c,800,600,c,0,600,c)
      #   # this resets the window back to black after draw runs
      #   @hit = 0
      @font.draw(@score.to_s, 700,20,2)
      @font.draw(@time_left.to_s, 20,20,20)
      unless @playing
        @font.draw('GAME OVER!', 300,300, 0)
        @font.draw('Press Space Bar to Play Again', 175, 350, 3)
        @visable =20
      end
    end



    def update()
      # this method makes the gem move about the screen and blink it numbers here can be updated to make it easier or harder
        if @playing
          @x  += @velocity_x
          @y  += @velocity_y
          # this makes the gem stay on the screen
          @velocity_x *= -1 if @x + @width/2 >800 || @x-@width / 2<0
          @velocity_y *= -1 if @y + @height/2 >600 || @y- @height / 2<0
          # negitive numbers allog wen to stay on screen longer should be 1 per code
          @visible -= 1
          @visible = 30 if @visible <-10 &&rand <0.01
          # change 100 to change playtime
          @time_left = (100 -((Gosu.milliseconds-@start_time)/1000))
          @playing = false if @time_left <0
        end
    end

    def button_down(id)
      # detects a button click with gosu methods
      if @playing
      if (id == Gosu::MsLeft)
        # if the mouse is w/i 50 pixels and clicked then add point if not w/i 50 pixels subtract point
        if Gosu.distance(mouse_x, mouse_y,@x,@y) < 100 && @visible >=0
          @hit =1
          # this adds 5 pts for every hit
          @score += 5
        else
          @hit = -1
          # this subtracts 1 pt for every miss
          @score -=1
        end
      end
    else
        if (id == Gosu::KbSpace)
          @playing = true
          @visible = -10
          @start_time = Gosu.milliseconds
          @score = 0
        end
    end
  end
end

window = WhackARuby.new
window.show
