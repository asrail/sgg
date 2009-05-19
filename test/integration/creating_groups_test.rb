require 'test_helper'

class CreatingGroupsTest < ActionController::IntegrationTest
  #fixtures :all

  test "creating a group" do
    get '/'
    assert_tag :tag => 'a', :attributes => { :href => '/groups' }

    get '/groups'
    assert_tag :tag => 'a', :attributes => { :href => '/groups/new' }

    get '/groups/new'
    assert_tag :tag => 'form', :attributes => { :action => "/groups/new", :method => 'post' }

    post '/groups/new', :group => { :cn => "My new group", :gidNumber => 1111 }
    assert_redirected_to '/groups'

    follow_redirect!
    assert_tag :content => 'My new group'
  end
  
  test 'must not be able to create a group with an existing name'

  def teardown
    Group.destroy_all
  end

end
