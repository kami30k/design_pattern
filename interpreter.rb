#
# Interpreter パターン
#
# 概要
#
# 構文木で表現される処理に対して、ドメイン固有言語を実装することにより解決する。
#
# 適用可能性
#
# - 構文木で表現される処理を実装する場合
#
# 構成要素
#
# AbstractExpression:    すべてのノードに共通の、抽象化されたオペレーションを定義する
# NonterminalExpression: 文法中の非終端記号を定義する
# TerminalExpression:    文法中の終端記号を定義する
#
# 例
#
# ファイル探索について考える。
# ファイル名にマッチする FileName クラスと、パーミッションをチェックする FilePermission クラス
# を実装する。
# また、これら2つを AND 検索する And クラスを実装し、クライアントから AND 検索を行なう。

require 'find'

# AbstractExpression
class Expression
  def initialize
  end

  def evaluate
  end
end

# NonterminalExpression
class And < Expression
  def initialize(expression_1, expression_2)
    @expression_1, @expression_2 = expression_1, expression_2
  end

  def evaluate(directory)
    result_1 = @expression_1.evaluate(directory)
    result_2 = @expression_2.evaluate(directory)
    result_1 & result_2
  end
end

# TerminalExpression
class FileName < Expression
  def initialize(expression)
    @expression = expression
  end

  def evaluate(directory)
    files = []
    Find.find(directory).each do |f|
      next unless File.file?(f)
      basename = File.basename(f)
      files << f if File.fnmatch(@expression, basename)
    end
    files
  end
end

# TerminalExpression
class FilePermission < Expression
  def initialize(expression)
    @expression = expression
  end

  def evaluate(directory)
    files = []
    Find.find(directory).each do |f|
      next unless File.file?(f)
      files << f if case @expression
                    when 'w'
                      File.writable?(f)
                    when 'r'
                      File.readable?(f)
                    when 'x'
                      File.executable?(f)
                    end
    end
    files
  end
end

# Client
expression = And.new(FileName.new('*.rb'), FilePermission.new('w'))

p expression.evaluate('.') # => 書き込み可能な *.rb ファイルの一覧が出力される
