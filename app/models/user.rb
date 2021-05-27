# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  
  validates(:username,
    {
      :presence => true,
      :uniqueness => { :case_sensitive => false }
    }
  )

  has_secure_password

  def is_followed_by(sender_id)
    #sender_id = session.fetch(:user_id).to_i
    recipient_id = self.id
    follow_status = FollowRequest.where({:recipient_id => recipient_id }).where({ :sender_id => sender_id }).first
    if follow_status == "accepted"
      return 1
    elsif follow_status == "pending"
      return 2
    elsif follow_status == "rejected"
      return 3
    else
      return 4
    end
  end

  def is_follower_of(recipient_id)
    sender_id = self.id 
    #recipient_id = session.fetch(:user_id).to_i
    follow_status = FollowRequest.where({:recipient_id => recipient_id }).where({ :sender_id => sender_id }).first
    if follow_status == "accepted"
      return 1
    elsif follow_status == "pending"
      return 2
    elsif follow_status == "rejected"
      return 3
    else
      return 4
    end
  end

end
