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
      flash[:success] = t(:register_success, t(:objective))
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @objective = Objective.find(params[:id])
    if @objective.update_attributes(params[:objective])
      flash[:success] = t(:update_success, t(:objective))
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    Objective.find(params[:id]).destroy
    flash[:success] = t(:delete_success, t(:objective))
    redirect_to root_path
  end
end
