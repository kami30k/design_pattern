#
# Proxy パターン
#
# 概要
#
# 共通のインタフェースを持つインスタンスを内包し、 Client からのアクセスを代理する。
#
# 適用可能性
#
# - オブジェクトの本質的な目的とは異なる処理を切り離して実装したい場合（セキュリティ要件等）
#
# 構成要素
#
# Subject:     RealSubject と Proxy の共通のインタフェースを定義する
# RealSubject: Proxy が代理処理する実オブジェクトを定義する
# Proxy:       RealSubject の本質以外の特定の処理を定義する
#
# 例
#
# Professor と AssistantTeacher という2つの Teacher が存在する。
# Professor は忙しいため、生徒からの簡単な質問は AssistantTeacher に委譲する。
# AssistantTeacher は、難しい質問には答えられないため、難しい質問が来た場合のみ Professor に
# 回答を委譲する。

# Subject
class Teacher
  def ask(level)
    case level
    when :easy
      '答えは A です'
    when :difficult
      '分かりません'
    end
  end
end

# RealSubject
class Professor < Teacher
  def ask(level)
    case level
    when :easy
      super
    when :difficult
      '答えは B です'
    end
  end
end

# Proxy
class AssistantTeacher < Teacher
  def ask(level)
    case level
    when :easy
      super
    when :difficult
      Professor.new.ask(:difficult)
    end
  end
end

# Client
teacher = AssistantTeacher.new
p teacher.ask(:easy)
p teacher.ask(:difficult)
