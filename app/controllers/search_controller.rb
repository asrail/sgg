class SearchController < ApplicationController
  def index
    if params[:search]
	if params[:search][:for]
		if (params[:search][:for]=="Name")
			if params[:search][:keyword]
				if (params[:search][:keyword]!="")
					@users = User.find(:filter => {:cn => params[:search][:keyword]})
				end
			end
		end
		if (params[:search][:for]=="Surname")
			if params[:search][:keyword]
				if (params[:search][:keyword]!="")
					@users = User.find(:filter => {:sn => params[:search][:keyword]})
				end
			end
		end
	else
		if params[:search][:keyword]
		@users = User.find(:filter => {:cn => params[:search][:keyword]})
		end
	end
    end
  end
end
