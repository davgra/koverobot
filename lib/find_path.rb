
def find_path(from, to)
  path = []
  (to[0]-from[0]).times{ path.push :right }
  (to[1]-from[1]).times{ path.push :down }
  (from[0]-to[0]).times{ path.push :left }
  (from[1]-to[1]).times{ path.push :up }
  path
end

system "rspec ../../spec/#{File.basename $0,'.rb'}_spec.rb" if __FILE__ == $0
