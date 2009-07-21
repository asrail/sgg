require 'test_helper'

class LoginControllerTest < ActionController::IntegrationTest

  def setup
    User.new({:cn => "Raoni", :sn => "Boaventura", :userPassword => "blibli", :uid => "raoni"}).save
  end

  # Replace this with your real tests.
    def test_logar
	    get '/'
            assert_redirected_to '/login'

	    assert_tag :tag => 'form', :attributes => { :action => 'login', :method => 'post' }

	    post '/login', :login => { :name => "raoni", :password => "blibli" }
	    assert_redirected_to '/' 
    end

end
