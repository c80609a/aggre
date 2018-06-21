class ExceptionsHandler

  # TODO-my:: завершить имплементацию

  rescue_from Exception, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404


  def render_404(exception = nil)
    if request.xhr?
      # render nothing: true, status: :internal_server_error
    else
      # respond_to do |format|
      #   format.html { render file: 'public/404', status: :not_found, layout: 'error' }
      #   format.all { render nothing: true, status: :not_found }
      # end
    end
  end



  def render_500(exception = nil)
    # handle_500(exception) if exception

    if request.xhr?
      # render nothing: true, status: :internal_server_error
    else
      # respond_to do |format|
      #   format.html { render file: 'public/500', status: :internal_server_error, layout: 'error' }
      #   format.all { render nothing: true, status: :internal_server_error }
      # end
    end
  end

end
