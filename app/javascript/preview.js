if (document.URL.match( /new/ ) || document.URL.match( /edit/ )){
  document.addEventListener('DOMContentLoaded', function(){
    const ImageList = document.getElementById('image-list');

    // 選択した画像を表示する関数
    const createImageHTML = (blob) => {
      const imageElement = document.createElement('div'); //画像を表示するdiv要素を生成
      imageElement.setAttribute('class', "image-element")
      let imageElementNum = document.querySelectorAll('.image-element').length

      const blobImage = document.createElement('img'); //表示する画像を生成(img要素)
      blobImage.setAttribute('src', blob); //上記img要素に、画像のURLを指定するsrc属性を付加
      blobImage.setAttribute('class', "image-list"); //上記img要素に、cssを適用するためのclass属性を付加
      
      const inputHTML = document.createElement('input'); //2枚目以降用のファイル添付ボタン(input要素)生成
      inputHTML.setAttribute('id', `item_image_${imageElementNum}`); //input要素にid付加
      inputHTML.setAttribute('name', 'item[images][]');//input要素のname属性付加
      inputHTML.setAttribute('type', 'file'); //input要素のtype属性付加
      inputHTML.setAttribute('class', "file-upload-button"); //input要素にcssを適用するためのclass属性を付加

      imageElement.appendChild(blobImage); //画像を表示するdiv要素に、img要素を子要素として設定
      imageElement.appendChild(inputHTML); //画像を表示するdiv要素に、追加のファイル添付ボタン(input要素)を子要素として設定
      ImageList.appendChild(imageElement); //HTML上の画像を表示するdiv要素に、javascript上で生成したdiv要素を子要素として設定

      // イベント発火＝2枚目以降の画像を表示させる
      inputHTML.addEventListener('change', (e) => {
        file = e.target.files[0];
        blob = window.URL.createObjectURL(file);

        createImageHTML(blob)
      })
    };

    document.getElementById('item-image').addEventListener('change', function(e){
      const file = e.target.files[0]; //取得した画像の情報
      const blob = window.URL.createObjectURL(file); //上記画像のURLを生成

      createImageHTML(blob);
    });
  });
}