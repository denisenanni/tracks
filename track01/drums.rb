use_bpm 300

live_loop :hats do
  sync :main_melody
  loop_num = get[:global_loop_count] || 0


  if loop_num < 60

    puts "HATS - loop_num: #{loop_num}"
    if loop_num >= 1 && loop_num < 32
      if loop_num >= 16 && loop_num <= 19
        #3 BREAK
        puts "HATS - BREAKDOWN MODE #{loop_num},"
        sleep 8
      elsif loop_num <= 4
        #1
        puts "HATS - INITIAL MODE (8 hits) #{loop_num}"
        8.times do
          sample :drum_cymbal_closed, amp: rrand(0.3, 0.6)
          sleep 0.5
        end
      else
        #2 & #4
        puts "HATS - CONTINUOUS MODE (16 hits) #{loop_num}"
        16.times do # 16 times
          sample :drum_cymbal_closed, amp: rrand(0.3, 0.6)
          sleep 0.499
        end
      end
    elsif loop_num >= 38 && loop_num < 42 
      #6
      puts "HATS - RETURN MODE #{loop_num}"
      8.times do
        sample :drum_cymbal_closed, amp: rrand(0.4, 0.7), rate: rrand(0.9, 1.1)
        sleep 0.99  # Slower
      end
    elsif loop_num >= 45
      #8 Return
      puts "HATS - FINAL MODE #{loop_num}"
      16.times do
        sample :drum_cymbal_closed, amp: rrand(0.3, 0.6)
        sleep 0.499
      end
    else
      #5 & #7
      sleep 8
    end
  else
    sleep 8
  end
end

live_loop :kicks do
  sync :main_melody
  loop_num = get[:global_loop_count]
  puts "Loop count: #{loop_num}"
  
  if loop_num >= 1 && loop_num < 60
    if loop_num >= 16 && loop_num <= 19
      #3 BREAK
      sleep 8
    elsif loop_num >= 32 && loop_num <= 37
      #5 BREAK
      puts "KICKS - SILENT FOR FILTER MADNESS"
      sleep 8
    elsif loop_num >= 40 && loop_num <= 44
      #7 BREAK
      puts "KICKS - SILENT FOR POLY CHAOS"
      sleep 8
    elsif loop_num <= 4
      #1 BREAK
      sleep 8
    elsif loop_num >= 45 # Return with variation
      puts "KICKS - FINAL RETURN MODE"
      #8 VARIATION
      sample :bd_haus, amp: 1.0
      sleep 1.5
      sample :bd_tek, amp: 0.8
      sleep 2.5
      sample :bd_haus, amp: 0.9
      sleep 2
      sample :bd_haus, amp: 0.8, rate: 0.9
      sleep 1.99
    else
      #2 & #4 & #6
      1.times do
        sample :bd_haus, amp: 0.9
        sleep 1.99
        sample :bd_tek, amp: 0.7
        sleep 1.99
        sample :bd_haus, amp: 0.8
        sleep 1.99
        sample :bd_haus, amp: 0.8
        sleep 1.99
      end
    end
  else
    sleep 8
  end
end



live_loop :snare_clap do
  sync :main_melody
  loop_num = get[:global_loop_count]

  puts "Snare/clap - loop_num: #{loop_num}"
if loop_num < 60

  if loop_num >= 20
    #2
    sleep 2
    sample :drum_snare_hard, amp: 0.7, pan: rrand(-0.3, 0.3)  # Beat 2
    sleep 4
    sample :drum_snare_hard, amp: 0.8, pan: rrand(-0.3, 0.3)  # Beat 4
    sleep 1.99
  else
    #1
    sleep 8  # Silent during intro
  end
  else
    sleep 8
  end
end

live_loop :perc_fills do
  sync :main_melody
  loop_num = get[:global_loop_count]

  if loop_num >= 25 && loop_num % 8 == 7 && loop_num < 35 # Every 8th loop (end of variation cycle)
    use_synth :noise
    8.times do |i|
      sample :perc_bell, amp: 0.4, rate: 1 + (i * 0.1), pan: rrand(-0.8, 0.8)
      sleep 0.25
    end
    sleep 6  # Fill remaining time
  else
    sleep 8
  end
end
