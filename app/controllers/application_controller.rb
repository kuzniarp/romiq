# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
#  before_filter :authenticate

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '269862e0adc8505d39ac675b7a83b6b0'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  private
  def authenticate
    if RAILS_ENV=="production"
      unless session[:authenticated]
        redirect_to :controller => 'home', :action => 'login'
      end
    end
#    if RAILS_ENV=="production"
#      authenticate_or_request_with_http_basic do |id, password| 
#        id == "romi" && password == "beta"
#      end
#    end
  end
end
