require 'rails_helper'

RSpec.describe PaymentPlace, type: :model do
  before do
    @payment_place = FactoryBot.build(:payment_place)
  end

  describe '購入情報が保存できる時' do
    it '全ての値が正しく入力されていれば保存できる' do
      expect(@payment_place).to be_valid
    end
    it '建物名はなくても保存できる' do
      @payment_place.building = ''
      expect(@payment_place).to be_valid
    end
  end

  describe '購入情報が保存できない時' do
    it '郵便番号が空では保存できない' do
      @payment_place.post_code = ''
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include("Post code can't be blank", "Post code はハイフンを含む半角数字7桁で入力してください")
    end
    it '都道府県が選択されていなければ保存できない' do
      @payment_place.prefecture_id = 1
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include("Prefecture を選択してください")
    end
    it '市町村が空では保存できない' do
      @payment_place.city = ''
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include("City can't be blank", "City は全角で記入してください")
    end
    it '番地が空では保存できない' do
      @payment_place.block = ''
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include("Block can't be blank", "Block は全角日本語および半角数字で記入してください")
    end
    it '電話番号が空では保存できない' do
      @payment_place.phone_number = ''
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include("Phone number can't be blank", "Phone number は半角数字10〜11桁（ハイフンなし）で記入してください")
    end
    it '郵便番号は半角数字でなければ保存できない' do
      @payment_place.post_code = '１２３-４５６７'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include("Post code はハイフンを含む半角数字7桁で入力してください")
    end
    it '郵便番号はハイフンを含まなければ保存できない' do
      @payment_place.post_code = '1234567'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include("Post code はハイフンを含む半角数字7桁で入力してください")
    end
    it '郵便番号は3桁＋4桁でなければ保存できない' do
      @payment_place.post_code = '1234-567'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include("Post code はハイフンを含む半角数字7桁で入力してください")
    end
    it '市町村は全角でなければ保存できない' do
      @payment_place.city = 'ﾖｺﾊﾏｼﾐﾄﾞﾘｸ'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include("City は全角で記入してください")
    end
    it '市町村は全角でも、日本語でなければ保存できない' do
      @payment_place.city = 'Ｍｉｄｏｒｉ－Ｗａｒｄ　Ｙｏｋｏｈａｍａ－Ｃｉｔｙ'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include("City は全角で記入してください")
    end
    it '番地は全角日本語および半角数字以外では保存できない' do
      @payment_place.block = 'ΘψΔη１ー１ー１'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include("Block は全角日本語および半角数字で記入してください")
    end
    it '電話番号は10桁または11桁でなければ保存できない' do
      @payment_place.phone_number = '090112233445566778899'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include("Phone number は半角数字10〜11桁（ハイフンなし）で記入してください")
    end
    it '電話番号は10桁または11桁でも半角数字でなければ保存できない' do
      @payment_place.phone_number = '０９０１２３４５６７８'
      @payment_place.valid?
      expect(@payment_place.errors.full_messages).to include("Phone number は半角数字10〜11桁（ハイフンなし）で記入してください")
    end
  end

end
