class AccountsController < ApplicationController

  # PATCH/PUT /account
  def update
    if @user.update(user_params)
      render 'show'
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /account
  def show
  end

  private

  def user_params
    params.require(:user).permit(:email, :address)
  end
end