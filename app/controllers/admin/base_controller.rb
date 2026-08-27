module Admin
  class BaseController < ApplicationController
    # Single shared password for the admin area (no user accounts needed for a
    # personal site). Set ADMIN_PASSWORD in the environment; falls back to a
    # development default so local work isn't blocked.
    http_basic_authenticate_with(
      name: ENV.fetch("ADMIN_USERNAME", "admin"),
      password: ENV.fetch("ADMIN_PASSWORD", "changeme-dev"),
      realm: "Portfolio Admin"
    )

    # Admin pages are plain HTML navigations, not Turbo SPA navigations.
    layout "admin"
  end
end
