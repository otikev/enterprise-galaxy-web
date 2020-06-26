class SiteController < ActionController::Base
  def home
    redirect_to action: 'countdown'
  end

  def countdown; end
end
