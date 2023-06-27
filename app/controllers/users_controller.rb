class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token


  def create
   @user = User.new(user_params)
 
   if @user.save
     render json: {message: 'User created successfully',user: @user},status: :created
   else
     render json: {error: @user.errors.full_messages},status: :unprocessable_entity
   end

  end

  def update
    @user = User.find_by(id: params[:id])

    unless @user
      render json: {error: 'User not found'},status: :not_found
      return
   end

   if @user.update(user_params)
    render json: {message: 'User updated successfully',user: @user}
   else
     render json: {error: @user.errors.full_messages},status: :unprocessable_entity
   end

  end

  private

  def user_params

    params.require(:user).permit(:name,:password)

  end


end
