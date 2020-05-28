# frozen_string_literal: true

require 'domain/date_time/parse'

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
    start_date = params[:start_date]
    start_date = ::Domain::DateTime::Parse::Array.(start_date) unless start_date.nil?
    end_date = params[:end_date]
    end_date = ::Domain::DateTime::Parse::Array.(end_date) unless end_date.nil?

    new(start_date, end_date, params[:to])
  end

  def self.parse(start_date, end_date, to)
    start_date = ::Domain::DateTime::Parse::ISO8601.(start_date)
    end_date = ::Domain::DateTime::Parse::ISO8601.(end_date)

    new(start_date, end_date, to)
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
