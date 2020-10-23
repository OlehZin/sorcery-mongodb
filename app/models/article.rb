class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,         type: String
  field :body,          type: String
  field :published,     type: Boolean, default: false

  belongs_to :user

  validates :title, uniqueness: true, length: { minimum: 4 }
  validates :body,  presence: true, length: { maximum: 10000 }

  scope :published, -> {where(published: true)}

  def user_email
    self.user.email
  end
end
