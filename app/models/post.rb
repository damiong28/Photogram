class Post < ActiveRecord::Base
  
  # Images
  has_attached_file :image, styles: { :medium => "640px" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :image, presence: true
end
