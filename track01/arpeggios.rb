use_bpm 300

live_loop :arpeggios do
  sync :main_melody
  loop_num = get[:global_loop_count]

  puts "Arpeggios - loop_num: #{loop_num}"
  use_synth :pluck


  if loop_num >= 8 && loop_num < 16
    #2
    # Eb minor arpeggio pattern (Eb, Gb, Bb, Db)
    arp_notes = [:Eb5, :Gb5, :Bb5, :Db6]

    with_fx :reverb, room: 0.6, mix: 0.3 do
      with_fx :lpf, cutoff: 90 do
        # Fast ascending arpeggio
        4.times do |i|
          play arp_notes[i], amp: 0.6, release: 0.4, pan: rrand(-0.5, 0.5)
          sleep 0.125
        end

        # Descending variation
        3.times do |i|
          play arp_notes[3 - i], amp: 0.4, release: 0.3, pan: rrand(-0.5, 0.5)
          sleep 0.125
        end

        # Quick double hit
        play :Eb5, amp: 0.8, release: 0.2
        sleep 0.125

        # Rest and repeat pattern with variation
        sleep 0.499

        # Second phrase - different rhythm
        [0, 1, 2, 1, 3, 2].each do |note_idx|
          play arp_notes[note_idx], amp: rrand(0.3, 0.7), release: 0.3
          sleep 0.25
        end

        sleep 1.499
      end
    end
  else
    if loop_num >= 26 && loop_num <= 32 # Start after original arpeggios end and till filter madness
      #4
      # Fix variation calculation to align with melody variations
      variation = ((loop_num - 2) / 8) % 4  # Subtract 2 to align with melody (starts at 24)
      puts "Evolving arpeggios - loop_num: #{loop_num}, variation: #{variation}"

      use_synth_defaults release: 0.4, amp: 0.6  # Force these defaults

      with_fx :reverb, room: 0.6, mix: 0.3 do
        with_fx :lpf, cutoff: 95 do
          case variation
          when 0 # Original: Eb, Gb, Bb, Db
            notes = [:Eb5, :Gb5, :Bb5, :Db6]
          when 1 # Sus4: Eb, Ab, Bb, Db
            notes = [:Eb5, :Ab5, :Bb5, :Db6]
          when 2 # Add7: Eb, Gb, Bb, Db, Eb (5 notes)
            notes = [:Eb5, :Gb5, :Bb5, :Db6, :Eb6]
          when 3 # Add9: Eb, Gb, Bb, F (4 notes)
            notes = [:Eb5, :Gb5, :Bb5, :F6]
          end

          notes.each_with_index do |note, i|
            play note, amp: 0.6, release: 0.4, pan: rrand(-0.5, 0.5)
            sleep 1  # Give each note space
          end

          # Fill remaining time to total exactly 8 beats
          sleep 8 - notes.length
        end
      end
    elsif loop_num >= 60
      sleep 8
    else
      #1 & #3
      sleep 8
    end
  end
end

live_loop :call_response_arps do
  sync :main_melody
  loop_num = get[:global_loop_count]

  use_synth :pluck

  puts "Call-Response Arps - loop_num: #{loop_num}"

  if loop_num >= 8 && loop_num < 16
    #2
    with_fx :reverb, room: 0.6, mix: 0.4 do
      with_fx :lpf, cutoff: 95 do

        # CALL: Main melody plays Eb4 (beat 1)
        sleep 1  # Let melody play

        # RESPONSE: Arpeggio answers with Eb5 octave + harmony
        play :Eb5, amp: 0.5, release: 0.8, pan: -0.7
        play :Bb4, amp: 0.3, release: 0.6, pan: 0.7  # Harmony answer

        # CALL: Main melody plays Gb4 (beat 3)
        sleep 1  # Let melody play

        # RESPONSE: Arpeggio answers
        play :Gb5, amp: 0.6, release: 0.5, pan: 0.5
        play :Db5, amp: 0.4, release: 0.4, pan: -0.5  # Fifth harmony

        # CALL: Main melody plays Bb4 (beat 5)
        sleep 1

        # RESPONSE: Simple answer (removed grace note to save time)
        play :Bb5, amp: 0.7, release: 0.6, pan: 1

        # CALL: Main melody plays Ab4 (beat 7)
        sleep 1

        # RESPONSE: Simple answer
        play :Ab5, amp: 0.6, release: 0.8, pan: -0.8

        # Second half simplified to fit 8 beats total
        sleep 1  # Bb4 in melody
        play :Bb4, amp: 0.5, release: 0.4, pan: 0.5  # Simple response

        sleep 1  # Gb4 in melody
        play :Gb5, amp: 0.6, release: 0.4, pan: 0.6  # Simple response

        sleep 1  # F4 in melody
        play :F5, amp: 0.7, release: 0.6, pan: 0  # Simple response

        sleep 1  # Eb4 final melody note - no response, let melody end
      end
    end
  elsif loop_num >= 24 && loop_num < 35
    #4
    variation = (loop_num / 8) % 4
    case variation
    when 0 # Original responses
      responses = [:Eb5, :Gb5, :Bb5, :Ab5, :Bb4, :Gb5, :F5]
    when 1 # Sus4 responses (use Ab instead of Gb)
      responses = [:Eb5, :Ab5, :Bb5, :Ab5, :Bb4, :Ab5, :F5]
    when 2 # Add7 responses (include Db)
      responses = [:Eb5, :Gb5, :Bb5, :Db6, :Bb4, :Gb5, :F5]
    when 3 # Add9 responses (include F)
      responses = [:Eb5, :Gb5, :Bb5, :F6, :Bb4, :Gb5, :F5]
    end
    with_fx :reverb, room: 0.6, mix: 0.4 do
      responses.each_with_index do |response_note, i|
        sleep 1  # Wait for melody note
        play response_note, amp: 0.5, release: 0.4, pan: rrand(-0.8, 0.8)
      end
      sleep 1  # Final melody note - no response
    end
  elsif loop_num >= 60
    sleep 8
  else
    #1 & #3
    sleep 8
  end
