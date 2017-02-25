
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController : UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let dashboardViewController = DashboardViewController.initViewController()
//        let firstViewController = FirstViewController.initViewController()
        self.navigationController = UINavigationController(rootViewController: dashboardViewController)
           self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 0.6235, green: 0.419, blue: 0.874, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.window?.rootViewController = self.navigationController;
        self.window?.makeKeyAndVisible()
        
        return true
    }
   

    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) { }
    func applicationDidBecomeActive(_ application: UIApplication) { }
    func applicationWillTerminate(_ application: UIApplication) {}
}

