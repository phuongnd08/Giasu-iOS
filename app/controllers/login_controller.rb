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
      NSLog('reload fb token') unless error
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
      NSLog("Logged out")
    else
      loginWithFacebook
    end
  end

  def loginWithFacebook
    completionBlock = Proc.new do |session, state, error|
      if error.nil?
        NSLog('login with fb, create new token')
        updateLoginedView
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

  def updateLoginedView
    authButton.setTitle("Log out", forState: UIControlStateNormal)
    NSLog("\nUpdate Logined View")
  end

  def signinWithServer
    AFMotion::Client.shared.post("authentication/sign_in", provider: "facebook", oauth_token: appDelegate.fbSession.accessTokenData.accessToken) do |result|
      NSLog("\n Sign in, post a request")
      if result.success?
        p result.object
        presentCardLearningController
        saveUser(result.object)
        fetchCardListings
      elsif result.failure?
        p "FAIL.........."
        p result.operation.responseJSON
      end
    end
  end

  def saveUser(user_json)
    @user = User.create(user_json)
    p @user.inspect
    App::Persistence['current_user_id'] = @user.id
    appDelegate.setUpDefaultRequestHeader
  end

  LIMIT = 10

  def fetchCardListings
    MemoCardManager.memoCardShared.fetchListCards(LIMIT)
  end

  def cardLearningController
    @cardLearningController ||= CardLearningController.alloc.init
  end

  def presentCardLearningController
    self.navigationController.pushViewController(cardLearningController, animated:TRUE)
  end
end
