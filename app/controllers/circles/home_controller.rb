class Circles::HomeController < Circles::BaseController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_member!

  layout 'circle_app_home'

  def index
    # redirect_to circle_posts_path(current_circle) if current_circle_user&.member?
  end
end
