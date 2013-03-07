class AppDelegate
  attr_accessor :fbSession

  def fbSession
    @fbSession ||= FBSession.alloc.init
  end

  def first_controller
    @first_controller ||= LoginController.new
  end

  def navController
    @navController ||= UINavigationController.alloc.initWithRootViewController(first_controller)
  end

  def window
    @window ||= UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    window.rootViewController = navController
    window.makeKeyAndVisible
    setUpDefaultRequestHeader
    true
  end

  DEFAULT_PATH = "http://localhost:3000/api/"

  def setUpDefaultRequestHeader
    AFMotion::Client.build_shared(DEFAULT_PATH) do
      header "Accept", "application/json"
      header "X-Giasu-App-Key", "ios"
      header "X-Giasu-App-Secret", "erhy2ks81SQjWAdKkQGN"
      if(user_id = App::Persistence['current_user_id'])
        user = User.where(:id).eq(user_id).first
        header "X-Giasu-User-Token", user.token if user
      end
      operation :json
    end
  end

  def applicationDidBecomeActive(application)
    fbSession.handleDidBecomeActive
  end

  def applicationWillTerminate(application)
    fbSession.close
  end

  # If we have a valid session at the time of openURL call, we handle
  # Facebook transitions by passing the url argument to handleOpenURL (< iOS 6)
  #
  # Returns a Boolean value
  def application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    # attempt to extract a token from the url
    fbSession.handleOpenURL(url)
  end

  # Close the Facebook session when done
  def closeSession
    fbSession.closeAndClearTokenInformation
  end

end
