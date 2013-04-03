class CardView < UIView
  attr_accessor :card

  def card=(c)
    p "set card in carview"
    @card = c
    p @card
    if @card[:question_data_type] == 'fill-in-the-blanks'
      addFillInBlankUIComponents
    elsif @card[:question_data_type] == 'multiple-choices'
      addMultipleChoicesUIComponents
    end
  end

  def addFillInBlankUIComponents
    _chains = @card[:structure][:chains]
    self.subviews.map { |view| view.removeFromSuperview }
    _chains.each_with_index do |chain, chain_idx|
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

  def addMultipleChoicesUIComponents
    self.subviews.map { |view| view.removeFromSuperview }
    _topic = @card[:structure][:topic]
    p _topic
    url_regex = /https?:\/\/[\S]+/
    if image_url = _topic.match(url_regex)
      p "image_url: #{image_url}"
      self.addSubview(imageView(image_url.to_s))
      self.addSubview(labelTopicView(_topic.gsub(image_url.to_s, '').strip))
    else
      self.addSubview(labelTopicView(_topic))
    end
    self.addSubview(addMultipleChoicesView)
  end

  def imageView(url)
    _imageView = UIImageView.alloc.initWithFrame([[0, 0], [220, 40]])
    _imageView.image = UIImage.alloc.initWithData(NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(url)))
    _imageView
  end

  def labelTopicView(topic)
    _textLabel = UILabel.alloc.initWithFrame([[0, 40], [420, 40]])
    _textLabel.text = topic
    _textLabel.textColor = UIColor.blueColor
    _textLabel

  end

  def addMultipleChoicesView
    _mcView = MultipleChoicesView.alloc.initWithFrame([[0, 80], [220, 120]])
    _mcView.data = @card[:structure][:options]
    _mcView.data
    _mcView
  end
end


