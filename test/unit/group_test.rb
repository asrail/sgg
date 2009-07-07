require File.dirname(__FILE__) + '/../test_helper'

class GroupTest < Test::Unit::TestCase

  def teardown
    Group.destroy_all
  end

  def test_creating_a_group
    g = Group.new({:cn => 'testgroup', :gidNumber => 2})
    assert_equal 'testgroup', g.cn
    assert_equal 2, g.gidNumber
  end

end
