class SubscriptionStatus
  attr_accessor :id
  attr_accessor :name
  attr_accessor :active
  attr_accessor :color_class
  attr_accessor :panel_class
  attr_accessor :label_class

  def self.status_active
    SubscriptionStatus.find_by_name('Active')
  end

  def self.status_paused
    SubscriptionStatus.find_by_name('Paused')
  end

  def self.status_invalid
    SubscriptionStatus.find_by_name('Payment method invalid')
  end

  def invalid?
    SubscriptionStatus.status_invalid.id == id
  end

  def self.status_cancelled
    SubscriptionStatus.find_by_name('Cancelled')
  end

  def self.max
    @statuses.count
  end

  def self.find(id)
    @statuses.find {|status| status.id == id}
  end

  def self.find_by_name(name)
    @statuses.find {|status| status.name == name}
  end

  def self.all
    @statuses
  end

  def to_s
    return self.name
  end

  def SubscriptionStatus.add_item(id, name, active, color_class, panel_class, label_class)
    @statuses ||= Array.new

    status = SubscriptionStatus.new
    status.id = id
    status.name = name
    status.active = active
    status.color_class = color_class
    status.panel_class = panel_class
    status.label_class = label_class

    @statuses.push(status)
  end

  SubscriptionStatus.add_item 1, 'Active', true, '', 'panel-default', 'label-default'
  SubscriptionStatus.add_item 2, 'Paused', false, 'success', 'panel-default', 'label-default'
  SubscriptionStatus.add_item 3, 'Payment method invalid', false, 'danger', 'panel-default', 'label-default'
  SubscriptionStatus.add_item 4, 'Cancelled', false, 'danger', 'panel-default', 'label-default'
end