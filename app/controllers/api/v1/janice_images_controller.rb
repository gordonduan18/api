class Api::V1::JaniceImagesController < ApplicationController
  before_action :set_janice_image, only: %i[ show update destroy ]

  # GET /janice_images
  def index
    @janice_images = JaniceImage.all

    render json: @janice_images
  end

  # GET /janice_images/1
  def show
    render json: @janice_image
  end

  # POST /janice_images
  def create
    @janice_image = JaniceImage.new(janice_image_params)

    if @janice_image.save
      render json: @janice_image, status: :created, location: @janice_image
    else
      render json: @janice_image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /janice_images/1
  def update
    if @janice_image.update(janice_image_params)
      render json: @janice_image
    else
      render json: @janice_image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /janice_images/1
  def destroy
    @janice_image.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_janice_image
      @janice_image = JaniceImage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def janice_image_params
      params.require(:janice_image).permit(:url, :date)
    end
end
