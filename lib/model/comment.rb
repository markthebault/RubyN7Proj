class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion

# validate that fields are not empty
  validates_presence_of :comment
end
