#####
# INITIALIZATION SECTION
#####

# setting bpm
use_bpm 60

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
set :chord_prog, get[:chord_prog].shuffle

#set sub arrays the stupid way
set :sub_arr_1, [get[:chord_prog][0], get[:chord_prog][1]]
set :sub_arr_2, [get[:chord_prog][2], get[:chord_prog][3]]
set :sub_arr_3, [get[:chord_prog][4], get[:chord_prog][5]]
set :sub_arr_4, [get[:chord_prog][6], get[:chord_prog][7]]

# init chord array for sequencer functionality
set :seq, [
  :rest,
  :rest,
  :rest,
  :rest
].ring
# init sequencer power state to off
set :power_seq, false

#####
# CHORDS SECTION
#####

live_loop :touchpad_1 do
  # initialize ability to receive osc
  use_real_time
  
  # sync in the osc message
  sync "/osc:127.0.0.1:57121/touchpad/1"
  
  # set chord to be played and saved in sequencer
  chd = choose(get[:sub_arr_1])
  # play chord
  use_synth :pulse
  play_chord chd
  # save chord to seq
  update_seq chd
  
end

live_loop :touchpad_2 do
  # initialize ability to receive osc
  use_real_time
  
  # sync in the osc message
  sync "/osc:127.0.0.1:57121/touchpad/2"
  chd = choose(get[:sub_arr_2])
  use_synth :pulse
  play_chord chd
  update_seq chd
  
end

live_loop :touchpad_3 do
  # initialize ability to receive osc
  use_real_time
  
  # sync in the osc message
  sync "/osc:127.0.0.1:57121/touchpad/3"
  chd = choose(get[:sub_arr_3])
  use_synth :pulse
  play_chord chd
  update_seq chd
  
end

live_loop :touchpad_4 do
  # initialize ability to receive osc
  use_real_time
  
  # sync in the osc message
  sync "/osc:127.0.0.1:57121/touchpad/4"
  chd = choose(get[:sub_arr_4])
  use_synth :pulse
  play_chord chd
  update_seq chd
  
end

#####
# SEQUENCER SECTION
#####

# sequencer activation loop
live_loop :sequencer_on do
  # initialize ability to receive osc
  use_real_time
  
  # sync in the osc message
  sync "/osc:127.0.0.1:57121/button/1"
  set :power_seq, !get[:power_seq]
  
end

# sequencer loop
live_loop :run_seq do
  
  idx = tick
  
  if get[:power_seq]
    use_synth :pulse
    print get[:seq][idx]
    play get[:seq][idx]
    sleep 1
  else
    sleep 1
  end
end

#####
# HELPER FUNCTIONS SECTION
#####

define :update_seq do |chord_to_add|
  # set new_seq equal to seq in state, remove first element
  new_seq = get[:seq].drop(1)
  # update new_seq to add chord played
  new_seq = new_seq.to_a.push chord_to_add
  # update seq in state to be a ring version of new sequence
  set :seq, new_seq.ring
end
