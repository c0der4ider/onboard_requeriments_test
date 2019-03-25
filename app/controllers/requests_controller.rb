class RequestsController < ApplicationController
  before_action :set_request, only: [:vote, :show]

  def index
    @requests = Request.filter(params)
    render partial: 'request/lists'
  end

  def show
    render partial: 'request/vote', locals: { request: @request }
  end

  # By remote process, create request, assign current user id to the request object.
  # Callback to ajax if create was a success or not. In the ajax function, call
  # the partial where the list is, refreshing with the new one.
  #
  def create
    @request = Request.new(secure_params)
    @request.user_id = current_user.id
    if @request.save
      respond_to do |format|
        format.json{
          render json: { status: 'success' }
        }
      end
    else
      respond_to do |format|
        format.json{
          render json: { status: 'error' }
        }
      end
    end
  end

  # Vote fuction access by ajax request. Use params options to get actions (+1 or -1 vote) and creating vote.
  # Return vote partial to refresh votes in the view by ajax.
  #
  def vote
    if params[:vote_action] == 'up'
      Vote.create(point: true, user_id: current_user.id, request_id: @request.id)
    else
      Vote.create(point: false, user_id: current_user.id, request_id: @request.id)
    end
    render partial: 'request/vote', locals: { request: @request }
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def secure_params
    params.require(:request).permit(:title, :description)
  end
end
