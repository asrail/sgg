class UserController < ApplicationController
  def index
    @users = User.find(:all)
  end

  def new
    puts "Ocorreu um erro ao salvar.<br>Por favor, tente novamente."
    if params[:user]
      if ((params[:user][:uid] == "")or(params[:user][:cn] == "")or(params[:user][:sn] == "")or(params[:user][:userPassword] == ""))
	flash[:notice] = "<p>Favor preencher todos os campos.</p>"
      else
        if User.find(:filter => {:uid => params[:user][:uid]})
          flash[:notice] = "<p>Já existe um usuário com este nome.<br>Por favor, escolha outro.</p>"
          redirect_to :action => "new"
        end
        @user = User.new(params[:user])
        if @user.save
          redirect_to :action => 'index'
        else
          flash[:notice] = "<p>Ocorreu um erro ao salvar.<br>Por favor, tente novamente.</p>"
        end
      end
    end
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
      if @user.nil?
        flash[:notice] = "<p>Usuário não existente.</p>"
        redirect_to :action => "index"
      end
    end
  end
end
