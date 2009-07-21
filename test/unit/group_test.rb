require File.dirname(__FILE__) + '/../test_helper'

class GroupTest < Test::Unit::TestCase

  def setup
    @raoni3 = User.new({:cn => "Raoni", :sn => "Boaventura", :userPassword => "blibli", :uid => "raoni"}).save
  end

  def teardown
    Group.destroy_all
    User.destroy_all
  end

  def test_creating_a_group
    g = Group.new({:cn => 'testgroup', :gidNumber => 2, :coordinatorUid => [@raoni3], :memberUid => [@raoni3]})
    assert_equal 'testgroup', g.cn
    assert_equal 2, g.gidNumber
  end

end
