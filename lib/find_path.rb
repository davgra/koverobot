
def find_path(from, to, map=nil)
  if map
    m={}
    map.each_key do |x|
      map[x].each_key do |y|
        m[y]||={}
        m[y][x] = [1  ,100]
        m[y][x] = [1.5,100] if map[x][y][:bg] == :gravel
        m[y][x] = [0  ,111] if map[x][y][:fg]
      end
    end
    m[to[1]][to[0]] = [1,0]

    l=[to]
    i=0
    j=0
    #while i<90 do
    while i<90 do
      check=l
      check.size.times do |k|
        c=check.shift
        check.push add(c,[-1,0])
        check.push add(c,[+1,0])
        check.push add(c,[0,+1])
        check.push add(c,[0,-1])
      end
      l=[]
      check.each do |x,y|
        if m[y] && m[y][x] && m[y][x][0]>0 && m[y][x][1]>i+1
          l.push [x,y]
          m[y][x][1]=i+1
          j=i && i = 98 if [x,y] == from
        end
      end
      i = i+1
    end
    #print_m(m)
    l=[]
    p=from
    #j=9
    while j>0 do
      x,y=p
      if m[y] && m[y][x+1] && m[y][x+1][1]==j-1
        l.push :right
        p=add(p,[1,0])
      elsif m[y] && m[y][x-1] && m[y][x-1][1]==j-1
        l.push :left
        p=add(p,[-1,0])
      elsif m[y+1] && m[y+1][x] && m[y+1][x][1]==j-1
        l.push :down
        p=add(p,[0,1])
      elsif m[y-1] && m[y-1][x] && m[y-1][x][1]==j-1
        l.push :up
        p=add(p,[0,-1])
      end
      j-=1
    end
    l
  else
    path = []
    (to[0]-from[0]).times{ path.push :right }
    (to[1]-from[1]).times{ path.push :down }
    (from[0]-to[0]).times{ path.push :left }
    (from[1]-to[1]).times{ path.push :up }
    path
  end
end

def add(l1, l2)
  [l1[0]+l2[0],l1[1]+l2[1]]
end

def print_m(m)
    m.each_key{|y| m[y].each{|x,e| print e[0]>0 ? (e[1]<100 ? ("%2s"%e[1]) : " _") : " x" }; puts ""}
end

system "rspec ../spec/#{File.basename $0,'.rb'}_spec.rb" if __FILE__ == $0
