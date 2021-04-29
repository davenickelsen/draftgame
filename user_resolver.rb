class UserResolver

  def self.hash
    {'053116' => 'Dave', '032957' => 'Meat', '060752' => 'Steve', '121746' => 'George'}
  end

  def self.get_user(key)
    return nil if !self.hash.has_key?(key)
    self.hash[key]
  end

  def self.all_keys
    self.hash.keys
  end

end