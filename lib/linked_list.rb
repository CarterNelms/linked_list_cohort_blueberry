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