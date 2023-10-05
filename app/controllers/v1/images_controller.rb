class ImagesController < ApplicationController
  def create
    @image = @current_user.images.new(image_params)
    if @image.save
      render json: @image, status: :created, location: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  def image_params
    params.require(:image).permit(:file)
  end
end