require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '商品が出品できる時' do
      it '必要な情報を適切に入力すれば商品の出品ができる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができない時' do
      it '商品画像が1枚添付されていないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では出品できない' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end
      it '商品の説明が空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーが選択されていなければ出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it '商品の状態が選択されていなければ出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 1")
      end
      it '配送料の負担についての情報が選択されていなければ出品できない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage must be other than 1")
      end
      it '発送元の地域が選択されていなければ出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it '発送までの日数が選択されていなければ出品できない' do
        @item.shipment_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipment day must be other than 1")
      end
      it '価格が空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price は半角数字を使用し、300から9,999,999の間で入力してください")
      end
      it '価格が¥300より小さければ出品できない' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は半角数字を使用し、300から9,999,999の間で入力してください")
      end
      it '価格が¥9,999,999より大きければ出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は半角数字を使用し、300から9,999,999の間で入力してください")
      end
      it '価格が全角では出品できない' do
        @item.price = '５０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は半角数字を使用し、300から9,999,999の間で入力してください")
      end
      it '価格が英字では出品できない' do
        @item.price = 'aaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は半角数字を使用し、300から9,999,999の間で入力してください")
      end
      it '価格が半角英数混合では出品できない' do
        @item.price = '1m2N3b4V'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は半角数字を使用し、300から9,999,999の間で入力してください")
      end
    end
  end
end
