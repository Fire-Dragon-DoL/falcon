class TimelineRequestsController < ApplicationController
  # GET /timeline_requests/new
  def new
    @timeline_request = TimelineRequest.new
  end

  # POST /timeline_requests
  def create
    @timeline_request = TimelineRequest.new(timeline_request_params)

    if @timeline_request.save
      redirect_to @timeline_request, notice: 'Timeline request was successfully created.'
    else
      render :new
    end
  end

  private

  def timeline_request_params
    params.require(:timeline_request).permit(:start_date, :end_date, :to)
  end
end
