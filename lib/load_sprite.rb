
def sprite_layout(filename)
  wagon={}
  File.foreach(filename) do |line|
    line =~ /([a-z]*)([A-Z][a-z]*)(\d+)\s*=\s*(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/
    wagon[$2] ||= []
    wagon[$2][$3.to_i-1] = [$4.to_i,$5.to_i,$6.to_i,$7.to_i]
  end
  wagon
end

system "rspec ../../spec/#{File.basename $0,'.rb'}_spec.rb" if __FILE__ == $0
