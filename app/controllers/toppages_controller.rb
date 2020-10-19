class ToppagesController < ApplicationController
  def index
    if logged_in?
      @tasklist = current_user.tasks.build
      @tasklists = current_user.tasks.order(id: :desc).page(params[:page])
    end
  end
end
