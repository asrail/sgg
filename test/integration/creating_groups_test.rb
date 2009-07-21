require 'test_helper'

class CreatingGroupsTest < ActionController::IntegrationTest

  def setup
    User.new({:cn => "Raoni", :sn => "Boaventura", :userPassword => "blibli", :uid => "raoni"}).save
  end

  def test_login
    get '/'
    assert_redirected_to '/login'


    get '/login'
    assert_tag :tag => 'form', :attributes => { :action => '/login/login', :method => 'post' }
    post '/login/login', :login => { :name => "raoni", :password => "blibli" }
    assert_redirected_to '/'
    get '/groups'

    get '/groups/new'
    assert_tag :tag => 'form', :attributes => { :action => "/groups/new", :method => 'post' }

    post '/groups/new', :group => { :cn => "Benneton", :gidNumber => 11, :coordinatorUid => "raoni" }
    assert_redirected_to '/groups'

    follow_redirect!
    assert_tag :content => 'Benneton'
  end
  

  def teardown
    Group.destroy_all
    User.destroy_all
  end

end
