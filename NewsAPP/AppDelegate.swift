import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()
        
        
        let firstNavController = UINavigationController(rootViewController: firstVC)
        let secondNavController = UINavigationController(rootViewController: secondVC)
        
        
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([firstNavController, secondNavController], animated: true)
        
        self.window?.rootViewController = tabBarVC
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    
}

