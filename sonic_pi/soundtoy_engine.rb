# setting a random seed
use_random_seed 1020

#init counter w timestate in case of manipulations across threads
set :counter, 0

#init chord prog w timestate in case of manipulations across threads
set :chord_prog, [
  chord(:C4, :maj9),
  chord(:D4, :m9),
  chord(:E4, :m9),
  chord(:F4, :maj9),
  chord(:G4, :maj9),
  chord(:A4, :m9),
  chord(:B4, :dim7)
].ring

# shuffle chord options to start
get[:chord_prog].shuffle

live_loop :touchpad_1 do
  # initialize ability to receive osc
  use_real_time
  
  # if the counter mod 4 is 0, then shuffle chord options order
  if get[:counter] % 4 == 0
    set :chord_prog, get[:chord_prog].shuffle
  end
  
  # sync in the osc message
  sync "/osc:127.0.0.1:57121/touchpad/1"
  # play chords at counter position using pulse synth
  use_synth :pulse
  play_chord get[:chord_prog][get[:counter]]
  # increment counter by 1
  set :counter, (inc get[:counter])
end
