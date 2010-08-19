class Tt
  def hi
    puts "Hi!"
  end
  
  def method_missing(*)
    puts "method_missing"
  end
end

wf = Tt.new
