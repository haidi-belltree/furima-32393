require 'rails_helper'

RSpec.describe PaymentPlace, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @payment_place = FactoryBot.build(:payment_place, user_id: @user.id, item_id: @item.id, item_price: @item.price)
  end

  describe '購入情報が保存できる時' do
    it '全ての値が正しく入力されていれば保存できる' do
      expect(@payment_place).to be_valid
    end
    it '建物名はなくても保存できる' do
      @payment_place.building = ''
      expect(@payment_place).to be_valid
    end
    it 'tokenがあれば保存できる' do
      expect(@payment_place).to be_valid
    end
  end

  describe '購入情報が保存できない時' do
    it '郵便番号が空では保存できない' do
      @payment_place.post_code = ''
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('郵便番号を入力してください')
    end
    it '都道府県が選択されていなければ保存できない' do
      @payment_place.prefecture_id = 1
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('都道府県を選択してください')
    end
    it '市町村が空では保存できない' do
      @payment_place.city = ''
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('市区町村を入力してください')
    end
    it '番地が空では保存できない' do
      @payment_place.block = ''
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('番地を入力してください')
    end
    it '電話番号が空では保存できない' do
      @payment_place.phone_number = ''
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('電話番号を入力してください')
    end
    it 'user_idがなければ保存できない' do
      @payment_place.user_id = ''
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('Userを入力してください')
    end
    it 'item_idがなければ保存できない' do
      @payment_place.item_id = ''
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('Itemを入力してください')
    end
    it 'item_priceがなければ保存できない' do
      @payment_place.item_price = ''
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('Item priceを入力してください')
    end
    it '郵便番号は半角数字でなければ保存できない' do
      @payment_place.post_code = '１２３-４５６７'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('郵便番号はハイフンを含む半角数字7桁で入力してください')
    end
    it '郵便番号はハイフンを含まなければ保存できない' do
      @payment_place.post_code = '1234567'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('郵便番号はハイフンを含む半角数字7桁で入力してください')
    end
    it '郵便番号は3桁＋4桁でなければ保存できない' do
      @payment_place.post_code = '1234-567'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('郵便番号はハイフンを含む半角数字7桁で入力してください')
    end
    it '市町村は全角でなければ保存できない' do
      @payment_place.city = 'ﾖｺﾊﾏｼﾐﾄﾞﾘｸ'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('市区町村は全角日本語で記入してください')
    end
    it '市町村は全角でも、日本語でなければ保存できない' do
      @payment_place.city = 'Ｍｉｄｏｒｉ－Ｗａｒｄ　Ｙｏｋｏｈａｍａ－Ｃｉｔｙ'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('市区町村は全角日本語で記入してください')
    end
    it '番地は全角日本語および半角数字以外では保存できない' do
      @payment_place.block = 'ΘψΔη１ー１ー１'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('番地は全角日本語および半角数字で記入してください')
    end
    it '電話番号は10桁または11桁でなければ保存できない' do
      @payment_place.phone_number = '090112233445566778899'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('電話番号は半角数字10〜11桁（ハイフンなし）で記入してください')
    end
    it '電話番号は10桁または11桁でも半角数字でなければ保存できない' do
      @payment_place.phone_number = '０９０１２３４５６７８'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('電話番号は半角数字10〜11桁（ハイフンなし）で記入してください')
    end
    it 'tokenが空では保存できない' do
      @payment_place.token = nil
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include('クレジットカード情報を入力してください')
    end
  end
end
