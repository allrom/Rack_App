# To change this license header, choose License Headers in Project Properties.
# This class requests and forms date:time as array.
#
class TimeFormatter
  require_relative 'errors'

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

  def formatted_response
    @year, @month, @day, @hour, @minute, @second = [""] * 6
    response = []

    fyear, fmonth, fday, fhour, fminute, fsecond = self.formatted_time

    self.work_formats.each do |format|
      case format
      when 'year' then @year = fyear
      when 'month' then @month = fmonth
      when 'day' then @day = fday

      when 'hour' then @hour = fhour
      when 'minute' then @minute = fminute
      when 'second' then @second = fsecond
      end
    end

    response << [@year, @month, @day].map(&:to_s).join('-') + ' '\
                + [@hour, @minute, @second].map(&:to_s).join(':') + "\n"
  end

  def valid?
    validate!
    true
  rescue StandardError => e
    puts e.message
    false
  end

  protected

  def validate!
    raise Errors::FormatError, "Wrong Date/Time format parameter" unless unknown_formats.empty?
  end
end
