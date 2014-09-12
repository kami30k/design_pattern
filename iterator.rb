#
# Iterator パターン
#
# 概要
#
# 要素の集まりを保有するオブジェクトの各要素に順番にアクセスする方法を提供する。
#
# 適用可能性
#
# - 集約オブジェクトの内部構造を公開せずに、その中にあるオブジェクトにアクセス
#   したい場合
# - 集約オブジェクトに対して独自の走査をサポートしたい場合
# - 異なる集約構造のオブジェクトに対して単一のインタフェースを提供したい場合
#
# 構成要素
#
# Iterator:          要素を走査するためのインタフェースを定義する
# Aggregate:         集約オブジェクトを定義する
# ConcreteAggregate: 集約オブジェクト内の個別の要素を定義する
#
# 例
#
# ブログを表現する Blog クラスと、その記事を表現する Article クラスがある。
# Blog は複数の Article を持つが、これを BlogIterator クラスを介して順番にアク
# セスする方法を実装する。

# Aggregate
class Blog
  attr_accessor :articles

  def initialize
    @articles = []
  end

  def add_article(article)
    @articles << article
  end

  def iterator
    BlogIterator.new(self)
  end
end

# ConcreteAggregate
class Article
  attr_accessor :title

  def initialize(title)
    @title = title
  end
end

# Iterator
class BlogIterator
  def initialize(blog)
    @blog = blog
    @index = 0
  end

  def has_next?
    (@blog.articles.size - 1) > @index
  end

  def next_article
    @index += 1
    @blog.articles[@index]
  end
end

blog = Blog.new
blog.add_article(Article.new('test 1'))
blog.add_article(Article.new('test 2'))
blog.add_article(Article.new('test 3'))

iterator = blog.iterator
while iterator.has_next?
  puts iterator.next_article.title
end

# => test2
#    test3
