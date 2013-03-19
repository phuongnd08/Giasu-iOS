class LoginController < UIViewController
  def viewDidLoad
    super
    self.title = "Login"
    self.view.backgroundColor = UIColor.whiteColor
    view.addSubview(textLabel)
    view.addSubview(authButton)
    initFBSession
  end

  def appDelegate
    UIApplication.sharedApplication.delegate
  end

  def initFBSession
    completionBlock = Proc.new do |session, state, error|
      if error
        p 'reload fb token unsuccessfully'
      else
        p 'reload fb token successfully'
      end
    end

    if FBSessionStateCreatedTokenLoaded == appDelegate.fbSession.state
      appDelegate.fbSession.openWithCompletionHandler(completionBlock)
      authButton.setTitle("Log out", forState: UIControlStateNormal)
    end
  end

  def authButton
    @authButton ||= begin
      _authButton = UIButton.buttonWithType(UIButtonTypeRoundedRect)
      _authButton.frame = [[50, 200], [220, 44]]
      _authButton.setTitle("Login in With Facebook", forState: UIControlStateNormal)
      _authButton.addTarget(self, action: "authButtonAction:", forControlEvents: UIControlEventTouchUpInside)
      _authButton
    end
  end

  def textLabel
    @textLabel ||= begin
      _textLabel = UILabel.alloc.initWithFrame([[50, 140], [220, 44]])
      _textLabel.text = "GIA SU DIEN TU"
      _textLabel.textAlignment = UITextAlignmentCenter
      _textLabel.textColor = UIColor.lightGrayColor
      _textLabel
    end
  end

  def authButtonAction(sender)
    if appDelegate.fbSession.open?
      appDelegate.fbSession.closeAndClearTokenInformation
      authButton.setTitle("Login with Facebook", forState: UIControlStateNormal)
      p "Logged out"
    else
      loginWithFacebook
    end
  end

  def loginWithFacebook
    completionBlock = Proc.new do |session, state, error|
      if error.nil?
        updateLoggedInView
        signinWithServer
      end
    end

    unless appDelegate.fbSession.open?
      appDelegate.fbSession = FBSession.alloc.init
    end

    if FBSessionStateCreated == appDelegate.fbSession.state
      appDelegate.fbSession.openWithCompletionHandler(completionBlock)
    end
  end

  def updateLoggedInView
    authButton.setTitle("Log out", forState: UIControlStateNormal)
  end

  def signinWithServer
    HTTPClient.post("authentication/sign_in", { provider: "facebook", oauth_token: appDelegate.fbSession.accessTokenData.accessToken }) do |success, result|
      if success
        p result
        storeUser(result)
        fetchCards
      end
    end
  end

  def storeUser(user_json)
    @user = User.create(user_json)
    App::Persistence['current_user_id'] = @user.id
    appDelegate.setUpDefaultRequestHeader
  end

  CARDS_PER_BATCH_LIMIT = 10

  def fetchCards
    MemoCardManager.instance.fetchCards(CARDS_PER_BATCH_LIMIT)
  end

  def cardLearningController
    @cardLearningController ||= CardLearningController.alloc.init
  end

  def presentCardLearningController
    self.navigationController.pushViewController(cardLearningController, animated:TRUE)
  end
end
