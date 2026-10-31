# Recursive algorithms written with pattern matching.
def qsort(list)
  case list
  in [] then []
  in [pivot, *rest]
    qsort(rest.select { |x| x < pivot }) + [pivot] + qsort(rest.reject { |x| x < pivot })
  end
end

def merge(a, b)
  case [a, b]
  in [[], ys] then ys
  in [xs, []] then xs
  in [[x, *xs], [y, *ys]] then x <= y ? [x] + merge(xs, b) : [y] + merge(a, ys)
  end
end

def msort(list) = list.size < 2 ? list : merge(msort(list[0...list.size / 2]), msort(list[list.size / 2..]))

def compress(list)
  case list
  in [] then []
  in [x] then [[x, 1]]
  in [x, *rest]
    (y, n), *tail = compress(rest)
    x == y ? [[x, n + 1], *tail] : [[x, 1], [y, n], *tail]
  end
end

data = [5, 2, 9, 1, 5, 6, 3]
puts qsort(data).inspect
puts msort(data).inspect
puts compress(%w[a a b c c c a]).inspect
