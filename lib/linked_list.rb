class LinkedList
  require 'linked_list_item'

  attr_accessor :first

  def initialize(first=nil, *values)
    @first = LinkedListItem.new(first) if first
    item = @first
    for value in values
      item.next_item = LinkedListItem.new(value)
      item = item.next_item
    end
  end

  def last_item
    item = @first
    if item
      until item.last?
        item = item.next_item
      end
    end
    item
  end

  def last
    item = self.last_item
    return item ? self.last_item.payload : nil
  end

  def push(value)
    item = LinkedListItem.new(value)

    if @first.nil?
      @first = item
    else
      self.last_item.next_item = item
    end
  end

  def get_item(index)
    raise IndexError if index < 0 || !index.is_a?(Integer)
    item = @first
    while index > 0 && !item.nil?
      item = item.next_item
      index -= 1
    end
    raise IndexError if index != 0
    item
  end

  def get(index)
    item = get_item(index)
    payload = item ? item.payload : nil
  end

  def size
    # items.size
    #--------------------------------
    item_count = 0
    item = @first
    while item
      item = item.next_item
      item_count += 1
    end
    item_count
  end

  def to_s
    # items = self.items
    # return items.size > 0 ? '| ' + items.join(', ') + ' |' : '| |'
    #--------------------------------
    joined_items = ''
    item = @first
    while item
      joined_items += (item === @first ? '' : ',') + ' ' + item.payload
      item = item.next_item
    end
    '|' + joined_items + ' |'
  end

  # This function is a 'shortcut' that ought not be used with this exercise
  # def items
  #   items = []
  #   item = @first
  #   while !item.nil?
  #     items.push(item.payload)
  #     item = item.next_item
  #   end
  #   items
  # end

  def [](index)
    get(index)
  end

  def []=(index, value)
    new_item = LinkedListItem.new(value)
    if index > 0
      previous_item = get_item(index-1)
      next_item = get_item(index+1)
      previous_item.next_item = new_item
    elsif index === 0
      next_item = @first.next_item
      @first = new_item
    end
    new_item.next_item = next_item
  end

  def delete(index)
    item_to_delete = get_item(index)
    if index > 0
      previous_item = get_item(index-1)
      next_item = item_to_delete.next_item
      previous_item.next_item = next_item
    elsif index === 0
      @first = item_to_delete.next_item
    end
  end

  def index(value)
    # self.items.index(value)
    #--------------------------------
    index = nil
    current_index = 0
    item = @first
    while item
      if item.payload === value
        index = current_index
        break
      else
        item = item.next_item
        current_index += 1
      end
    end
    index
  end

end
=======
  def initialize(*payloads)
    payloads.each do |payload|
      push(payload)
    end
  end

  def []=(index, payload)
    item = get_item(index)
    item.payload = payload
  end

  def [](index)
    get_item(index).payload
  end
  ## What does this do? Look it up ;)
  alias get []

  def delete(index)
    raise IndexError if index > size
    if index == 0
      @first_item = @first_item.next_item
    else
      previous_item = get_item(index - 1)
      next_item = previous_item.next_item.next_item
      previous_item.next_item = next_item
    end
  end

  def index(payload)
    index = -1
    current_item = @first_item
    until current_item.nil?
      index += 1
      return index if current_item.payload == payload
      current_item = current_item.next_item
    end
    nil
  end

  def push(value)
    lli = LinkedListItem.new(value)
    if @first_item
      last_item.next_item = lli
    else
      @first_item = lli
    end
  end

  def last
    return unless @first_item
    last_item.payload
  end

  ## How could we do this more efficiently?
  def size
    i = 0
    current_item = @first_item
    until current_item.nil?
      i += 1
      current_item = current_item.next_item
    end
    i
  end

  def to_s
    result = "|"
    current_item = @first_item
    until current_item.nil?
      result << " #{current_item.payload}"
      unless current_item.last?
        result << ","
      end
      current_item = current_item.next_item
    end
    result << " |"
    result
  end

  private

  def get_item(index)
    raise IndexError if index < 0
    current_item = @first_item
    index.times do
      raise IndexError if current_item.nil?
      current_item = current_item.next_item
    end
    current_item
  end

  def last_item
    return unless @first_item
    current_item = @first_item
    until current_item.last?
      current_item = current_item.next_item
    end
    current_item
  end
end