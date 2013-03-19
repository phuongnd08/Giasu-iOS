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
  end

  def collection_card_view
    collection_view = CollectionView.alloc.initWithFrame([[50, 50], [220, 140]])
    collection_view.card = @card
    collection_view
  end

  def vocabulary_card_view
    vocabulary_view = VocabularyView.alloc.initWithFrame([[50, 50], [220, 140]])
    vocabulary_view.card = @card
    vocabulary_view
  end
end
