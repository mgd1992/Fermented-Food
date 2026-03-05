class PwaController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
  skip_before_action :verify_authenticity_token, only: [:service_worker]

  def manifest
    render template: "pwa/manifest", formats: [:json], content_type: "application/json"
  end

  def service_worker
    render template: "pwa/service_worker", content_type: "application/javascript"
  end
end
