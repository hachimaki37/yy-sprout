class ScheduleResult < ApplicationRecord
  enum section: { 第1節: 0,  第2節: 1, 第3節: 2 , 第4節: 3, 第5節: 4, 第6節: 5, 第7節: 6, 第8節: 7, 第9節: 8, 第10節: 9, 第11節: 10, 第12節: 11, 第13節: 12, 第14節: 13, 第15節: 14, 第16節: 15, 第17節: 16, 第18節: 17, 第19節: 18, 第20節: 19, その他: 20 },_prefix: true
  enum opponent: { リューレント: 0,  サザンクロス: 1, ドラックス: 2 , トライアンフ: 3, ビーバー: 4 }
  enum match_result: { 勝ち: 1,  負け: 2, 引分け: 3 }
  enum stadium: { 古々崎第1G: 0,  古々崎第2G: 1, 運動公園: 2, その他: 3 },_prefix: true
  enum home_and_away: { ホーム: 0,  アウェー: 1 }
end
