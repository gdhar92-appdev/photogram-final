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
    follow_request_entry = FollowRequest.where({:recipient_id => recipient_id }).where({ :sender_id => sender_id }).first
    if follow_request_entry == nil
      return 4
    else     
      follow_status = follow_request_entry.status
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

  def is_follower_of(recipient_id)
    sender_id = self.id 
    #recipient_id = session.fetch(:user_id).to_i
    follow_request_entry = FollowRequest.where({:recipient_id => recipient_id }).where({ :sender_id => sender_id }).first
    if follow_request_entry == nil
      return 4
    else     
      follow_status = follow_request_entry.status
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

  def followers
    user_id = self.id
    accepted_requests = FollowRequest.where({ :status => "accepted" })
    user_followers = accepted_requests.where({ :recipient_id => user_id})
    return user_followers
  end

  def following
    user_id = self.id
    accepted_requests = FollowRequest.where({ :status => "accepted" })
    user_following = accepted_requests.where({ :sender_id => user_id})
    return user_following
  end

  def photos
    user_id = self.id
    matching_photos = Photo.where({ :owner_id => user_id})
    return matching_photos
  end

end
