class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def interview_response_created
    if params[:response_id] == nil
      redirect_to root_path
      # eventually redirect to dash path
    end
  end

  # def question_created
  #   if session[:question_id] == nil
  #     redirect_to new_question_path
  #   end
  # end

end
