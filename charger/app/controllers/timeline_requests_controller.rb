class TimelineRequestsController < ApplicationController
  # GET /timeline_requests/new
  def new
    now = Time.current
    yesterday = now - 1.days
    @timeline_request = TimelineRequest.new(
      yesterday,
      now,
      ""
    )
  end

  # POST /timeline_requests
  def create
    @timeline_request = TimelineRequest.build(timeline_request_params)

    if @timeline_request.valid?
      redirect_to new_timeline_request_url, notice: 'Timeline request was successfully created.'
    else
      render :new
    end
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
