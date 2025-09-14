use_bpm 300
live_loop :atmospheric_pads do
  sync :main_melody
  loop_num = get[:global_loop_count] || 0

  puts "Atmospheric pads - loop_num: #{loop_num}"

  if loop_num >= 6 && loop_num <= 15 # Fade in from loop 6, end before breakdown
    #2
    use_synth :hollow

    # Calculate fade-in progress (0.0 to 1.0 over loops 6-8)
    fade_progress = if loop_num <= 8
        [(loop_num - 6).to_f / 2, 1.0].min  # Fade in over 2 loops
      else
        1.0  # Full volume after loop 8
      end

    base_amp = 0.3 * fade_progress  # Maximum amp of 0.3, scaled by fade

    with_fx :reverb, room: 0.8, mix: 0.6 do
      with_fx :lpf, cutoff: 70 + (loop_num * 3) do # Gradually open filter

        # Main pad chord - Eb minor (Eb, Gb, Bb)
        play :Eb3, amp: base_amp * 0.8, release: 8, pan: 0
        play :Gb3, amp: base_amp * 0.6, release: 8, pan: -0.3
        play :Bb3, amp: base_amp * 0.7, release: 8, pan: 0.3

        sleep 8
      end
    end
  else
    #1 & #3
    sleep 8
  end
end

live_loop :deep_pads do
  sync :main_melody
  loop_num = get[:global_loop_count] || 0

  use_synth :prophet

  if loop_num >= 8 && loop_num <= 15 # Start after atmospheric pads are established
    #2
    fade_progress = [(loop_num - 8).to_f / 3, 1.0].min  # Fade in over 3 loops
    base_amp = 0.2 * fade_progress

    with_fx :reverb, room: 0.9, mix: 0.7 do
      with_fx :hpf, cutoff: 40 do
        with_fx :echo, phase: 1.5, mix: 0.3 do

          # Lower register pad - adds depth
          play :Eb2, amp: base_amp * 1.0, release: 16, pan: -0.2
          play :Bb2, amp: base_amp * 0.8, release: 16, pan: 0.2

          sleep 8
        end
      end
    end
  else
    #1
    sleep 8
  end
end

live_loop :string_pads do
  sync :main_melody
  loop_num = get[:global_loop_count] || 0

  if loop_num >= 10 && loop_num <= 15 # Latest layer - most subtle
    #2
    use_synth :saw  # Saw wave with long release works well for strings

    # Very slow fade-in
    fade_progress = [(loop_num - 10).to_f / 4, 1.0].min  # Fade in over 4 loops
    base_amp = 0.15 * fade_progress

    with_fx :reverb, room: 0.7, mix: 0.5 do
      with_fx :lpf, cutoff: 85 do

        # High register strings - adds shimmer
        play :Gb4, amp: base_amp * 0.9, release: 12, pan: -0.6
        play :Bb4, amp: base_amp * 0.7, release: 12, pan: 0.6
        play :Db5, amp: base_amp * 0.5, release: 12, pan: 0

        sleep 8
      end
    end
  else
    #1
    sleep 8
  end
end

# Optional: Breakdown pad transition
live_loop :breakdown_transition_pads do
  sync :main_melody
  loop_num = get[:global_loop_count] || 0

  if loop_num == 15 # Just before breakdown - special transition
    use_synth :sine  # Clean sine wave for smooth transition

    with_fx :reverb, room: 0.9, mix: 0.8 do
      with_fx :lpf, cutoff: 60 do # Darker for breakdown prep

        # Sustained chord that carries into breakdown
        play :Eb3, amp: 0.4, release: 16, pan: 0
        play :Gb3, amp: 0.3, release: 16, pan: -0.4
        play :Bb3, amp: 0.35, release: 16, pan: 0.4

        sleep 8
      end
    end
  elsif loop_num >= 16 && loop_num <= 19 # During breakdown - very subtle
    use_synth :hollow

    with_fx :reverb, room: 0.95, mix: 0.9 do
      with_fx :lpf, cutoff: 50 do # Very dark and ambient

        # Minimal pad presence during breakdown
        play :Eb2, amp: 0.1, release: 20, pan: 0

        sleep 8
      end
    end
  else
    sleep 8
  end
end
