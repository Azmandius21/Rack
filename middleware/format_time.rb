class FormatTime
  FORMATS = %w[year month day hour minute second].freeze

  def initialize(app)
    @app = app
    @request = nil
  end

  def call(env)
    @app.call(env)
    @request = Rack::Request.new(env)

    handle_request
  end

  private

  def path
    @request.path
  end

  def verb
    @request.request_method
  end

  def params
    @request.params
  end

  def handle_request
    if verb == 'GET'
      get
    else
      method_not_allowed(verb)
    end
  end

  def get
    status == 200 ? [status, headers, [time_in_format]] : path_mistake
  end

  def status
    path == '/time' ? 200 : 404
  end

  def path_mistake
    [404, {}, ['Unknown URL']]
  end

  def method_not_allowed(verb)
    [404, {}, ["Method not allowed: #{verb}"]]
  end

  def format_mistake(formats)
    [404, {}, ["Unknown time format: #{formats}"]]
  end

  def headers
    { 'Content type' => 'text/plain' }
  end

  def allowed_formats
    FORMATS
  end

  def request_format
    params['format'].split(',')
  end

  def not_allowed_formats
    request_format - allowed_formats
  end

  def time_in_format
    if not_allowed_formats.empty?
      create_time
    else
      format_mistake(not_allowed_formats)
    end
  end

  def create_time
    t = Time.new.localtime('+05:00')
    time = []
    option = {
      'year' => t.year, 'month' => t.month, 'day' => t.day,
      'hour' => t.hour, 'minute' => t.min, 'second' => t.sec
    }
    request_format.each do |format|
      time << option[format]
    end
    time.join('-') + "\n"
  end
end
