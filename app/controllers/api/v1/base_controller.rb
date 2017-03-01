class Api::V1::BaseController < ApplicationController
  before_filter :check_format

  private

  def check_format
    unless params[:format] == 'json' || request.headers['Accept'] =~ /json/
      redirect_to root_url
    end
  end
end
