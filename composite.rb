#
# Composite パターン
#
# 概要
#
# 再帰的な構造を表現するパターン。
#
# 適用可能性
#
# - オブジェクトを合成したものと、個々のオブジェクトを一様に扱いたい場合
# - オブジェクトの階層構造を表現したい場合
#
# 構成要素
#
# Component: すべてのクラスに共通なインタフェースを定義する
# Composite: 子オブジェクトを持つ Component を定義する
# Lief:      末端オブジェクトを定義する
#
# 例
#
# ファイルシステムを例に考える。
# Directory クラスは Directory または File を持ち得る（Composite）。
# File クラスは末端のオブジェクトである（Lief）。
# Directory と File に共通するインタフェースを Entry クラスとして実装する。

# Component
class Entry
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def current_path(parent_path)
    parent_path + '/' + @name
  end
end

# Composite
class DirectoryEntry < Entry
  def initialize(name)
    super
    @entry_list = []
  end

  def add(entry)
    @entry_list << entry
  end

  def ls_entry(parent_path = '')
    p current_path(parent_path)

    @entry_list.each do |entry|
      entry.ls_entry(current_path(parent_path))
    end
  end
end

# Lief
class FileEntry < Entry
  def ls_entry(parent_path)
    p current_path(parent_path)
  end
end

tmp = DirectoryEntry.new('tmp')
tmp.add(FileEntry.new('test_1.txt'))
tmp.add(FileEntry.new('test_2.txt'))
tmp.add(FileEntry.new('test_3.txt'))

root = DirectoryEntry.new('root')
root.add(tmp)

root.ls_entry

# => "/root"
#    "/root/tmp"
#    "/root/tmp/test_1.txt"
#    "/root/tmp/test_2.txt"
#    "/root/tmp/test_3.txt"
