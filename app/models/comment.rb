class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  validates :commenter, length: { minimum: 5 }
  validates :body, presence: true
end
