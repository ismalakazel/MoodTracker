import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Load model in the persistent container.
        let persistentContainer = PersistentContainer(name: "Model", store: .sqlite)
        
        // Pass the persistent container to the root view controller.
        if var viewController = window?.rootViewController as? PersistentContainerSettable {
            viewController.container = persistentContainer
        }
        
        return true
    }
}

