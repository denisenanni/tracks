puts "Loading track files..."



base_path = "/Users/denisenanni/Desktop/tracks/track01/" 

# Load all track components
run_file base_path + "main.rb"                    # Core melody and bass
run_file base_path + "drums.rb"                   # All drum loops
run_file base_path + "arpeggios.rb"               # All arpeggio loops  
run_file base_path + "effects.rb"                 # Effects and breakdowns
run_file base_path + "pads.rb"                    # Pads

puts "All files loaded! Track should be running..."

