class ErrorSerializer

  def initialize(error)
    @error = error
  end

  def location_params_missing
    {
        errors: [
          {
            detail: "Request must contain location parameters. Example: location=Denver,CO",
          }
        ]}
  end

  def user_error_messages
    {
      errors: [
        {
          detail: "User creation failed: #{@error.full_messages.uniq.join(", ")}"
        }
      ]
    }
  end

  def parameters_not_in_raw_json_body
    {
        errors: [
          {
            detail: "User creation failed: Parameters must be sent in raw JSON payload within body of request"
          }
        ]
      }
  end

  def email_password_combination_incorrect
    {
        errors: [
          {
            detail: "Validation failed: Email/password combination incorrect"
          }
        ]
      }
  end

  def api_key_error
    {
        errors: [
          {
            detail: "Request must contain api_key, if api_key was provided it may be incorrect",
          }
        ]}
  end

  def road_trip_params_empty
    {
      errors: [
        {
          detail: "Road Trip creation failed: Origin and Destination must be passed through in JSON payload through body of request",
        }
      ]}
  end

  def parameters_not_in_raw_json_body_road_trip
    {
        errors: [
          {
            detail: "Road Trip creation failed: Parameters must be sent in raw JSON payload within body of request"
          }
        ]
      }
  end
end