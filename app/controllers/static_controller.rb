class StaticController < ApplicationController

  skip_before_filter :authenticated?

  def index
    if current_user
      redirect_to controller: :home, action: :index
    end
  end
end
