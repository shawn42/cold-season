require 'actor'
require 'bubble'

class MidBubbles < Actor
  has_behavior :layered => {:parallax=>12, :layer => 0}
  
  NUM_BUBBLES = 200
  BUBBLE_SIZE = (15..25).to_a
  BUBBLE_SPREAD = 2000

  attr_reader :bubbles
  def setup
    @bubbles = []
    NUM_BUBBLES.times do
      bubble_x = @x + rand(BUBBLE_SPREAD)
      bubble_y = @y + rand(BUBBLE_SPREAD)
      bubble_rad = BUBBLE_SIZE[rand(BUBBLE_SIZE.size)]
      @bubbles << Bubble.new(bubble_x, bubble_y, bubble_rad)
    end

  end
end
