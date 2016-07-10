class Notification < ActiveRecord::Base
  validates :user_id, :notified_by_id, :post_id, :identifier, 
    :notice_type, presence: true
  
  belongs_to :user
  belongs_to :notified_by, class_name: 'User'
  belongs_to :post
end
