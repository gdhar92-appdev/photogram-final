# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  photo_id   :integer
#
class Comment < ApplicationRecord

  def owner
    owner_id = self.author_id
    the_owner = User.where({ :id => owner_id }).first
    return the_owner
  end

end
