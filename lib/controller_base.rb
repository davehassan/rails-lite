require 'phase9/controller_base'

class ControllerBase < Phase9::ControllerBase

  def protect_from_forgery
    unless params["authenticity_token"] == session["authenticity_token"]
      @res.status = 401
      @res.body = "Invalid form authenticity token"
    end
  end
end
