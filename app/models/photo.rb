# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord

  mount_uploader :image, ImageUploader
  
  def owner
    owner_id = self.owner_id
    the_owner = User.where({ :id => owner_id}).first
    return the_owner
  end

  def fans
      the_photo_id = self.id
      matching_fans = Like.where({ :photo_id => the_photo_id})
      return matching_fans
  end

  def comments
    the_photo_id = self.id
    matching_comments = Comment.where({ :photo_id => the_photo_id}).order({ :created_at => :desc})
    return matching_comments
  end

  def liked_by(current_user)
    if (self.like(current_user) == nil)
      return false
    else
      return true
    end
  end

  def like(current_user)
    the_photo_id = self.id
    the_fan_id = current_user.id
    the_like = Like.where({ :fan_id => the_fan_id }).where({:photo_id => the_photo_id}).first
    return the_like
  end

end
