class NewsController < ApplicationController
  before_action :require_login, except: [:new, :create]

  def index
  end
end
