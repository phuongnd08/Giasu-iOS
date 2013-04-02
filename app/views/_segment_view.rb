class SegmentView < UIView
  attr_accessor :data

  def data=(d)
    @data = d
    initUIComponents
  end

  def initUIComponents
    if @data[:type] == 'text'
      initTextUI
    else
      initInputUI
    end
  end

  def initTextUI
    url_regex = /https?:\/\/[\S]+/
    p "DATA TEXTTTTT"
    p @data[:text]
    if @data[:text]
      if match_data = @data[:text].match(url_regex)
        p "url match: #{match_data.to_s}"
        self.addSubview(urlView(match_data.to_s))
        content = @data[:text].gsub(match_data.to_s, '').strip
        self.addSubview(textLabel(content, [[0, 40], [420, 40]]))
      else
        self.addSubview(textLabel(@data[:text], [[0, 0], [420, 40]]))
      end
    end
  end

  def initInputUI
    self.addSubview(textLabel(@data[:hint], [[0, 0], [220, 40]]))
    self.addSubview(answerView)
    self.tag = 300
  end

  def answerView
    @answerTextfield = UITextField.alloc.initWithFrame([[0, 40], [220, 40]])
    @answerTextfield.backgroundColor = UIColor.grayColor
    @answerTextfield.textColor = UIColor.blueColor
    @answerTextfield.resignFirstResponder
    @answerTextfield
  end

  def checkAnswer
    p @answerTextfield.text
    p @data[:answer]
    return true if @answerTextfield.text.downcase.strip == @data[:answer]
    false
  end

  def urlView(url)
    if url.match(/\.jpg$/)
      imageView = UIImageView.alloc.initWithFrame([[0, 0], [220, 40]])
      imageView.image = UIImage.alloc.initWithData(NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(url)))
      imageView
    else
      mp3Button = UIButton.alloc.buttonWithType(UIButtonTypeRoundedRect)
      mp3Button.frame = [[0, 0], [220, 40]]
      mp3Button.addTarget(self, action: "mp3ButtonAction", forControlEvents:UIControlEventTouchUp)
      mp3Button
    end
  end

  def textLabel(content, frame)
    textLabel = UILabel.alloc.initWithFrame(frame)
    textLabel.text = content
    textLabel.textColor = UIColor.blueColor
    p "TEXT CONTENTNNNNNNNNNNNNNN"
    p "label #{content}"
    textLabel
  end

  def mp3ButtonAction
    p "mp3 player"
  end
end

