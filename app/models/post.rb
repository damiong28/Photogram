class Post < ActiveRecord::Base
  validates :user_id, presence: true 
  validates :image, presence: true
  belongs_to :user
  has_attached_file :image, styles: { :medium => "640px" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  acts_as_votable
  scope :of_followed_users, -> (following_users) { where user_id: following_users }  
end
