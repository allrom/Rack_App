# To change this license header, choose License Headers in Project Properties.
# This class requests and forms date:time as array.
#
class TimeFormatter
  ALLOWED_FORMATS = %w[year month day hour minute second].freeze

  def initialize(params)
    @input_params = params
  end

  def input_formats
    @input_params.split(',')
  end

  def work_formats
    input_formats & ALLOWED_FORMATS
  end

  def unknown_formats
    input_formats - ALLOWED_FORMATS
  end

  def formatted_time
    timestamp = Time.now
    timestamp.strftime('%Y,%m,%d,%H,%M,%S').split(',')
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise ArgumentError, "Wrong Date/Time format parameter" unless unknown_formats.empty?
  end
end
