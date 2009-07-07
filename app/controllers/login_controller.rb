class LoginController < ApplicationController
  skip_before_filter :authenticate

  def login
    if session[:person] = User.authenticate(params[:login][:name], params[:login][:password])
      session[:username] = params[:login][:name]
      if session[:return_to]
        redirect_to(session[:return_to])
        session[:return_to] = nil
      else
        #XXXasrail: testar com :back
        #redirect_to :controller => "default"
      end
    else
      flash[:notice] = "Senha ou usuário incorretos"
      redirect_to :action => "index"
    end
  end
end
