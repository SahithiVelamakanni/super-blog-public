# app/controllers/sessions_controller.rb
class SessionsController < Devise::SessionsController
    def destroy
      super
      redirect_to new_user_session_path
    end
  end
  