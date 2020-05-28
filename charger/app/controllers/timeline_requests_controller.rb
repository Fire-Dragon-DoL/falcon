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

    redirect_to new_timeline_request_url, notice: 'Timeline request was successfully created.'
  end

  private

  def timeline_request_params
    fetched = params.require(:timeline_request).permit(
      :start_date,
      :end_date,
      :to
    )

    if fetched["start_date(1i)"]
      fetched[:start_date] = [
        fetched["start_date(1i)"],
        fetched["start_date(2i)"],
        fetched["start_date(3i)"],
        fetched["start_date(4i)"],
        fetched["start_date(5i)"]
      ]
    end

    if fetched["end_date(1i)"]
      fetched[:end_date] = [
        fetched["end_date(1i)"],
        fetched["end_date(2i)"],
        fetched["end_date(3i)"],
        fetched["end_date(4i)"],
        fetched["end_date(5i)"]
      ]
    end

    fetched
  end
end
