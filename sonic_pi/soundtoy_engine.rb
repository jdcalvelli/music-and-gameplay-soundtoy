# setting a random seed
use_random_seed 1020

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

#set sub arrays the stupid way
set :sub_arr_1, [get[:chord_prog][0], get[:chord_prog][1]]
set :sub_arr_2, [get[:chord_prog][2], get[:chord_prog][3]]
set :sub_arr_3, [get[:chord_prog][4], get[:chord_prog][5]]
set :sub_arr_4, [get[:chord_prog][6], get[:chord_prog][7]]

live_loop :touchpad_1 do
  # initialize ability to receive osc
  use_real_time
  
  # sync in the osc message
  sync "/osc:127.0.0.1:57121/touchpad/1"
  # play chords at counter position using pulse synth
  use_synth :pulse
  play_chord choose(get[:sub_arr_1])
  
end

live_loop :touchpad_2 do
  # initialize ability to receive osc
  use_real_time
  
  # sync in the osc message
  sync "/osc:127.0.0.1:57121/touchpad/2"
  use_synth :pulse
  play_chord choose(get[:sub_arr_2])
  
end

live_loop :touchpad_3 do
  # initialize ability to receive osc
  use_real_time
  
  # sync in the osc message
  sync "/osc:127.0.0.1:57121/touchpad/3"
  use_synth :pulse
  play_chord choose(get[:sub_arr_3])
  
end

live_loop :touchpad_4 do
  # initialize ability to receive osc
  use_real_time
  
  # sync in the osc message
  sync "/osc:127.0.0.1:57121/touchpad/4"
  use_synth :pulse
  play_chord choose(get[:sub_arr_4])
  
end

