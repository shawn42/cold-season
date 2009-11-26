require 'actor_view'

class MidBubblesView < ActorView

  BUBBLE_COLOR = [75,220,50,155]
  def draw(target,x_off,y_off)
    actor.bubbles.each do |b|
      target.draw_circle_s [b.x+x_off,b.y+y_off], b.rad, BUBBLE_COLOR
    end
  end
end
