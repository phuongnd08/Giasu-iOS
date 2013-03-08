class MemoCardManager
  attr_accessor :cards

  def self.instance
    @instance ||= new
  end

  def fetchCards(limit)
    HTTPClient.post("memo_cards/list", { limit: limit }) do |success, result|
      @cards = result if success
    end
  end
end
