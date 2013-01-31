require 'yaml'

class EntityManager
  def initialize(filename=nil)
    @lowestUnassignedEntityID=1
    @labledEntities = {}
    @allEntities = []
    @componentStores = {}
    load(filename) if filename
  end
  def get_component(entity, componentType)
    store = @componentStores[componentType]
    raise "GET FAIL: there are no entities with a Component of class: "+
    componentType.to_s unless store
    result = store[entity]
    raise "GET FAIL: "+entity.to_s+" does not possess Component of class\n"+
    "   missing: "+componentType.to_s unless result
    result
  end
  def get_labled_component(label, componentType)
    raise "GET LABLED FAIL: no entity labled: #{label}" unless @labledEntities[label]
    get_component(@labledEntities[label], componentType)
  end
  def get_all_components_of_type(componentType)
    store = @componentStores[componentType]
    return [] unless store
    store.values
  end
  def get_all_entities_possessing_component(componentType)
    store = @componentStores[componentType]
    return [] unless store
    store.keys
  end
  def add_component( entity, component )
    @componentStores[component.class] ||= {}
    @componentStores[component.class][entity] = component
  end
  def create_entity(label=nil)
    if label && @labledEntities[label]
      raise "CREATE FAIL: there already exist entity labled: #{label}" if label
    end
    newID = generateNewEntityID
    @allEntities.push newID
    @labledEntities[label] = newID if label
    newID
  end
  def kill_entity(entity)
    @allEntities.delete(entity)
    @componentStores.each do |c|
      c[1].delete entity
    end
  end
  def generateNewEntityID
    @lowestUnassignedEntityID += 1
    @lowestUnassignedEntityID - 1
  end
  def save(filename)
    entities={}
    @allEntities.each do |e|
      entities[e]={}
      entities[e]["label"] = @labledEntities.index(e) if @labledEntities.value?(e)
      entities[e]["components"]=[]
      @componentStores.each do |name, stores|
        entities[e]["components"].push stores[e] if stores[e]
      end
    end
    #File.open(filename,"w"){|f| f.write(entities.to_yaml)}
    File.open(filename, "w") { |file| YAML.dump(entities, file) }
  end
  def load(filename)
    parsed = YAML.load(File.open(filename))
    @componentStores={}
    @allEntities = []
    @labledEntities = {}
    parsed.each do |e, components|
      components["components"].each do |c|
        @componentStores[c.class]||={}
        @componentStores[c.class][e] = c
      end
      @labledEntities[components["label"]] = e if components["label"]
      @lowestUnassignedEntityID = [@lowestUnassignedEntityID, e+1].max
      @allEntities.push e
    end
  end
end

if __FILE__==$0

  require 'pp'

  CPosition = Struct.new(:x,:y,:a)
  CSprite   = Struct.new(:x,:y,:filename,:width,:height,:offset_x,:offset_y)

  manager = EntityManager.new
  e = manager.create_entity
  manager.add_component(e, CPosition.new(30,40,-90))
  manager.add_component(e, CSprite.new(0,0,"testname.png", 32,32,16,16))
  e = manager.create_entity(:player)
  manager.add_component(e, CPosition.new(30,40,-90))
  #puts manager.to_yaml
  manager.save "mm.yaml"
  puts
  #puts File.open("mm.yaml").read
  puts
  manager2 = EntityManager.new "mm.yaml"
  #pp manager2
  raise "ERROR save/load" unless manager.to_yaml == manager2.to_yaml

  pl = manager2.get_labled_component(:player,CPosition)
  pl.x=22

  pp manager2
end




