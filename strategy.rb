#
# Strategy パターン
#
# 概要
#
# 各アルゴリズムをカプセル化し、これを実行時に選択可能にする。
#
# 適用可能性
#
# - 関連する多くのクラスが振る舞いのみ異なっている場合
#
# 構成要素
#
# Strategy:         すべてのアルゴリズムに共通のインタフェースを定義する
# ConcreteStrategy: 具体的なアルゴリズムを定義する
# Context:          Strategy の利用者
#
# 例
#
# Report クラスがあり、またこれを PlainText/HTML で出力する Formatter クラスが
# ある場合を考える。

class Formatter
  def display(report)
  end
end

class PlainTextFormatter < Formatter
  def display(report)
    report.text.each { |t| puts t }
  end
end

class HTMLFormatter < Formatter
  def display(report)
    html = '<html><head></head><body>'
    report.text.each { |t| html << "<p>#{t}</p>" }
    html << '</body></html>'

    puts html
  end
end

class Report
  attr_accessor :text, :formatter

  def initialize(text)
    @text = text
  end

  def display
    @formatter.display(self)
  end
end

report = Report.new(%w[foo bar baz])
report.formatter = PlainTextFormatter.new
report.display

report.formatter = HTMLFormatter.new
report.display
