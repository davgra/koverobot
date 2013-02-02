
class SystemDebug < System
  def initialize(manager)
    super(manager)
    @timestamps = {}
    @delay = 0
  end
  def process_one_game_tick(container,delta)
    @delay += delta
    if @delay > 1000
      @delay-=1000
      #p @timestamps
      changed = []
      %w{SystemDebug SystemRender SystemInput}.each do |name|
        f = "lib/#{name}.rb"
        modified_at = File.stat(f).mtime
        changed << f  if @timestamps[f] and modified_at != @timestamps[f]

        @timestamps[f] = modified_at
      end
      if ! changed.empty?
        puts "\nfile(s) changed [#{changed.join(',')}]"
        changed.each do |file|
          eval File.open(file).read
        end
      end
    end

    #@manager.get_all_entities_possessing_component(CInput).each do |e|
    #  pos = @manager.get_component(e,CPosition)
    #  pos.x += 0.01
    #end
  end
end


