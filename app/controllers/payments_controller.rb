class PaymentsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    @payment_place = PaymentPlace.new
  end

  def create
    @item = Item.find(params[:item_id])
    @payment_place = PaymentPlace.new(payment_params)
    if @payment_place.valid?
      @payment_place.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  private

  def payment_params
    params.require(:payment_place).permit(:post_code, :prefecture_id, :city, 
                                          :block, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end
end
