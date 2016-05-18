class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, :nationality, :address, :zip_code, :city, :country, :phone_number)
  end

end
