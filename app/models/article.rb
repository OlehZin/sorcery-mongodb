class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user

  field :title,         type: String
  field :body,          type: String

  validates :title, uniqueness: true, length: { minimum: 4 }
  validates :body,  presence: true, length: { maximum: 10000 }

end
