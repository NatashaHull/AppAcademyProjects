class Fixnum
  LOWS = [
    "zero", "one", "two", "three", "four",
    "five", "six", "seven", "eight", "nine",
    "ten", "eleven", "twelve", "thirteen", "fourteen",
    "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
  ]

  MIDS = [
    "twenty", "thirty", "forty", "fifty",
    "sixty", "seventy", "eighty", "ninety"
  ]

  HIGHS = [
    "thousand", "million", "billion", "trillion"
  ]

  def tens(num)
    result = []
    if num < 20
      result << LOWS[num]
    else
      result << MIDS[(num / 10) - 2]
      result << LOWS[num % 10]
    end
    result
  end

  def hundreds(num)
    result = []
    if num > 99
      result << LOWS[num / 100]
      result << "hundred"
    end
    result << tens(num % 100)
    result
  end

  def find_scope(num)
    scope = 1000
    while scope <= num
      scope *= 1000
    end
    scope / 1000
  end

  def scope_word(num)
    result = ""
    thousands = (num.to_s.length-1)/3
    result = HIGHS[thousands-1]
    result
  end

  def filter_zeroes(arr)
    if arr.length > 1
      arr = arr.delete_if { |num| num == "zero" }
    end
    arr
  end

  def in_words
    result = []
    num = self
    scope = find_scope(num)
    while num >= 1000
      result += hundreds(num / scope)
      result << scope_word(scope)
      num = num % scope
      scope /= 1000
    end
    result += hundreds(num)
    result.flatten!
    result = filter_zeroes(result)
    result.join(" ")
  end
end