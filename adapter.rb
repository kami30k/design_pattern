#
# Adapter パターン
#
# 概要
#
# - 互換性のない2つのクラスをつなぎ合わせるためのパターン。
#
# 適用可能性
#
# - 既存のクラスを利用したいが、そのインタフェースが必要なインタフェースと一致していない場合
#
# 構成要素
#
# Client:  ターゲットを利用するオブジェクト
# Target:  インタフェースを定義するクラス
# Adapter: Adaptee クラスのインタフェースを Target のインタフェースに変換する
# Adaptee: 変換する必要のある、既存のインタフェースをもつクラス
#
# 例
#
# 古いクラス OldPrinter には、 add_bracket_to_string がある。
# このメソッドを、新しいクラス NewPrinter から with_bracket という名前で呼び出せるような
# インタフェース互換を実装する PrinterAdapter クラスを実装する。

# Target
class NewPrinter
  def initialize(object)
    @object = object
  end

  def with_bracket
    @object.with_bracket
  end
end

# Adaptee
class OldPrinter
  def initialize(string)
    @string = string
  end

  def add_bracket_to_string
    "[#{@string}]"
  end
end

# Adapter
class PrinterAdapter
  def initialize(string)
    @old_printer = OldPrinter.new(string)
  end

  def with_bracket
    @old_printer.add_bracket_to_string
  end
end

# Client
printer = NewPrinter.new(PrinterAdapter.new('foo'))
p printer.with_bracket
