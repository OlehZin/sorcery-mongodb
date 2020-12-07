class User
  include Mongoid::Document
  include Mongoid::Timestamps
  authenticates_with_sorcery!

  field :admin,                           type: Boolean

  field :email,                           type: String
  field :password,                        type: String
  field :crypted_password,                type: String
  field :salt,                            type: String
  field :remember_me_token,               type: String
  field :remember_me_token_expires_at,    type: DateTime

  field :activation_state,                type: String
  field :activation_token,                type: String
  field :activation_token_expires_at,     type: DateTime

  field :failed_logins_count,             type: Integer
  field :lock_expires_at,                 type: Default
  field :unlock_token,                    type: String

  field :reset_password_token,            type: String
  index({ reset_password_token: 1},
    { unique: true})
  field :reset_password_token_expires_at, type: DateTime
  field :reset_password_email_sent_at,    type: DateTime

  has_many :articles, dependent: :destroy

  validates :password, length: { minimum: 8, maximum: 16 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, email_format: { message: 'has invalid format' }
  # I used validate gem for email validation!
end
