class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :unless_current_user

  def show
    @item = Item.all.order('created_at DESC')
    @payments = Payment.all
    card = @user.card
    unless card == nil
      card_info
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      render action: :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :encrypted_password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def unless_current_user
    redirect_to root_path unless current_user.id == @user.id
  end

  def card_info
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: @user.id)
    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
  end
end
