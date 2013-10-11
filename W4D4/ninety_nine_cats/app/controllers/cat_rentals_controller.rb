class CatRentalsController < ApplicationController
  def new
    @cat_rental = CatRental.new
    @cats = Cat.all
  end

  def create
    @cat_rental = CatRental.new(params[:cat_rental])
    if @cat_rental.save
      redirect_to cat_url(@cat_rental.cat_id)
    else
      @cats = Cat.all
      p @cats
      render :new
    end
  end

  def update
    @cat_rental = CatRental.find(params[:id])
    if params[:status] == "approve"
      @cat_rental.approve!
    else
      @cat_renal.deny!
    end
    redirect_to cat_url(@cat_rental.cat_id)
  end
end