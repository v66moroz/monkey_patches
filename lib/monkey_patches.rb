require_relative "monkey_patches/version"

class Object
  def unless_nil(_ = nil)
    if block_given?
      yield self
    else
      self
    end
  end

  def unless_blank
    unless blank?
      yield self
    end
  end

  def apply_self
    yield self
  end
end

class NilClass
  def unless_nil(default = nil)
    default.is_a?(Proc) ? default[] : default
  end
end

class Array
  def unless_empty
    unless empty?
      yield self
    end
  end
end


class Hash
  def fselect
    select { |k, v| yield(v) }  
  end

  def fmap
    h = {}
    each do |k, v|
      h[k] = yield(v)
    end
    h
  end

  def fzip(*hs)
    h = {}
    each do |k, v|
      h[k] = [v, *hs.map { |h| h.fetch(k) }]
    end
    h
  end
end

class Symbol
  # .map(&:a.fetch)
  # => 
  # .map { |x| x.fetch(:a) }
  def fetch
    ->(x) { x.fetch(self) }
  end

  # .map(&:slice.w_args(1, 3))
  # =>
  # .map { |x| x.slice(1, 3) }
  def w_args(*args)
    if block_given?
      ->(x, *xs) { x.__send__(self, *xs, *args) { |*zs| yield(*zs) } }
    else
      ->(x, *xs) { x.__send__(self, *xs, *args) }
    end
  end
end

class String
  # .map(&"a".fetch)
  # =>
  # .map { |x| x.fetch("a") }
  def fetch
    ->(x) { x.fetch(self) }
  end
end
