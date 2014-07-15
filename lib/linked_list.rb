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
      joined_items += (item === @first ? '' : ',') + ' ' + item.payload.to_s
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

  def sorted?
    item = @first
    precedence = [Fixnum, String, Symbol]
    while item
      if item.next_item
        type1 = item.payload.class
        type2 = item.next_item.payload.class
        if type1 == type2
          if item.payload > item.next_item.payload
            return false
          end
        elsif precedence.index(type1) > precedence.index(type2)
          return false
        end
      end
      item = item.next_item
    end
    true
  end

  def sort!
    precedence = [Fixnum, String, Symbol]
    while !self.sorted?
      last_item = nil
      item = @first
      index = 0
      while item
        next_item = item.next_item
        if next_item
          type1 = item.payload.class
          type2 = next_item.payload.class   
          should_swap = type1 == type2 ? item.payload > next_item.payload : precedence.index(type1) > precedence.index(type2)
          if should_swap
            self.swap_with_next(index)
            item = nil
          else
            last_item = item
            item = item.next_item
            index += 1
          end
        end
      end
    end
  end

  def swap_with_next(index)
    if index >= self.size - 1
      raise IndexError
    else
      item = self.get_item(index)
      next_item = item.next_item
      if next_item
        last_item = index > 0 ? self.get_item(index-1) : nil
        if last_item
          last_item.next_item = next_item
        else
          @first = next_item
        end
        item.next_item = next_item.next_item
        next_item.next_item = item
      end
    end
  end

end