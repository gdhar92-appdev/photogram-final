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

end
