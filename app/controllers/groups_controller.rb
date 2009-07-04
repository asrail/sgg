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
      end
    end
  end
end
