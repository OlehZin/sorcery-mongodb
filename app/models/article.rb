class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,         type: String
  field :body,          type: String

  belongs_to :user

  validates :title, uniqueness: true, length: { minimum: 4 }
  validates :body,  presence: true, length: { maximum: 10000 }

end
