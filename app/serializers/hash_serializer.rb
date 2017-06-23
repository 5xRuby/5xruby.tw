class HashSerializer
  def self.dump(hash)
    hash
  end

  def self.load(hash)
    (hash.presence || {}).with_indifferent_access
  end
end
