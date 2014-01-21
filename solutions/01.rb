class Integer
  def prime?
    return false if self < 2
      end
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
    hash = {}
    self.each do |number|
      if hash.has_key?(number)
        hash[ number ] += 1
      else
        hash[ number ] = 1
      end
    end
    hash
  end

  def average
    reduce(:+).to_f / length
  end

  def drop_every(n)
    find_all{ |i| i % n != 0 }
  end

  def combine_with(other)
    if length > other.length
      zip(other).flatten.compact
    else
      other.zip(self).flatten.compact
    end
  end
end