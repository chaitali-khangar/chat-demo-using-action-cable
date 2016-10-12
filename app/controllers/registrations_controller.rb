class RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create 
    user = User.new(user_params)
    user.ip_address = request.remote_ip
    chatroom = Chatroom.create(topic: "support_for_#{user.username}")
    Message.create(chatroom_id: chatroom.id, user_id: 0,content: "Hi, How can I help you?")
    if user.save
      session[:user_id] = user.id
      redirect_to chatroom_path(chatroom.id)
    else
      redirect_to signup_path, flash[:notice] =  user.errors.messages
    end
  end

  private

    def user_params
      params.require(:user).permit(:username)
    end
end