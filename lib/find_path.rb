
def find_path(from, to, map=nil, speeds=nil)
  if map
    m={}
    map.each_key do |x|
      map[x].each_key do |y|
        m[y]||={}
        m[y][x] = [1/0.3,100]
        m[y][x] = [1/1.5,100] if map[x][y][:bg] == :gravel
        m[y][x] = [0    ,111] if map[x][y][:fg]
      end
    end
    m[to[1]][to[0]] = [1,0]

    check=[to]
    while check.size>0 do
      check.size.times do |k|
        c=check.shift
        i=m[c[1]][c[0]][1]
        t=m[c[1]][c[0]][0]
        [[-1,0], [+1,0], [0,+1], [0,-1], ].each do |p|
          x,y = add(c,p)
          if m[y] && m[y][x] && m[y][x][0]>0 && m[y][x][1]>i+m[y][x][0]
            check.push [x,y]
            m[y][x][1]=i+m[y][x][0]
          end
        end
      end
    end
#    print_m(m)
    l=[]
    n=[[-1,0,:left],[1,0,:right],[0,-1,:up],[0,1,:down]]
    p = from
    loop do
      x,y=p
      j = m[y][x][1]
      possible=[]
      n.each do |dx,dy,dir|
        if m[y+dy] && m[y+dy][x+dx] && m[y+dy][x+dx][1] < 100
          possible.push [m[y+dy][x+dx][1],dx,dy,dir]
        end
      end
      max,dx,dy,dir = possible.min
      l.push dir
      p=add(p,[dx,dy])
      break if p == to
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
    m.each_key do |y|
      m[y].each do |x,e|
        if e[0]>0
          print e[1]<100 ? ("%4.1f"%e[1]) : "   _"
        else
          print "   x"
        end
      end
      puts ""
    end
    puts ""
end

system "rspec ../spec/#{File.basename $0,'.rb'}_spec.rb" if __FILE__ == $0
