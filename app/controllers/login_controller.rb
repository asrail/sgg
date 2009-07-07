class LoginController < ApplicationController
  skip_before_filter :authenticate
  def index
  end

  def login
    if session[:person] = User.authenticate(params[:login][:name], params[:login][:password])
      session[:username] = params[:login][:name]
      if session[:return_to]
        redirect_to(session[:return_to])
        session[:return_to] = nil
      else
        redirect_to :controller => "groups"
      end
    else
      flash[:notice] = "Senha ou usuário incorretos"
      redirect_to :action => "index"
    end
  end
  
  def logout
    session[:person] = nil
    redirect_to :action => "index"
  end
end
