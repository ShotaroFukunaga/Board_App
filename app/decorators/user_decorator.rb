class UserDecorator < Draper::Decorator
  delegate_all
 #delegate_allはusermodelの全部のメソッドを呼び出せるための記述
 #モデルの既存のメソッドなんかを組み合わせたりするのに便利
  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
#objectメソッドはデコレートしているモデルを参照するメソッド、エイリアスがmodelなんで#{model.last_name}とも書ける
#modelのインスタンス変数が保持している情報が使われているのでselfと同じ感じ