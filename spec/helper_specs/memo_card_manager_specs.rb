describe "MemoCardManager" do
  before do
    @success_response = { cards: 'many cards' }
  end

  describe "fetch cards" do
    before do
      MemoCardManager.instance.cards = nil
    end

    describe "with response successfully" do
      it "get card listings json" do
        cards = @success_response
        HTTPClient.stub!(:post) do |path, paramters, &block|
          block.call(true, cards)
        end

        MemoCardManager.instance.fetchCards(10)
        MemoCardManager.instance.cards.should == cards
      end
    end

    describe "with response unseccessfully" do
      it "cards will be nil" do
        HTTPClient.stub!(:post) do |path, paramters, &block|
          block.call(false, nil)
        end

        MemoCardManager.instance.fetchCards(10)
        MemoCardManager.instance.cards.should == nil
      end
    end
  end
end
