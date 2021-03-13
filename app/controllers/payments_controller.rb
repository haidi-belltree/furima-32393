class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :if_current_user
  before_action :sold_out

  def new
    @payment_place = PaymentPlace.new
  end

  def create
    @payment_place = PaymentPlace.new(payment_params)
    if @payment_place.valid?
      pay_order
      @payment_place.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  private

  def payment_params
    params.require(:payment_place).permit(:post_code, :prefecture_id, :city, :block, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, item_price: @item.price, token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def if_current_user
    redirect_to root_path if current_user.id == @item.user.id
  end

  def sold_out
    @payments = @item.payment
    redirect_to root_path unless @payments.nil?
  end

  def pay_order
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: payment_params[:item_price],
      card: payment_params[:token],
      currency: 'jpy'
    )
  end
end
