module EventsHelper
  def event_map_style no_user
    base = "position: absolute; top: -28px; left: 600px; "
    
    unless no_user
      # return base + "width: 250px; height: 250px;"
       return base + "width: 300px; height: 300px;"
    else
      return base + "width: 300px; height: 300px;"
    end
  
  end
  
  def dim_for pic, opt
    Paperclip::Geometry.from_file( pic.path(opt) )
  end

  def image_modal(pic)
    out=<<EOS
      <a data-toggle="modal" href="#ThumbnailModal#{pic.name.to_s}" >
        <img class="thumbnail" src="#{pic.url(:thumb)}" alt="" title="" />
        </a>

        <div class="modal fade" id="ThumbnailModal#{pic.name.to_s}" style="display:none;padding:5px 5px 5px 5px; width: #{dim_for(pic, :big).width}px; height: #{dim_for(pic, :big).height}px;">
            <img src="#{pic.url(:big)}" width=#{dim_for(pic, :big).width} height=#{dim_for(pic, :big).height} alt="" title="" />
            </div>
EOS
   out.html_safe 
  end
end
