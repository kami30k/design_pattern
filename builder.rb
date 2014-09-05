#
# Builder パターン
#
# 同じ生成過程で異なる結果を得るためのパターン。
#
# 生成過程を Director クラス、各プロセスを Builder/ConcreteBuilder クラスにより実装すること
# で、柔軟な実装を実現する。
#
# ここでは2つの水溶液（Solution）である食塩水（SalineWater）と砂糖水（SugaredWater）を、同じ
# 過程により生成する。

# Director
class SolutionDirector
  def initialize(builder)
    @builder = builder
  end

  def make
    @builder.add_water(50)
    @builder.add_material(10)
    @builder.add_water(100)
    @builder.add_material(5)
  end
end

# Builder
class SolutionBuilder
  # 出力確認用
  attr_reader :solution

  def initialize(klass)
    @solution = klass.new(0, 0)
  end

  def add_water(amount)
    @solution.add_water(amount)
  end

  def add_material(amount)
    @solution.add_material(amount)
  end
end

# ConcreteBuilder
class SalineWater
  attr_accessor :water
  attr_accessor :salt

  def initialize(water, salt)
    self.water = water
    self.salt  = salt
  end

  def add_water(amount)
    self.water += amount
  end

  def add_material(amount)
    self.salt += amount
  end
end

# ConcreteBuilder
class SugaredWater
  attr_accessor :water
  attr_accessor :sugar

  def initialize(water, sugar)
    self.water = water
    self.sugar = sugar
  end

  def add_water(amount)
    self.water += amount
  end

  def add_material(amount)
    self.sugar += amount
  end
end

# 食塩水の生成

builder = SolutionBuilder.new(SalineWater)
director = SolutionDirector.new(builder)
director.make

p builder.solution # => #<SalineWater:0x007ff071895558 @water=150, @salt=15>

# 砂糖水の生成

builder = SolutionBuilder.new(SugaredWater)
director = SolutionDirector.new(builder)
director.make

p builder.solution # => #<SugaredWater:0x007ff071895378 @water=150, @sugar=15>
