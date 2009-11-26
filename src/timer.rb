require 'publisher'
class TimerView < ActorView
  def draw(target,x_off,y_off)
    text = (@actor.time_left/1000.0).ceil.to_s
    text = '0'*(3-text.size)+text

    font = @stage.resource_manager.load_font 'Asimov.ttf', 30
    text_image = font.render text, true, [250,250,250,255]

    x = @actor.x
    y = @actor.y

    text_image.blit target.screen, [x,y]
  end
end
class Timer < Actor
  extend Publisher
  can_fire :time_expired

  has_behavior :updatable

  attr_accessor :time_left

  def setup
    @time_left = @opts[:down_from]
  end

  def update(time)
    @time_left -= time.to_i
    if @time_left <= 0
      fire :time_expired
      @time_left = 0
    end
  end
end
