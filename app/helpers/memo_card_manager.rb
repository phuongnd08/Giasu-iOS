class MemoCardManager
  attr_accessor :cards

  def self.instance
    @instance ||= new
  end

  def appDelegate
    UIApplication.sharedApplication.delegate
  end

  def fetchCards(limit)
    HTTPClient.post("memo_cards/list", { limit: limit }) do |success, result|
      p result[:cards]
      if success
        @cards = result[:cards]
        appDelegate.navController.topViewController.presentCardLearningController
      end
    end
  end

  def pop
    if @cards.first
      first_element = @cards.first.dup
      @cards = @cards[1..@cards.length]
      return first_element
    end
    nil
  end
end
