#
# Command パターン
#
# 概要
#
# 要求をオブジェクトとしてカプセル化することにより、様々な要求からなるキューとして処理できる。
# また、取り消し可能なオペレーションをサポートする。
#
# 適用可能性
#
# - 要求を明確にし、順番に並べ、それぞれ別に実行したい場合。
# - 要求の取り消しをサポートしたい場合。
#
# 構成要素
#
# Command:         命令を実行するためのインタフェースを定義する
# ConcreteCommand: 命令を定義する
#
# 例
#
# ファイルの作成/コピー/削除を行なうコマンドを実装する。
# 共通のインタフェースを Command クラスとして実装し、これを継承して各コマンドを実装する。
# また、コマンドをまとめる CompositeCommand クラスも実装する。

require 'fileutils'

# Command
class Command
  def execute
  end

  def undo
  end
end

# ConcreteCommand
class CreateFile < Command
  def initialize(file, text)
    @file, @text = file, text
  end

  def execute
    f = File.open(@file, 'w')
    f.write(@text)
    f.close
  end

  def undo
    File.delete(@file)
  end
end

# ConcreteCommand
class CopyFile < Command
  def initialize(file_source, file_target)
    @file_source, @file_target = file_source, file_target
  end

  def execute
    FileUtils.copy(@file_source, @file_target)
  end

  def undo
    File.delete(@file_target)
  end
end

# ConcreteCommand
class DeleteFile < Command
  def initialize(file)
    @file = file
  end

  def execute
    @text = File.read(@file) if File.exists?(@file)

    File.delete(@file)
  end

  def undo
    f = File.open(@file, 'w')
    f.write(@text)
    f.close
  end
end

# ConcreteCommand
class CompositeCommand < Command
  def initialize
    @commands = []
  end

  def execute
    @commands.each { |command| command.execute }
  end

  def undo
    @commands.last.undo
    @commands.pop
  end

  def add_command(command)
    @commands << command
  end
end

# Client
commands = CompositeCommand.new

commands.add_command(CreateFile.new('file_1.txt', 'Hello World!'))
commands.add_command(CopyFile.new('file_1.txt', 'file_2.txt'))
commands.add_command(DeleteFile.new('file_1.txt'))

commands.execute # => file_2.txt が作成される

commands.undo # => file_1.txt が復元される
commands.undo # => file_2.txt が削除される
commands.undo # => file_1.txt が削除される
