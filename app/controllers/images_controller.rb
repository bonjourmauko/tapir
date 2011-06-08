class ImagesController < ApplicationController
  respond_to :html
  
  def new
    @image = Image.new
    @transloadit_params = {
      "auth"          =>{ "key" => TRANSLOADIT[:auth_key] },
      "template_id"   => TRANSLOADIT[:cover_template_id],
      "redirect_url"  => images_url
    }
  end
  
  def create
    @image = Image.new(params[:image])
    image = ActiveSupport::JSON.decode(params[:transloadit]).symbolize_keys[:uploads].first.symbolize_keys
    image[:ext] = image[:ext].dup.gsub(/[e]/i, '').downcase

    @image.update_attributes(
      :cover_file_name        => image[:name], # esta wea vale callampa en todo caso
      :cover_content_type     => image[:mime],
      :cover_file_size        => image[:size],
      :cover_file_extension   => image[:ext],
      :cover_original_id      => image[:original_id],
      :width                  => image[:meta]["width"],
      :height                 => image[:meta]["height"]
    )

    if @image.save
      redirect_to @image
    else
      render new_image_path
    end
  end
  
end
