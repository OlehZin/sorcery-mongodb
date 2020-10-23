require Rails.root.join("lib", "rails_admin", "published_article")
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::PublishedArticle)

RailsAdmin.config do |config|
config.main_app_name = ["test_app"]
config.parent_controller = 'ApplicationController'

config.authenticate_with do
    require_login
  end
config.current_user_method(&:current_user)

config.actions do
  dashboard
  index
  new
  export
  bulk_delete
  show
  edit
  delete
  show_in_app
  published_article do
    only 'Article'
  end
end

config.model User do
  list do
    field :id
    field :email
    field :updated_at
    field :created_at
  end
end

config.model Article do
  list do
    field :title
    field :body
    field :user_email
    field :updated_at
    field :created_at
    end
  end
end
