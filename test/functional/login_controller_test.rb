require 'test_helper'

class LoginControllerTest < Test::Unit::TestCase

  # Replace this with your real tests.
    def test_logar
	    get '/'
	    assert_tag :tag => 'a', :attributes => { :href => '/login' }

	    get '/login'
	    assert_tag :tag => 'form', :attributes => { :action => 'login', :method => 'post' }

	    post '/login', :login => { :name => "raoni", :password => "blibli" }
	    assert_redirected_to '/groups' 
    end

end
