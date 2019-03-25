class HomeController < ApplicationController
  def index
    @requests = Request.filter(params)
  end
end
