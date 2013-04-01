class CardLearningController < UIViewController
  def viewDidLoad
    super
    self.title = "Learning"
    view.backgroundColor = UIColor.whiteColor
    add_learning_view
    self.navigationItem.hidesBackButton = true
    self.navigationItem.rightBarButtonItem = done_button
  end

  def done_button
    UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemDone, target: self, action: 'doneAction')
  end

  def add_learning_view
    @learning_view = learning_view
    view.addSubview(@learning_view)
  end

  def doneAction
    answer_view = @learning_view.viewWithTag(300)
    if answer_view.check_answer
      p 'right answer'
      @learning_view = nil
      add_learning_view
    else
      p 'wrong answer'
    end
  end

  def learning_view
    @card = MemoCardManager.instance.pop
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
    @collection_view ||= CollectionView.alloc.initWithFrame([[50, 50], [220, 140]])
    @collection_view.card = @card
    @collection_view
  end

  def vocabulary_card_view
    @vocabulary_view ||= VocabularyView.alloc.initWithFrame([[50, 50], [220, 140]])
    @vocabulary_view.card = @card
    @vocabulary_view
  end

  def card_view
    @card_view ||= CardView.alloc.initWithFrame([[0, 0], [220, 800]])
    @card_view.card = @card
    @card_view
  end

  def touchesBegan(touches, withEvent: event)
    view.endEditing(true)
    super
  end
end
