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

  def approve
    @cat_rental = CatRental.find(params[:cat_rental_id])
    @cat_rental.approve!
    redirect_to cat_url(@cat_rental.cat_id)
  end

  def deny
    @cat_rental = CatRental.find(params[:cat_rental_id])
    @cat_rental.deny!
    redirect_to cat_url(@cat_rental.cat_id)
  end
end