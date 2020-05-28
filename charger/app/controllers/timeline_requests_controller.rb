class TimelineRequestsController < ApplicationController
  # GET /timeline_requests/new
  def new
    @timeline_request = TimelineRequest.last_24h
  end

  # POST /timeline_requests
  def create
    @timeline_request = TimelineRequest.build(timeline_request_params)

    unless @timeline_request.valid?
      render :new
      return
    end

    ::FetchUrlsJob.perform_later(@timeline_request)

    redirect_to new_timeline_request_url, notice: 'Timeline request was successfully created.'
  end

  private

  def timeline_request_params
    args = params.require(:timeline_request).permit(
      :start_date,
      :end_date,
      :to
    )

    if args["start_date(1i)"]
      args[:start_date] = (1..5).map { |idx| args["start_date(#{idx}i)"] }
    end

    if args["end_date(1i)"]
      args[:end_date] = (1..5).map { |idx| args["end_date(#{idx}i)"] }
    end

    args
  end
end
