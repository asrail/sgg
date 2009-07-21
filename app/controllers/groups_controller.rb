class GroupsController < ApplicationController
  def index
    @groups = Group.find(:all)
  end

  def new
    if params[:group]
      if params[:group][:cn] == ""
        flash[:notice] = "<p>Favor preencher o campo Nome.</p>"
      elsif params[:group][:coordinatorUid] == ""
        flash[:notice] = "<p>Favor preencher o campo Coordenador.</p>"
      else
        if Group.find(:filter => {:cn => params[:group][:cn]})
          flash[:notice] = "<p>Já existe grupo com este nome.<br>Por favor, escolha outro.</p>"
          redirect_to :action => "new"
        end
        User.find(params[:group][:coordinatorUid])
        # Certificando-se que o coordenador seja membro
        par = params[:group]
        par[:memberUid] = [par[:coordinatorUid]]
        par[:coordinatorUid] = [par[:coordinatorUid]]
        @group = Group.new(par)
        if @group.save
          redirect_to :action => 'index'
        else
          flash[:notice] = "<p>Ocorreu um erro ao salvar.<br>Por favor, tente novamente.</p>"
        end
      end
    end
    rescue ActiveLdap::EntryNotFound
      flash[:notice] = "<p>Usuário coordenador não existe</p>"
      redirect_to :action => "new"
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
      elsif group.coordinator?(User.find(session[:username]))
        group.members << [user]
        flash[:notice] = "<p>Usuário adicionado com sucesso.</p>"
      else
        flash[:notice] = "<p>Você não possui permissão para adicionar usuários a este grupo</p>"
      end
    else
      flash[:notice] = "<p>Por favor, informe o usuário.</p>"
    end
    redirect_to :back
  rescue TypeError
    redirect_to :back
  end

  def add_coordinator
    group = Group.find(params[:group])
    user = User.find(params[:user])
    group.coordinators << [user]
    flash[:notice] = "<p>Coordenador adicionado com sucesso.</p>"
    redirect_to :back
  end

  def back
    redirect_to :back
  end
end
