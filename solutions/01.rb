class Integer
  def prime?
    return false if self < 2
    2.upto(pred).all?{ |number| self % number != 0 }
  end

  def prime_factors
    return [] if abs < 2
    divisor = 2.upto(abs).find{ |number| number.prime? and abs % number == 0 }
    [divisor] + (abs / divisor).prime_factors 
  end

  def find_harmonic_number
    1 / self.to_r
  end

  def harmonic
    sum = 0.to_r
    (1..self).each { |i| sum = sum + i.find_harmonic_number }
    sum
  end

  def digits
    abs.to_s.scan(/./).map { |number| number.to_i }
  end
end

class Array
  def frequencies
    Hash[each.map { |element| [element, count(element)] }]
  end

  def average
    reduce(:+).to_f / length
  end

  def drop_every(n)
    index = 0
    find_all{ |number| (index+=1) % n != 0 }
  end

 def combine_with(other)
    return other if self == []
    return self if other == []
    [self[0]] + other.combine_with(self.drop(1))
  end
end