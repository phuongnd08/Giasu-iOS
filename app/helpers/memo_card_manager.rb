class MemoCardManager
  def self.memoCardShared
    Dispatch.once { @instance ||= new }
    @instance
  end

  def fetchListCards(limit)
    AFMotion::Client.shared.post("memo_cards/list", limit: limit) do |result|
      NSLog("\n get list memo cards")
      if result.success?
        p result.object
      elsif result.failure?
        p "FAIL.........."
        p result.operation.responseJSON
      end
    end
  end
end
