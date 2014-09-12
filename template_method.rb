#
# Template Method パターン
#
# 概要
#
# 1つのクラスに処理のテンプレートを定義しておき、その中のいくつかのステップにつ
# いては、サブクラスでの定義に任せる。
#
# 適用可能性
#
# - サブクラス間での共通の処理を抜き出して別のクラスに局所化する場合
#
# 構成要素
#
# AbstractClass: サブクラス間で共通の抽象化された処理を定義する
# ConcreteClass: 実際の処理を定義する
#
# 例
#
# レポートを HTML/PlainText の2つの形式で出力する。
# 出力に関する共通の処理を Report クラスで定義し、それぞれの処理をサブクラスに
# 定義する。

class Report
  def initialize(text)
    @text = text
  end

  def display
    display_start
    display_text
    display_end
  end

  def display_start
  end

  def display_text
    @text.each { |t| display_line(t) }
  end

  def display_end
  end
end

class HTMLReport < Report
  def display_start
    puts '<html><head></head><body><h1>HTML Report</h1>'
  end

  def display_line(t)
    puts "<p>#{t}</p>"
  end

  def display_end
    puts '</body></html>'
  end
end

class PlainTextReport < Report
  def display_start
    puts '*** PlainText Report ***'
  end

  def display_line(text)
    puts text
  end
end

text = %w[foo bar baz]

html_report = HTMLReport.new(text)
html_report.display

plaintext_report = PlainTextReport.new(text)
plaintext_report.display
