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
end