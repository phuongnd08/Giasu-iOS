class CardLearningController < UIViewController
  def viewDidLoad
    super
    self.title = "Learning"
    view.backgroundColor = UIColor.whiteColor
    addLearningView
    self.navigationItem.hidesBackButton = true
    self.navigationItem.rightBarButtonItem = doneButton
  end

  def doneButton
    UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemDone, target: self, action: 'doneAction')
  end

  def addLearningView
    @learning_view = learningView
    view.addSubview(@learning_view)
    @beginTime = Time.now
  end

  def doneAction
    answerQuestion
    @learning_view = nil
    addLearningView
  end

  def answerQuestion
    _answer_view = @learning_view.viewWithTag(300)
    if _answer_view
      _delta_time = Time.now - @beginTime
      _params = { question_id: @card[:question_id],
                  value: [_answer_view.answerText].flatten,
                  within: _delta_time
                }
      HTTPClient.post('memo_cards/answer', _params) do |success, result|
        p result
        if success
          p 'SUCCESS POST ANSWER'
        end
      end
    end
  end

  def learningView
    @card = MemoCardManager.instance.pop
    if @card
      case @card['type']
      when 'collection'
        collectionCardView
      when 'vocabulary'
        vocabularyCardView
      when 'card'
        cardView
      end
    else
      finishLearning
    end
  end

  def finishLearning
    view.endEditing(true)
    _alert = UIAlertView.alloc.init
    _alert.message = 'Great work'
    _alert.addButtonWithTitle 'OK'
    _alert.show
  end

  def collectionCardView
    @collection_view ||= CollectionView.alloc.initWithFrame([[50, 50], [220, 140]])
    @collection_view.card = @card
    @collection_view
  end

  def vocabularyCardView
    @vocabulary_view ||= VocabularyView.alloc.initWithFrame([[50, 50], [220, 140]])
    @vocabulary_view.card = @card
    @vocabulary_view
  end

  def cardView
    @card_view ||= CardView.alloc.initWithFrame([[0, 0], [220, 800]])
    @card_view.card = @card
    @card_view
  end

  def touchesBegan(touches, withEvent: event)
    view.endEditing(true)
    super
  end
end
