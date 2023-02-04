class FormatTime
  ALLOWED_FORMATS = {
    'year' => :year, 'month' => :month, 'day' => :day,
    'hour' => :hour, 'minute' => :min, 'second' => :sec
  }

  def initialize(request)
    @params = request.params['format'] || []
    @path = request.path
    @incorrect_params = []
  end

  def valid?
    validation_params? && !@params.empty?
  end

  def time
    t = Time.new
    time = params_parser.map { |param| t.send(ALLOWED_FORMATS[param]) }.join('-')
    "#{time}\n"
  end

  def format_mistake
    @incorrect_params
  end

  private

  def params_parse
    @params.split(',') unless @params.empty?
  end

  # validation
  def not_allowed_formats
    @incorrect_params = if params_parse.nil?
                          []
                        else
                          params_parse - ALLOWED_FORMATS.keys
                        end
  end

  def validation_params?
    not_allowed_formats.empty?
  end
end
