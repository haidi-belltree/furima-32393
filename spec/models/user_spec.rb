require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '入力欄が全て正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上の半角英数混合であれば登録できる' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'ニックネームを入力してください'
      end
      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'Eメールを入力してください'
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードを入力してください'
      end
      it 'パスワードが存在してもパスワード(確認用)が空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワード（確認用）とパスワードの入力が一致しません'
      end
      it 'ユーザー本名の苗字が空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'お名前(苗字)を入力してください'
      end
      it 'ユーザー本名の名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'お名前を入力してください'
      end
      it 'ユーザー本名の苗字フリガナが空では登録できない' do
        @user.family_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'お名前カナ(苗字)を入力してください'
      end
      it 'ユーザー本名の名前フリガナが空では登録できない' do
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include 'お名前カナを入力してください'
      end
      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include '誕生日を入力してください'
      end
      it '既にDBに存在するメールアドレスでは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Eメールはすでに存在します'
      end
      it '@を含まないメールアドレスでは登録できない' do
        @user.email.slice!('@')
        @user.email = @user.email
        @user.valid?
        expect(@user.errors.full_messages).to include 'Eメールは不正な値です'
      end
      it 'パスワードが5文字以下では登録できない' do
        @user.password = 'a1a1a'
        @user.password_confirmation = 'a1a1a'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは6文字以上で入力してください'
      end
      it 'パスワードが6文字以上でも半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードには半角を使用し、英字と数字の両方を含めて設定してください'
      end
      it 'パスワードが6文字以上でも半角数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードには半角を使用し、英字と数字の両方を含めて設定してください'
      end
      it 'パスワードが全角では登録できない' do
        @user.password = '１ａ１ａ１ａ'
        @user.password_confirmation = '１ａ１ａ１ａ'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードには半角を使用し、英字と数字の両方を含めて設定してください'
      end
      it 'パスワードとパスワード(確認用)が不一致では登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = 'a1b2c3'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワード（確認用）とパスワードの入力が一致しません'
      end
      it 'ユーザー本名の苗字が半角では登録できない' do
        @user.family_name = 'Jordison'
        @user.valid?
        expect(@user.errors.full_messages).to include 'お名前(苗字)は全角文字を使用してください'
      end
      it 'ユーザー本名の名前が半角では登録できない' do
        @user.first_name = 'Joey'
        @user.valid?
        expect(@user.errors.full_messages).to include 'お名前は全角文字を使用してください'
      end
      it 'ユーザー本名の苗字フリガナが半角では登録できない' do
        @user.family_name_reading = 'ｼﾞｮｰﾃﾞｨｿﾝ'
        @user.valid?
        expect(@user.errors.full_messages).to include 'お名前カナ(苗字)は全角文字を使用してください'
      end
      it 'ユーザー本名の名前フリガナが半角では登録できない' do
        @user.first_name_reading = 'ｼﾞｮｰｲ'
        @user.valid?
        expect(@user.errors.full_messages).to include 'お名前カナは全角文字を使用してください'
      end
    end
  end
end
