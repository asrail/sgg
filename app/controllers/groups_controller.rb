class GroupsController < ApplicationController
  def index
    @groups = Group.find(:all)
  end
  def new
    @group = Group.new(params[:group])
    if @group.save
      redirect_to :action => 'index'
    end
  end
end
