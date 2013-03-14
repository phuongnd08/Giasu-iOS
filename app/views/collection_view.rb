class CollectionView < UIView
  attr_accessor :card

  def card=(c)
    @card = c
    self.addSubview(name_view)
    self.addSubview(description_view)
  end

  def name_view
    name = UILabel.alloc.initWithFrame([[0, 0], [220, 40]])
    name.text = @card['name']
    name
  end

  def description_view
    description= UILabel.alloc.initWithFrame([[0, 45], [220, 40]])
    description.text = @card['description'] || "No description"
    description
  end
end
