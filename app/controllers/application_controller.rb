class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # Prevent the browser + Turbo from serving a stale HTML document during
  # development (so live edits always show on reload). No effect in production.
  before_action :no_cache_in_dev
  private
  def no_cache_in_dev
    return unless Rails.env.development?
    response.headers["Cache-Control"] = "no-store, no-cache, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
  end
end
