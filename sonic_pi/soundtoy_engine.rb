#init counter
counter = 0

#init chord prog
chord_prog = [
  chord(:C4, :maj9),
  chord(:D4, :m9),
  chord(:E4, :m9),
  chord(:F4, :maj9),
  chord(:G4, :maj9),
  chord(:A4, :m9),
  chord(:B4, :dim7)
].ring


# shuffle chord options to start
chord_prog.shuffle

# creating a thread for cueing
in_thread(name: :metronome) do
  loop do
    # create a metronome tick every 2 bars
    cue :tick
    sleep 1.5
  end
end

in_thread(name: :counter) do
  loop do
    # sync with metronome tick
    sync :tick
    
    # on each tick, increment the counter
    counter = (inc counter)
  end
end

in_thread(name: :pulse_chords) do
  loop do
    # sync with metronome tick
    sync :tick
    
    # if the counter mod 4 is 0, then shuffle chord options order
    if counter % 4 == 0
      chord_prog = chord_prog.shuffle
    end
    
    # play chords at counter position using pulse synth
    use_synth :pulse
    play_chord chord_prog[counter]
  end
end

