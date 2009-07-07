class GroupsController < ApplicationController
  def index
    @groups = Group.find(:all)
  end
  def new
    if params[:group]
      if Group.find(:filter => {:cn => params[:group][:cn]})
        flash[:notice] = "<p>Já existe grupo com este nome.<br>Por favor, escolha outro.</p>"
        redirect_to :action => "new"
      end
      @group = Group.new(params[:group])
      if @group.save
        redirect_to :action => 'index'
      else
        flash[:notice] = "<p>Ocorreu um erro ao salvar.<br>Por favor, tente novamente.</p>"
      end
    end
  end
  def show
    if params[:id]
      @group = Group.find(:filter => {:cn => params[:id]})
      if @group.nil?
        flash[:notice] = "<p>Grupo não existente.</p>"
        redirect_to :action => "index"
      end
    else
      redirect_to :action => "index"
    end    
  end
  def add_member
    group = Group.find(params[:group])
    if params[:user]
      user = User.find(:filter => params[:user])
      if user.nil?
        flash[:notice] = "<p>Usuário não existente.</p>"
      elsif user.groups.member?@group
        flash[:notice] = "<p>Usuário não existente.</p>"
      else
        group.members << user
        if user.groups.member?group
          flash[:notice] = "<p>Usuário adicionado com sucesso.</p>"
        else
          flash[:notice] = "<p>Ocorreu um erro ao adicionar usuário.</p>"
        end
      end
    else
      flash[:notice] = "<p>Por favor, informe o usuário.</p>"
    end        
  end
end
