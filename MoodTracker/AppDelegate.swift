import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var persistentContainer: PersistentContainer!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Load model in the persistent container.
        persistentContainer = PersistentContainer(name: "Model", store: .sqlite)
        
        // Pass the view context to the root view controller.
        if let viewController = window?.rootViewController as? ManagedObjectSettable {
            viewController.managedObjectContext = persistentContainer.viewContext
        }
        
        return true
    }
}

