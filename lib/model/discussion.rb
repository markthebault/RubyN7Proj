class Discussion < ActiveRecord::Base
  belongs_to :user
  has_many :comments

# validate that fiels are not empty
  validates_presence_of :title
  validates_presence_of :content
end
