#!/usr/bin/env ruby
$: << "#{File.dirname(__FILE__)}/../config"
require "fileutils"

require 'svg_document'

class ResourceManager
  def initialize
    @loaded_images = {}
    @loaded_svgs = {}
  end

  def load_image(file_name)
    cached_img = @loaded_images[file_name]
    if cached_img.nil?
      cached_img = Rubygame::Surface.load(File.expand_path(DATA_PATH + "gfx/" + file_name))
      @loaded_images[file_name] = cached_img
    end
    cached_img
  end

  def load_music(name)
    begin
      full_name = File.expand_path(DATA_PATH + "sound/" + name)
      sound = Rubygame::Music.load(full_name)
      return sound
    rescue Rubygame::SDLError => ex
      puts "Cannot load sound " + full_name + " : " + ex
      exit
    end
  end

  def load_sound(name)
    begin
      full_name = File.expand_path(DATA_PATH + "sound/" + name)
      sound = Rubygame::Sound.load(full_name)
      return sound
    rescue Rubygame::SDLError => ex
      puts "Cannot load sound " + full_name + " : " + ex
      exit
    end
  end

  def load_config(name)
    conf = YAML::load_file(CONFIG_PATH + name + ".yml")
    user_file = "#{ENV['HOME']}/.cold_season/#{name}.yml"
    if File.exist? user_file
      user_conf = YAML::load_file user_file
      conf = conf.merge user_conf
    end
    conf
  end

  def save_settings(name, settings)
    user_cold_season_dir = "#{ENV['HOME']}/.cold_season"
    FileUtils.mkdir_p user_cold_season_dir
    user_file = "#{ENV['HOME']}/.cold_season/#{name}.yml"
    File.open user_file, "w" do |f|
      f.write settings.to_yaml
    end
  end

  def load_svg(file_name)
    cached_svg = @loaded_svgs[file_name]
    if cached_svg.nil?
      cached_svg = SvgDocument.new(File.open(File.expand_path(DATA_PATH + "levels/" + file_name)))
      @loaded_svgs[file_name] = cached_svg
    end
    cached_svg
  end
  
end
