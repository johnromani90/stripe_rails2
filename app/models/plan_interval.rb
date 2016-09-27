class PlanInterval
  attr_accessor :id
  attr_accessor :duration

  def self.find(id)
    @items.find {|item| item.id == id}
  end

  def self.find_by_duration(name)
    @items.find {|item| item.duration == name}
  end

  def self.all
    @items
  end

  def to_s
    return self.duration
  end

  def monthly?
    duration == 'month'
  end

  def yearly?
    duration == 'year'
  end


  def self.add_item(id, duration )
    @items ||= Array.new

    item = PlanInterval.new
    item.id = id
    item.duration = duration

    @items.push(item)
  end

  PlanInterval.add_item 1, 'month'
  PlanInterval.add_item 2, 'year'
end