
def anim(basename = "truck")
  wagon = sprite_layout(basename)
  sprite_size = {:x=>wagon["Left"][0][2],:y=>wagon["Left"][0][3] }
  direction = %w{Left Up Right Down}
  filename = File.join(RESOURCES,"#{basename}Sprite.png")
  sheet = SpriteSheet.new(filename, sprite_size[:x], sprite_size[:y])
  anim={}
  direction.each do |dir|
    anim[dir.downcase.to_sym] = Animation.new
    list = wagon[dir].map { |e| [e[0]/e[2], e[1]/e[3]] }
    (0..58).each do |i|
      pos=list[i]
      image = sheet.getSubImage(pos[0],pos[1])
      anim[dir.downcase.to_sym].addFrame(image,67)
    end
    anim["stop_#{dir}".downcase.to_sym] = Animation.new
    (59..66).each do |i|
      pos=list[i]
      image = sheet.getSubImage(pos[0],pos[1])
      anim["stop_#{dir}".downcase.to_sym].addFrame(image,40)
    end
  end
  anim
end

def sprite_layout(basename)
  filename = File.join(RESOURCES,"#{basename}Sprite.txt")
  wagon={}
  File.foreach(filename) do |line|
    line =~ /(#{basename})([A-Z][a-z]*)(\d+)\s*=\s*(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/
    wagon[$2] ||= []
    wagon[$2][$3.to_i-1] = [$4.to_i,$5.to_i,$6.to_i,$7.to_i]
  end
  wagon
end

system "rspec ../../spec/#{File.basename $0,'.rb'}_spec.rb" if __FILE__ == $0
