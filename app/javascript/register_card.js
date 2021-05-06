const register = () => {  //定数registerを定義 //アロー関数
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); //環境変数を読み込む
  const form = document.getElementById("register_card-form"); //イベント発火させる要素を取得し、定数として定義
  form.addEventListener("submit", (e) => {  //上記で定義したform要素に対してイベントを発火させる
    e.preventDefault();  //Railsのフォーム送信処理をキャンセル

    //カード情報の取得
    const formResult = document.getElementById("register_card-form");
    const formData = new FormData(formResult);  //上記フォームに入力された値を取得し、定数として定義

    const registerCard = {  //registerCardオブジェクトを定義
      number: formData.get("card[number]"),
      cvc: formData.get("card[cvc]"),
      exp_month: formData.get("card[exp_month]"),
      exp_year: `20${formData.get("card[exp_year]")}`,
    };

    //registerCardオブジェクトをPAY.JPに送信
    Payjp.createToken(registerCard, (status, response) => {  //createTokenはPayjpオブジェクトのメソッド
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("register_card-form");
        const tokenObj = `<input value=${token} name='card_token' type="hidden">`;  //paramsの中にtokenを含める
        renderDom.insertAdjacentHTML("beforeend", tokenObj);  //フォームの一番最後に要素を追加
      }
      
      //カード情報がparamsに含まれないようにする
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      
      //トークンをコントローラーに送信
      document.getElementById("register_card-form").submit();
    });
  });
};

window.addEventListener("load", register); //上記で定義した定数registerを起動