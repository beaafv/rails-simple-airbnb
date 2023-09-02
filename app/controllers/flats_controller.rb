class FlatsController < ApplicationController

  def index
    @flats = Flat.all

    if params[:query].present?
      @flats = @flats.where("name LIKE ? COLLATE NOCASE", "%#{params[:query]}%")
    end



  end
   def new
    @flat = Flat.new
  end

  def show
    @flat = Flat.find_by(params[:id])
  end



  def create
    @flat = Flat.new(flat_params)

    if @flat.save
      redirect_to flats_path, notice: "Flat was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @flat = Flat.find(params[:id])
    @flat.destroy

    redirect_to flats_path, notice: 'Flat was successfully deleted.'
  end

  private
  def flat_params
    params.require(:flat).permit(:name, :address, :description, :price_per_night, :number_of_guests, :image)
  end
end
