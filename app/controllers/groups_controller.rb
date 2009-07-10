class GroupsController < ApplicationController
  def index
    @groups = Group.find(:all)
  end

  def new
    if params[:group]
      if params[:group][:cn] == ""
    flash[:notice] = "<p>Favor preencher o campo Nome.</p>"
      else
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
      elsif user.groups.member?group
        flash[:notice] = "<p>Usuário já pertence ao grupo.</p>"
      else
        group.members << [user]
        flash[:notice] = "<p>Usuário adicionado com sucesso.</p>"
      end
    else
      flash[:notice] = "<p>Por favor, informe o usuário.</p>"
    end
    redirect_to :back
  rescue TypeError
    flash[:notice] = "<p>Erro inesperado.</p>"
    redirect_to :back
  end

  def add_coordinator
    group = Group.find(params[:group])
    user = User.find(params[:user])
    group.coordinators << [user]
    flash[:notice] = "<p>Coordenador adicionado com sucesso.</p>"
    redirect_to :back
  end

  def coordinator?(group, user)
    return group.coordinators.member?user
  end

  def back
    redirect_to :back
  end
end
