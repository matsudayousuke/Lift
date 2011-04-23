class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.authenticate(params[:session][:user_name],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "ユーザ名かパスワードに誤りがあります。"
      render 'new'
      return
    end
    sign_in user
    redirect_back_or user
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
