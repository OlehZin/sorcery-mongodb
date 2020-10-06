class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :title,         type: String
  field :body,          type: String
  #field :articles_id,   type: Integer

  #field :user_id,       type: Integer
  #field :user_id,   type: DateTime
end
