class CatRentalsController < ApplicationController
  before_filter :logged_in?
  before_filter :logged_in_as_owner?, :only => [:approve, :deny]

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

  private

    def logged_in_as_owner?
      @cat_rental = CatRental.find(params[:cat_rental_id])
      @cat = @cat_rental.cat
      unless current_user.id == @cat.owner_id
        redirect_to root_url
      end
    end
end