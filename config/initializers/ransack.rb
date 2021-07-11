
Ransack.configure do |config|
    config.add_predicate 'lteq_end_of_day',#ここでpredicateの名前を決める
                        arel_predicate: 'lteq',#predicateを置き換える？仕様変更？
                        formatter: proc { |v| v.end_of_day}#railsのend_of_dayメソッドで日付設定にする
end