require 'test_helper'

class LoginControllerTest < ActionController::IntegrationTest

  def setup
    User.new({:cn => "Raoni", :sn => "Boaventura", :userPassword => "blibli", :uid => "raoni"}).save
  end

  # Replace this with your real tests.
    def test_logar
            get '/'
            assert_redirected_to '/login'

            get '/login'
	    assert_tag :tag => 'form', :attributes => { :action => '/login/login', :method => 'post' }

	    post '/login/login', :login => { :name => "raoni", :password => "blibli" }
	    assert_redirected_to '/' 
    end

    def teardown
      User.destroy_all
    end
end
