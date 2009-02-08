class SoundManager

  constructor :resource_manager, :config_manager
  def setup()
    # Not in the pygame version - for Rubygame, we need to 
    # explicitly open the audio device.
    # Args are:
    #   Frequency - Sampling frequency in samples per second (Hz).
    #               22050 is recommended for most games; 44100 is
    #               CD audio rate. The larger the value, the more
    #               processing required.
    #   Format - Output sample format.  This is one of the
    #            AUDIO_* constants in Rubygame::Mixer
    #   Channels -output sound channels. Use 2 for stereo,
    #             1 for mono. (this option does not affect number
    #             of mixing channels) 
    #   Samplesize - Bytes per output sample. Specifically, this
    #                determines the size of the buffer that the
    #                sounds will be mixed in.
#    Rubygame::Mixer::open_audio( 22050, Rubygame::Mixer::AUDIO_U8, 2, 1024 )
    Rubygame::Mixer::open_audio( 22050, nil, 2, 1024 )

    puts 'Warning, sound disabled' unless
      (@enabled = (Rubygame::VERSIONS[:sdl_mixer] != nil))
    @enabled = (@enabled and (@config_manager.settings[:sound].nil? or @config_manager.settings[:sound] == true))

    if @enabled
      @music = {}
      @music[:background_music] = @resource_manager.load_music("current_rider.ogg")
      @music[:background_music].fade_out 3

      @sounds = {}
      @sounds[:splat] = @resource_manager.load_sound("splat.ogg")
      @sounds[:crowd_oh] = @resource_manager.load_sound("crowd_oh.ogg")
      @sounds[:times_up] = @resource_manager.load_sound("times_up.ogg")
      @sounds[:fanfare] = @resource_manager.load_sound("fanfare.ogg")
    end
  end

  def enabled?
    @enabled
  end

  def play_sound(what)
    if @enabled
      @sound_thread = Thread.new do
        @sounds[what].play if @sounds[what]
      end
    end
  end

  def play(what)
    if @enabled
      @sound_thread = Thread.new do
        @music[what].play :repeats => -1 if @music[what]
      end
    end
  end

  def stop(what)
    if @enabled
      @music[what].stop if @music[what]
    end
  end

end
