import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  lazy var window: UIWindow? = {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = GameViewController()
    return window
  }()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window!.makeKeyAndVisible()
    return true
  }
}
