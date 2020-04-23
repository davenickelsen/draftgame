class UserResolver

  def self.hash
    {'7244325' => 'Dave', '534623' => 'Meat', '423626' => 'Steve', '651553' => 'George'}
  end

  def self.get_user(key)
    return nil if !self.hash.has_key?(key)
    self.hash[key]
  end

  def self.all_keys
    self.hash.keys
  end

end