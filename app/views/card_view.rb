class CardView < UIView
  attr_accessor :card

  def card=(c)
    p "set card in carview"
    @card = c
    p @card
    @chains = @card[:structure][:chains]
    addUIComponents
  end

  def addUIComponents
    self.subviews.map { |view| view.removeFromSuperview }
    @chains.each_with_index do |chain, chain_idx|
      p "CHAINNNNNNNN"
      p chain
      chain[:segments].each_with_index do |segment, segment_idx|
        p "SEGMENTTTTTTTTTTTT"
        p segment
        _segment_view = SegmentView.alloc.initWithFrame([[0, chain_idx * 110 + segment_idx * 110], [220, 100]])
        p _segment_view.frame
        _segment_view.data = segment
        self.addSubview(_segment_view)
      end
    end
  end
end