end

live_loop :rhythmic_response_arps do
  sync :main_melody
  loop_num = get[:global_loop_count]

  use_synth :fm

  if loop_num >= 12 && loop_num < 16 # Later in the section for variation
    #2
    with_fx :reverb, room: 0.5, mix: 0.3 do
      with_fx :hpf, cutoff: 80 do

        # Wait for melody phrases, then respond with rhythmic patterns
        sleep 2  # Let first two melody notes play

        # RESPONSE: Rhythmic answer pattern
        melody_notes = [:Eb5, :Gb5, :Bb5, :Ab5]

        4.times do |i|
          play melody_notes[i], amp: 0.4, release: 0.2, pan: rrand(-0.8, 0.8)
          sleep 0.25
        end

        sleep 1  # Space

        # Second response - different rhythm
        3.times do |i|
          play melody_notes[(i + 1) % 4], amp: 0.5, release: 0.15, pan: rrand(-0.6, 0.6)
          sleep 0.166
        end

        sleep 3.5 # Corrected to total exactly 8 beats
      end
    end
  elsif loop_num >= 24 && loop_num < 50
    #4

    variation = (loop_num / 8) % 4

    case variation
    when 0 # Original
      melody_notes = [:Eb5, :Gb5, :Bb5, :Ab5]
    when 1 # Sus4
      melody_notes = [:Eb5, :Ab5, :Bb5, :Ab5]
    when 2 # Add7
      melody_notes = [:Eb5, :Gb5, :Bb5, :Db6]
    when 3 # Add9
      melody_notes = [:Eb5, :Gb5, :Bb5, :F6]
    end

    sleep 2
    4.times do |i|
      play melody_notes[i], amp: 0.4, release: 0.2
      sleep 0.25
    end
    sleep 1
    3.times do |i|
      play melody_notes[(i + 1) % 4], amp: 0.5, release: 0.15
      sleep 0.166
    end
    sleep 3.5  # Total = 8 beats
    elsif loop_num >= 60
      sleep 8
  else 
    #1 & #3
    sleep 8
  end
end

live_loop :build_arps do
  sync :main_melody
  loop_num = get[:global_loop_count]

  # Add debug output to see what's happening
  puts "Build arps - loop_num: #{loop_num}"

  if loop_num == 15 || loop_num == 23 || loop_num == 31 || loop_num == 39 # Build-ups before each variation
    #2
    puts "PLAYING BUILD ARPS NOW!"
    use_synth :saw

    upcoming_variation = ((loop_num + 1) / 8) % 4

    case upcoming_variation
    when 0
      build_notes = [:Eb4, :Gb4, :Bb4, :Db5]
    when 1
      build_notes = [:Eb4, :Ab4, :Bb4, :Db5]
    when 2
      build_notes = [:Eb4, :Gb4, :Bb4, :Db5]
    when 3
      build_notes = [:Eb4, :Gb4, :Bb4, :F5]
    end

    with_fx :hpf, cutoff: 70 do
      with_fx :reverb, room: 0.8, mix: 0.4 do
        # Build-up arpeggios - even slower for 300 BPM
        10.times do |i|
          note = build_notes.choose
          cutoff_sweep = 60 + (i * 6)  # Rising filter sweep

          with_fx :lpf, cutoff: cutoff_sweep do
            play note, amp: 0.4 + (i * 0.05), release: 0.5, pan: rrand(-1, 1)
            sleep 0.8
          end
        end
      end
    end
  elsif loop_num >= 60
    sleep 8
  else
    #1
    sleep 8
  end
end

live_loop :breakdown_arps do
  sync :main_melody
  loop_num = get[:global_loop_count]


  if loop_num >= 16 && loop_num <= 19 # During your breakdown
    use_synth :hollow

    with_fx :reverb, room: 0.9, mix: 0.7 do
      with_fx :echo, phase: 0.75, mix: 0.4 do
        # Slow, spacey arpeggios
        [[:Eb5, 1.5], [:Bb4, 1], [:Gb4, 2], [:Db5, 1.5], [:Eb4, 2]].each do |note, duration|
          play note, amp: 2, release: duration * 1.5, pan: rrand(-0.8, 0.8)
          sleep duration
        end
      end
    end
  else
    sleep 8
  end
end

live_loop :filter_madness do
  sync :main_melody
  loop_num = get[:global_loop_count]


  if loop_num >= 32 && loop_num < 38
    use_synth :saw

    8.times do |i|
      # Use the synth's own cutoff parameter
      cutoff_val = 40 + (i * 10)  # Rising sweep

      play :Eb2, amp: 0.7, release: 1,
                 cutoff: cutoff_val, res: 0.7
      sleep 1
    end
  else
    sleep 8
  end
end
