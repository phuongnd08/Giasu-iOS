class AppDelegate
  attr_accessor :fbSession

  ::FBSessionStateChangedNotification = "#{App.identifier}:FBSessionStateChangedNotification"

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
    true
  end

  def applicationDidBecomeActive(application)
    FBSession.activeSession.handleDidBecomeActive
  end

  def applicationWillTerminate(application)
    FBSession.activeSession.close
  end

  # If we have a valid session at the time of openURL call, we handle
  # Facebook transitions by passing the url argument to handleOpenURL (< iOS 6)
  #
  # Returns a Boolean value
  def application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    # attempt to extract a token from the url
    @fbSession.handleOpenURL(url)
  end

  # Close the Facebook session when done
  def closeSession
    FBSession.activeSession.closeAndClearTokenInformation
  end

end

