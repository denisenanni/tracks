use_bpm 300

live_loop :break_effects do
  sync :main_melody
  loop_num = get[:global_loop_count]
  puts "Effects: Loop count: #{loop_num}, global: #{get[:global_loop_count]}"
  if loop_num == 10 # Breakdown
    puts "BREAKDOWN - PLAYING AMBIENT SOUND"
    sample :ambi_lunar_land, amp: 1, rate: -0.46
    sleep 8
  else
    sleep 8
  end
end


live_loop :tension_builder do
  sync :main_melody
  loop_num = get[:global_loop_count]
  
  if loop_num >= 40 && loop_num < 50
    use_synth :saw
    tension = (loop_num - 40) / 8.0
    base_note = :Eb2
    
    with_fx :hpf, cutoff: 60 + (tension * 40) do
      play base_note, amp: 0.1 + (tension * 0.3), release: 8, 
           cutoff: 40 + (tension * 60)  # Rising filter on the synth
      sleep 8
    end
  else
    sleep 8
  end
end