class CollectionView < UIView
  attr_accessor :card

  def card=(c)
    @card = c
    self.addSubview(name_label)
    self.addSubview(description_label)
  end

  def name_label
    _nameLabel = UILabel.alloc.initWithFrame([[0, 0], [220, 40]])
    _nameLabel.text = @card[:name]
    _nameLabel
  end

  def description_label
    _descriptionLabel= UILabel.alloc.initWithFrame([[0, 45], [220, 40]])
    _descriptionLabel.text = @card[:description] || "No description"
    _descriptionLabel
  end
end
