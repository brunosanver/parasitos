class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :fabrication

  mount_uploader :avatar, AvatarUploader

  def self.search(search)
    where("title LIKE ?", "%#{search}%")
  end
end
