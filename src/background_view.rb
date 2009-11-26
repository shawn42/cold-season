require 'actor_view'

class BackgroundView < ActorView

  BACKGROUND_COLOR = [25,200,50,255]
  BUBBLE_COLOR = [125,240,50,155]
  def draw(target,x_off,y_off)
    target.fill BACKGROUND_COLOR
    actor.bubbles.each do |b|
      target.draw_circle_s [b.x+x_off,b.y+y_off], b.rad, BUBBLE_COLOR
    end
  end
end
