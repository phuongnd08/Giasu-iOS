class CardLearningController < UIViewController
  def viewDidLoad
    super
    self.title = "Learning"
    view.backgroundColor = UIColor.whiteColor
    view.addSubview(learning_view)
  end

  def learning_view
    @card = MemoCardManager.instance.cards[0]
    case @card['type']
    when 'collection'
      collection_card_view
    when 'vocabulary'
      vocabulary_card_view
    when 'card'
      card_view
    end
    collection_card_view
  end

  def collection_card_view
    collection = CollectionView.alloc.initWithFrame([[50, 200], [220, 140]])
    collection.card = @card
    collection
  end
end
