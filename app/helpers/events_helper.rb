module EventsHelper
  def event_map_style no_user
    base = "position: absolute; top: -28px; left: 600px; "
    
    unless no_user
      return base + "width: 250px; height: 250px;"
    else
      return base + "width: 300px; height: 300px;"
    end
  
  end
end
