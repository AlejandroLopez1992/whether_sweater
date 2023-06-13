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
end