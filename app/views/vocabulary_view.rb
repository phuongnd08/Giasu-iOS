class VocabularyView < UIView
  attr_accessor :card

  def card=(c)
    @card = c
    [wordLabel, phoneticLabel, audioButton, meaningLabel, picture].each do |uiComponent|
      self.addSubview(uiComponent)
    end
  end

  def wordLabel
    _wordLabel = UILabel.alloc.initWithFrame([[0, 0], [220, 20]])
    _wordLabel.text = @card[:word]
    _wordLabel
  end

  def phoneticLabel
    _phoneticLabel= UILabel.alloc.initWithFrame([[0, 20], [220, 20]])
    _phoneticLabel.text = @card[:phonetic]
    _phoneticLabel
  end

  def audioButton
    _audioButton= UIButton.buttonWithType(UIButtonTypeRoundedRect)
    _audioButton.frame = [[0, 40], [220, 20]]
    _audioButton
  end

  def meaningLabel
    _meaningLabel= UILabel.alloc.initWithFrame([[0, 60], [220, 20]])
    _meaningLabel.text = @card[:meaning]
    _meaningLabel
  end

  def picture
    _picture= UIImageView.alloc.initWithFrame([[0, 80], [120, 200]])
    _picture.image = UIImage.imageWithData(NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(@card[:picture_url])))
    _picture
  end
end

