class FriendshipsController < ApplicationController
  include SessionsHelper
  before_action :logged_in

  def create
    # @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    @newfriendship = current_user.newfriendships.build(:new_friend_id => params[:friend_id])
    if  @newfriendship.save!
      flash[:success] = "添加: "+"user"+ params[:friend_id]+" 好友成功"
      # flash[:success] = "time: "+ current_user.friendships[:timestamp_id].to_s
      redirect_to chats_path
    else
      flash[:error] = "无法添加好友"
      redirect_to chats_path
    end
  end

  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    @friendship.destroy

    user=User.find_by_id(params[:id])
    current_user.chats.each do |chat|
      if (chat.users-[user, current_user]).blank?
        chat.destroy
      end
    end

    flash[:success] = "删除好友成功"
    redirect_to chats_path
  end

  private
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end

end
