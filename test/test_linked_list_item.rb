require 'nss'
require 'linked_list_item'

class LinkedListItemTest < MiniTest::Unit::TestCase

  def test_00a_triple_equals
    lli = LinkedListItem.new("foo")
    assert lli === lli
  end

  def test_00b_triple_equals
    lli1 = LinkedListItem.new("foo")
    lli2 = LinkedListItem.new("foo")
    assert !(lli1 === lli2)
  end

  def test_01_item_stores_payload
    lli = LinkedListItem.new("foo")
    assert_equal("foo", lli.payload)
  end

  def test_02a_add_next_item
    lli1 = LinkedListItem.new("foo")
    lli2 = LinkedListItem.new("bar")
    lli1.next_item = lli2
    assert_equal(lli2, lli1.next_item)
  end

  def test_02b_cant_set_self_as_next_item
    lli1 = LinkedListItem.new("foo")
    assert_raises ArgumentError do
      lli1.next_item = lli1
    end
  end

  def test_03a_last_is_true_if_item_is_last
    lli = LinkedListItem.new("foo")
    assert_equal true, lli.last?
  end

  def test_03b_last_is_false_if_item_is_not_last
    lli = LinkedListItem.new("foo")
    lli.next_item = LinkedListItem.new("bar")
    assert_equal false, lli.last?
  end

  def test_04a_comparator_greater_than
    lli1 = LinkedListItem.new("foo")
    lli2 = LinkedListItem.new("bar")
    assert lli1 > lli2
  end

  def test_04b_comparator_equal_to
    lli1 = LinkedListItem.new("foo")
    lli2 = LinkedListItem.new("foo")
    assert lli1 == lli2
  end

  def test_04c_comparator_lesser_than
    lli1 = LinkedListItem.new("foo")
    lli2 = LinkedListItem.new("bar")
    assert lli2 < lli1
  end

  def test_04d_comparator_symbol
    lli1 = LinkedListItem.new(:foo)
    lli2 = LinkedListItem.new("bar")
    assert lli1 > lli2
    assert lli2 < lli1
  end

  def test_04e_comparator_integer_string
    lli1 = LinkedListItem.new(1)
    lli2 = LinkedListItem.new("bar")
    assert lli1 < lli2
    assert lli2 > lli1
  end

  def test_04f_comparator_symbol
    lli1 = LinkedListItem.new(:bar)
    lli2 = LinkedListItem.new("bar")
    assert lli1 > lli2
    assert lli2 < lli1
  end

  def test_04g_comparator_integer_string
    lli1 = LinkedListItem.new(1)
    lli2 = LinkedListItem.new("1")
    assert lli1 < lli2
    assert lli2 > lli1
  end

  def test_04h_comparator_lesser_than
    lli1 = LinkedListItem.new(:foo)
    lli2 = LinkedListItem.new(:bar)
    assert lli2 < lli1
  end

  def test_04i_comparator_integer_string
    lli1 = LinkedListItem.new(1)
    lli2 = LinkedListItem.new(2)
    assert lli1 < lli2
    assert lli2 > lli1
  end

end
