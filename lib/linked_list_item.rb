class LinkedListItem
  include Comparable

  attr_reader :payload
  attr_reader :next_item

  def initialize(value)
    @payload = value
  end

  def next_item=(item)
    raise ArgumentError if item === self || !(item.is_a?(LinkedListItem) || item.nil?)
    @next_item = item
  end

  def last?
    @next_item.nil?
  end

  def ===(item)
    self.equal? item
  end

  def <=>(item)
    if self.payload.class == item.payload.class
      @payload.to_s <=> item.payload.to_s
    else
      precedence = [Fixnum, String, Symbol]
      left = precedence.index(self.payload.class)
      right = precedence.index(item.payload.class)
      left <=> right
    end
  end
end
