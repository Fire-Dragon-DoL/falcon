# frozen_string_literal: true

class TimelineRequest
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_reader :start_date
  attr_reader :end_date
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
    self.start_date = start_date
    self.end_date = end_date
    self.to = to
  end

  def self.build(params)
    new(params[:start_date], params[:end_date], params[:to])
  end

  # value is an array of 5 elements for the date time
  def start_date=(value)
    return @start_date = nil if value.nil?

    Time.use_zone("UTC") do
      @start_date = Time.zone.local(*value)
    end
  end

  # value is an array of 5 elements for the date time
  def end_date=(value)
    return @end_date = nil if value.nil?

    Time.use_zone("UTC") do
      @end_date = Time.zone.local(*value)
    end
  end

  def start_date_lteq_end_date?
    return false if start_date.nil? || end_date.nil?

    start_date <= end_date
  end

  def start_date_lteq_end_date
    unless start_date_lteq_end_date?
      errors.add(
        :start_date,
        :gt_end_date,
        message: "must be lower or equal to end_date"
      )
    end
  end

  def persisted?
    false
  end
end
