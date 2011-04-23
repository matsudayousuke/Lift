class ObjectivesController < ApplicationController

  before_filter :authenticate

  def new
    @objective = Objective.new
  end

  def create
    @objective  = current_user.objectives.build(params[:objective])
    if @objective.save
      flash[:success] = "目標を登録しました。"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end
 
end
