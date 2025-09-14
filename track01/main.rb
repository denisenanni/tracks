use_bpm 300
use_synth :blade

#counters
set :global_loop_count, 0

live_loop :main_melody do
  loop_num = tick(:loop_count)
  set :global_loop_count, loop_num

  if loop_num >= 60
    cue :stop_all
    stop
  end

  puts "Main melody tick: #{tick}, Loop count: #{loop_num}, global: #{get[:global_loop_count]}"
  
  # Gradually open the filter over time
  cutoff_val = [(loop_num * 2) + 60, 130].min
  
  # CHORD VARIATIONS - Add variations after loop 24
  if loop_num >= 24 && loop_num < 50
    variation = (loop_num / 8) % 4  # Cycle every 8 loops
    puts "CHORD VARIATION: #{variation}"
    
    case variation
    when 0 # Original Eb minor
      melody_notes = [:Eb4, :Gb4, :Bb4, :Ab4, :Bb4, :Gb4, :F4, :Eb4]
    when 1 # Eb sus4
      melody_notes = [:Eb4, :Ab4, :Bb4, :Ab4, :Bb4, :Ab4, :F4, :Eb4]
    when 2 # Eb minor add7
      melody_notes = [:Eb4, :Gb4, :Bb4, :Db5, :Bb4, :Gb4, :F4, :Eb4]
    when 3 # Eb minor add9
      melody_notes = [:Eb4, :Gb4, :Bb4, :F5, :Bb4, :Gb4, :F4, :Eb4]
    end
    
    with_fx :lpf, cutoff: cutoff_val do
      melody_notes.each_with_index do |note, i|
        play note, pan: (i % 2 == 0 ? 1 : -1), release: 4
        sleep 1
      end
    end
  else
    # ORIGINAL MELODY - for loops 0-23
    with_fx :lpf, cutoff: cutoff_val do
      play :Eb4, pan: 1, release: 4
      sleep 1
      play :Gb4, pan: -1, release: 4
      sleep 1
      play :Bb4, pan: 1, release: 4
      sleep 1
      play :Ab4, pan: -1, release: 4
      sleep 1
      play :Bb4, pan: 1, release: 4
      sleep 1
      play :Gb4, pan: -1, release: 4
      sleep 1
      play :F4, pan: 1, release: 4
      sleep 1
      play :Eb4, pan: -1, release: 4
      sleep 1
    end
  end
end

live_loop :acid_bass do
  sync :main_melody
  loop_num = get[:global_loop_count]


  use_synth :tb303
  if loop_num >= 1 && loop_num < 32
    #1
    with_fx :distortion, distort: 0.3 do
      play :Eb2, cutoff: rrand(50, 90), res: 0.9, amp: 0.8
      sleep 0.125
      play :Eb2, cutoff: rrand(50, 90), res: 0.9, amp: 0.4
      sleep 0.125
      play :F2, cutoff: rrand(40, 80), res: 0.8, amp: 0.6
      sleep 1.25
      play :Gb2, cutoff: rrand(60, 100), res: 0.7, amp: 0.9
      sleep 0.375
      play :F2, cutoff: rrand(70, 110), res: 0.6, amp: 0.3
      sleep 6.124
    end
  elsif loop_num >= 38 && loop_num < 42
    #3
    puts "ACID BASS - TRANSITION RETURN"
    with_fx :distortion, distort: 0.15 do # Less distortion
      with_fx :lpf, cutoff: 70 do # Darker, filtered
        play :Eb2, cutoff: rrand(40, 60), res: 0.7, amp: 0.5
        sleep 0.25
        play :F2, cutoff: rrand(35, 55), res: 0.6, amp: 0.3
        sleep 1.75
        play :Gb2, cutoff: rrand(50, 70), res: 0.5, amp: 0.6
        sleep 6
      end
    end
  elsif loop_num >= 60
    #2 & #4
    sleep 8
  else
    sleep 8
  end
end

live_loop :bass_root do
  sync :main_melody
  loop_num = get[:global_loop_count]

  use_synth :blade #:bass_highend
  if loop_num >= 4 && loop_num < 60
    if loop_num >= 24
      #6
      variation = (loop_num / 8) % 4
      
      case variation
      when 0 # Original: Eb -> Bb -> Ab
        play :Eb2, amp: 0.8
        sleep 1.5
        play :Eb2, amp: 0.5
        sleep 0.5
        play :Bb1, amp: 0.8
        sleep 1
        play :Ab1, amp: 0.6
        sleep 1
        play :Eb2, amp: 0.8
        sleep 1.5
        play :Eb2, amp: 0.5
        sleep 0.5
        play :Bb1, amp: 0.8
        sleep 0.99
        play :Ab1, amp: 0.6
        sleep 0.99
      when 1 # Sus4: Emphasize Ab
        play :Eb2, amp: 0.8
        sleep 1.5
        play :Ab1, amp: 0.7  # More Ab for sus4
        sleep 0.5
        play :Bb1, amp: 0.8
        sleep 1
        play :Ab1, amp: 0.8
        sleep 1
        play :Eb2, amp: 0.8
        sleep 1.5
        play :Ab1, amp: 0.5
        sleep 0.5
        play :Bb1, amp: 0.8
        sleep 0.99
        play :Ab1, amp: 0.6
        sleep 0.99
      when 2 # Add7: Include Db
        play :Eb2, amp: 0.8
        sleep 1.5
        play :Eb2, amp: 0.5
        sleep 0.5
        play :Bb1, amp: 0.8
        sleep 1
        play :Db2, amp: 0.6  # Add 7th
        play :Ab1, amp: 0.6
        sleep 1
        play :Eb2, amp: 0.8
        sleep 1.5
        play :Db2, amp: 0.5
        sleep 0.5
        play :Bb1, amp: 0.8
        sleep 0.99
        play :Ab1, amp: 0.6
        sleep 0.99
      when 3 # Add9: Include F
        play :Eb2, amp: 0.8
        sleep 1.5
        play :F2, amp: 0.6   # Add 9th
        sleep 0.5
        play :Bb1, amp: 0.8
        sleep 1
        play :Ab1, amp: 0.6
        sleep 1
        play :Eb2, amp: 0.8
        sleep 1.5
        play :F2, amp: 0.5
        sleep 0.5
        play :Bb1, amp: 0.8
        sleep 0.99
        play :Ab1, amp: 0.6
        sleep 0.99
      end
    else
      if loop_num <= 8
        #2
        play :Eb2, amp: 0.8
        sleep 1.5
        play :Eb2, amp: 0.6
        sleep 0.5
        play :Bb1, amp: 0.8
        sleep 1
        play :Ab1, amp: 0.6
        sleep 4.99
      elsif loop_num < 15 || loop_num > 19
        #3 & #5
        2.times do
          play :Eb2, amp: 0.8
          sleep 1.5
          play :Eb2, amp: 0.5
          sleep 0.5
          play :Bb1, amp: 0.8
          sleep 0.99
          play :Ab1, amp: 0.6
          sleep 0.99
        end
      else
        #4
        play :Eb2, amp: 0.8
        sleep 1.5
        play :Eb2, amp: 0.8
        sleep 1.5
        play :Eb2, amp: 0.8
        sleep 2.2
        play :Eb2, amp: 0.5
        sleep 0.6
        play :Bb1, amp: 0.8
        sleep 1
        play :Ab1, amp: 0.6
        sleep 1
      end
    end
  else
    #1
    sleep 8
  end
end
