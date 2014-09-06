#
# Singleton パターン
#
# 概要
#
# あるクラスに対してインスタンスが1つしかないことを保証し、それにアクセスするためのグローバルな方法を
# 提供する。
#
# 適用可能性
#
# - クラスに対してインスタンスが1つしか存在してはならない場合
#
# 構成要素
#
# Singleton: Singleton クラス
#
# 例

require 'singleton'

# Singleton
class Counter
  include Singleton

  attr_reader :count

  def initialize
    @count = 0
  end

  def count_up
    @count += 1
  end
end

counter_1 = Counter.instance
counter_1.count_up
p counter_1.count # => 1

counter_2 = Counter.instance
counter_2.count_up
p counter_2.count # => 2
