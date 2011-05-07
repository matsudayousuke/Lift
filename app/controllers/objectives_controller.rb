class ObjectivesController < ApplicationController

  before_filter :authenticate

  def new
    @objective = Objective.new
  end

  def edit
    @objective = Objective.find(params[:id])
  end

  def create
    @objective  = current_user.objectives.build(params[:objective])
    if @objective.save
      flash[:success] = "目標を登録しました。"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @objective = Objective.find(params[:id])
    if @objective.update_attributes(params[:objective])
      flash[:success] = "目標を更新しました。"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    Objective.find(params[:id]).destroy
    flash[:success] = "目標が削除されました。"
    redirect_to root_path
  end
end
