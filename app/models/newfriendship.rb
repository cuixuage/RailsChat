class Newfriendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  
  # def self.search_friends(params, current_user)
  #   User.all_except(current_user).all_except(current_user.friends).where("users.name LIKE ?", "%#{params[:query]}%")
  # end
end
