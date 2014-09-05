#
# AbstractFactory パターン
#
# インスタンスが複数のオブジェクトにより構成される際、その効率性・厳密性を向上させるためのパターン。
# AbstractFactory を直接生成するのではなく、 ConcreteFactory 経由で生成する。

# AbstractFactory
class Vehicle
  attr_accessor :engine
  attr_accessor :tire

  def status
    "#{engine.name} と #{tire.name}"
  end
end

# ConcreteFactory
class Car < Vehicle
  def engine
    CarEngine.new
  end

  def tire
    CarTire.new
  end
end

# ConcreteFactory
class Motorbike < Vehicle
  def engine
    MotorbikeEngine.new
  end

  def tire
    MotorbikeTire.new
  end
end

# Product
class CarEngine
  def name
    '車のエンジン'
  end
end

# Product
class CarTire
  def name
    '車のタイヤ'
  end
end

# Product
class MotorbikeEngine
  def name
    'バイクのエンジン'
  end
end

# Product
class MotorbikeTire
  def name
    'バイクのタイヤ'
  end
end

# NG
#
# 以下の場合、誤った組み合わせでもオブジェクトの生成が許容されてしまう。

vehicle = Vehicle.new
vehicle.engine = CarEngine.new
vehicle.tire = MotorbikeTire.new
p vehicle.status # => 車のエンジン と バイクのタイヤ

# OK
#
# 以下の場合、 ConcreteFactory で Product を定義している。
# そのため、誤った組み合わせが生じることはない。

car = Car.new
p car.status # => 車のエンジン と 車のタイヤ

motorcycle = Motorbike.new
p motorcycle.status # => バイクのエンジン と バイクのタイヤ
