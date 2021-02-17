require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'カラムの値が空では登録できないこと' do
      it 'ニックネームが空では登録できない事' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'メールアドレスが空では登録できない事' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'パスワードが空では登録できない事' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'パスワードが存在してもパスワード(確認用)が空では登録できない事' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'ユーザー本名の苗字が空では登録できない事' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name can't be blank"
      end
      it 'ユーザー本名の名前が空では登録できない事' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it 'ユーザー本名の苗字フリガナが空では登録できない事' do
        @user.family_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name reading can't be blank"
      end
      it 'ユーザー本名の名前フリガナが空では登録できない事' do
        @user.first_name_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name reading can't be blank"
      end
      it '生年月日が空では登録できない事' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
      it '入力欄が全て正しく入力されていれば登録できること' do
        expect(@user).to be_valid
      end
    end

    context 'メールアドレスについて、存在しても登録できない場合があること' do
      it '既にDBに存在するメールアドレスでは登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Email has already been taken"
      end
      it '@を含まないメールアドレスは登録できないこと' do
        @user.email.slice!('@')
        @user.email = @user.email
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end
    end

    context 'パスワードについて、存在しても登録できない場合があること' do
      it 'パスワードが5文字以下では登録できないこと' do
        @user.password = 'a1a1a'
        @user.password_confirmation = 'a1a1a'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end
      it 'パスワードが6文字以上でも半角英字のみでは登録できないこと' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password には半角を使用し、英字と数字の両方を含めて設定してください"
      end
      it 'パスワードが6文字以上でも半角数字のみでは登録できないこと' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password には半角を使用し、英字と数字の両方を含めて設定してください"
      end
      it 'パスワードが全角では登録できないこと' do
        @user.password = '１ａ１ａ１ａ'
        @user.password_confirmation = '１ａ１ａ１ａ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password には半角を使用し、英字と数字の両方を含めて設定してください"
      end
      it 'パスワードとパスワード(確認用)が不一致では登録できないこと' do
        @user.password = 'abc123'
        @user.password_confirmation = 'a1b2c3'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'パスワードが6文字以上の半角英数混合であれば登録できること' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end
    end
    
    context 'ユーザー本名および本名フリガナについて、存在しても登録できない場合があること' do
      it 'ユーザー本名の苗字が半角では登録できないこと' do
        @user.family_name = 'Jordison'
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name ：全角文字を使用してください"
      end
      it 'ユーザー本名の名前が半角では登録できないこと' do
        @user.first_name = 'Joey'
        @user.valid?
        expect(@user.errors.full_messages).to include "First name ：全角文字を使用してください"
      end
      it 'ユーザー本名の苗字フリガナが半角では登録できないこと' do
        @user.family_name_reading = 'ｼﾞｮｰﾃﾞｨｿﾝ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name reading ：全角文字を使用してください"
      end
      it 'ユーザー本名の名前フリガナが半角では登録できないこと' do
        @user.first_name_reading = 'ｼﾞｮｰｲ'
        @user.valid?
        expect(@user.errors.full_messages).to include "First name reading ：全角文字を使用してください"
      end
    end
  end
end
