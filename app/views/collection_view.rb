class CollectionView < UIView
  attr_accessor :card

  def card=(c)
    @card = c
    self.addSubview(nameLabel)
    self.addSubview(descriptionLabel)
  end

  def nameLabel
    _nameLabel = UILabel.alloc.initWithFrame([[0, 0], [220, 40]])
    _nameLabel.text = @card[:name]
    _nameLabel
  end

  def descriptionLabel
    _descriptionLabel= UILabel.alloc.initWithFrame([[0, 45], [220, 40]])
    _descriptionLabel.text = @card[:description] || "No description"
    _descriptionLabel
  end
end
