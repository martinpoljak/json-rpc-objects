class Hash
  def keys_to_sym
    map_keys{ |key| key.to_sym rescue key }
  end

  def keys_to_sym!
    self.replace(self.symbolize_keys)
  end

  def map_keys
    result = {}
    each_key do |key|
      result[yield(key)] = self[key]
    end
    result
  end

  def map_keys!
    keys.each do |key|
      self[yield(key)] = delete(key)
    end
    self
  end
end
