#
# Observer パターン
#
# 概要
#
# あるオブジェクトの状態を変更させたとき、それに依存するオブジェクトにそれを通知
# し、それに応じた処理を実装する。
#
# 適用可能性
#
# - オブジェクトを変更した際、それに応じて他のオブジェクトも変更させる場合
# - オブジェクトとその観察者を別々にすることで再利用性を高めたい場合
#
# 構成要素
#
# Subject:          変化するオブジェクトを定義する
# Observer:         Subject の更新通知を受け取る更新インタフェースを定義する
# ConcreteObserver: 状態変化の通知を受け、具体的な処理を行なう
#
# 例
#
# 従業員の給与が変更された場合、その変化を受け取って給与の小切手（Payroll）と
# 税金の請求書（Taxman）が発行される。
# Observer については、 Ruby が提供する Observable モジュールを利用する。

require 'observer'

# Subject
class Employee
  include Observable

  attr_accessor :name, :salary
  
  def initialize(name)
    @name = name

    add_observer(Payroll.new)
    add_observer(Taxman.new)
  end

  def salary=(salary)
    @salary = salary
    changed
    notify_observers(self)
  end
end

# ConcreteObserver
class Payroll
  def update(changed_employee)
    puts "#{changed_employee.name} さんに #{changed_employee.salary} 円の小切手を発行します"
  end
end

# ConcreteObserver
class Taxman
  def update(changed_employee)
    puts "#{changed_employee.name} さんに新しい請求書を発行します"
  end
end

taro = Employee.new('Taro')
taro.salary = 5_000
# => Taro さんに 5000 円の小切手を発行します
#    Taro さんに新しい請求書を発行します

taro.salary = 10_000
# => Taro さんに 10000 円の小切手を発行します
#    Taro さんに新しい請求書を発行します
