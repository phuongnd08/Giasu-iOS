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
end
