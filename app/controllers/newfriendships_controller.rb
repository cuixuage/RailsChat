class NewfriendshipsController < ApplicationController
  include SessionsHelper
  before_action :logged_in

      #传递的frinedid是当前用户id  从newfriendship中寻找newfriendid == friendid的项
      #此项数据再放入 friendship表中  同时从newfriendship将其删除
      #测试:  userid 是我输入的id
      
  def create        #处理 post请求
      newfriend = current_user.newfriendships.find_by(user_id: params[:friend_id])        #为什么一直是空的对象呢？？
      flash[:success]= params[:friend_id]
      friendship = Friendship.new
      friendship.friend_id = newfriend.new_friend_id
      friendship.user_id = newfriend.user_id
      if friendship.save!
        self.destroy(newfriend.new_friend_id);
        flash[:success]= newfriend.user_id
        redirect_to chats_path
      end
      redirect_to chats_path
  end

  def destroy(kid)
    newid = kid
    @friendship = Newfriendship.find_by(new_friend_id: newid)
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
