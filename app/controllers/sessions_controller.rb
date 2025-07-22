class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(student_no: params[:student_no])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to books_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid student number or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully."
  end
end
