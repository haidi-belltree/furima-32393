class PaymentsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    @payment_place = PaymentPlace.new
  end

  def create
  end
end
