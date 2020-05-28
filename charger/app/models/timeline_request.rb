# frozen_string_literal: true

class TimelineRequest
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :start_date
  attr_accessor :end_date
  attr_accessor :to

  validates :start_date,
            presence: true
  validates :end_date,
            presence: true
  validates :to,
            presence: true,
            length: { minimum: 3, maximum: 255 },
            format: { with: /[^@]+@[^@]+/ }
  validate :start_date_lteq_end_date

  def initialize(start_date, end_date, to)
    @start_date = start_date
    @end_date = end_date
    @to = to
  end

  def self.build(params)
    start_date = parse_datetime_ary(params[:start_date])
    end_date = parse_datetime_ary(params[:end_date])

    new(start_date, end_date, params[:to])
  end

  def self.parse(start_date, end_date, to)
    start_date = Time.zone.parse(start_date)
    end_date = Time.zone.parse(end_date)

    new(start_date, end_date, to)
  end

  def self.parse_datetime_ary(datetime_ary)
    return nil if datetime_ary.nil?

    Time.use_zone('UTC') do
      Time.zone.local(*datetime_ary)
    end
  end

  def self.last_24h
    now = Time.current
    yesterday = now - 1.day

    TimelineRequest.new(yesterday, now, '')
  end

  def start_date_lteq_end_date?
    return false if start_date.nil? || end_date.nil?

    start_date <= end_date
  end

  def start_date_lteq_end_date
    return if start_date_lteq_end_date?

    errors.add(
      :start_date,
      :gt_end_date,
      message: 'must be lower or equal to end_date'
    )
  end

  def persisted?
    false
  end
end
