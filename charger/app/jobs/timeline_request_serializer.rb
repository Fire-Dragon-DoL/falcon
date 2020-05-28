class TimelineRequestSerializer < ActiveJob::Serializers::ObjectSerializer
  def serialize?(argument)
    argument.is_a? ::TimelineRequest
  end

  def serialize(timeline)
    super({
      "start_date" => timeline.start_date.iso8601,
      "end_date" => timeline.end_date.iso8601,
      "to" => timeline.to
    })
  end

  def deserialize(hash)
    ::TimelineRequest.parse(
      hash["start_date"],
      hash["end_date"],
      hash["to"]
    )
  end
end
