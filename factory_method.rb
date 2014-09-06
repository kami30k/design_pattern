#
# FactoryMethod パターン
#
# インスタンスの生成をサブクラスに委譲することで、クラスの再利用性を高める。
#
# それぞれの役割
#
# Creator:         ConcreteCreator の共通処理を行なう
# ConcreteCreator: Product オブジェクトの生成を行なう
# Product:         Product 個別の処理を実装する

# Creator
class TableFactory
  def initialize
    @table = build
  end

  def ship
    @table
  end
end

# ConcreteCreator
class WoodTableFactory < TableFactory
  def build
    WoodTable.new
  end
end

# ConcreteCreator
class GlassTableFactory < TableFactory
  def build
    GlassTable.new
  end
end

# Product
class WoodTable
  attr_accessor :material

  def initialize
    @material = '木'
  end
end

# Product
class GlassTable
  attr_accessor :material

  def initialize
    @material = 'ガラス'
  end
end

factory = WoodTableFactory.new
table = factory.ship
p table.material

factory = GlassTableFactory.new
table = factory.ship
p table.material
