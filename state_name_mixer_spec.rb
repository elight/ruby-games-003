require 'benchmark'

class StateNameMixer
  def self.mix_it_up(states)
    states.map! { |s| s.gsub(/\s/, "") }
    states.each do |state_a| 
      (states - [state_a]).each do |state_b|
        munged_string = (state_a + state_b).downcase
        (states - [state_a] - [state_b]).each do |state_c|
          (states - [state_a] - [state_b] - [state_c]).each do |state_d|
            char_array = (state_a + state_b).split(//)
            found = true
            (state_c + state_d).each_char do |c|
              index_of_char = char_array.index(c)
              if index_of_char 
                char_array.delete_at index_of_char
              else 
                found = false
                next
              end
            end
            return [[state_a, state_b], [state_c, state_d]] if found
          end
        end
      end
    end
  end
end

# Here is the problem statement:
# Take the names of two U.S. States, mix them all together, 
# then rearrange the letters to form the names of two other 
# U.S. States. Return the an array of arrays, the first being
# the original states, and the second being the resulting two states.
describe StateNameMixer do

  all_states = [ 'Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming' ]

  it "should have the same exact result set as the internal Ruby method" do

    Benchmark.bm do |x|
      x.report("mix_it_up") do
        @original_states, @resultant_states = *StateNameMixer.mix_it_up( all_states )
      end

      original_char_array = @original_states.join.downcase.split(//)
      result_char_array = @resultant_states.join.downcase.split(//)

      correct = true
      result_char_array.each do |c|
        index_of_char = original_char_array.index(c)
        if index_of_char 
          original_char_array.delete_at index_of_char
        else 
          correct = false
          break
        end
      end

      correct.should be_true

      p @original_states
      p @resultant_states
    end
  end

  describe "Given a list of all states" do
    it "should select a state A" 
    it "should select a state B"
    it "should have selected states such that A != B"
    
    describe "and given two different states A and B from that list" do
      describe "and choosing two other states C and D" do
        it "should check the list of states to determine if two other states C and D can be picked from A + B"

        describe "and if we don't have a match yet" do
          it "should choose a new A & B and repeat" 
        end

        describe "if we have a match" do
          it "should return the result" 
        end
      end
    end
  end
end 




