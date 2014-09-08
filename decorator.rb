#
# Decorator パターン
#
# 概要
#
# 既存のオブジェクトに対して動的に機能を追加するためのパターン。
#
# 適用可能性
#
# - 他のオブジェクトには影響を及ぼさないように機能を追加したい場合
# - サブクラス化による拡張が非現実的な場合
#
# 構成要素
#
# Component:         ラップの対象となるクラス
# ConcreteComponent: 機能を追加できるクラス
# Decorator:         Component への機能を追加するためのラッパ
# ConcreteDecorator: Component へ機能を追加するクラス
#
# 例
#
# HTMLのタグについて考える。
# すべての根源となる Tag クラスがあり、その ConcreteComponent として DivTag クラスがある。
# DivTag への装飾として、 CenterTag/StrongTag を ConcreteDecorator として実装する。

# Component
class Tag
  attr_accessor :name
  attr_accessor :value

  def initialize(name, value)
    @name, @value = name, value

    @tag_list = []
    @tag_list << self
  end

  def append(tag)
    @tag_list << tag
  end

  def output
    text = ''
    @tag_list.reverse_each do |tag|
      tag.value = text if tag.value.empty?
      text = "<#{tag.name}>#{tag.value}</#{tag.name}>"
    end
    text
  end
end

# ConcreteComponent
class DivTag < Tag
  def initialize(value)
    super('div', value)
  end
end

# Decorator
class DecorateTag < Tag
  def initialize(name, value)
    super(name, value)
  end
end

# ConcreteDecorator
class CenterTag < DecorateTag
  def initialize(value)
    super('center', value)
  end
end

# ConcreteDecorator
class StrongTag < DecorateTag
  def initialize(value)
    super('strong', value)
  end
end

div = DivTag.new('')
div.append(CenterTag.new(''))
div.append(StrongTag.new('foo'))
p div.output # => <div><center><strong>foo</strong></center></div>

center = CenterTag.new('')
center.append(StrongTag.new('bar'))
p center.output # => <center><strong>bar</strong></center>
