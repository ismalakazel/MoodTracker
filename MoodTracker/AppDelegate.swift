import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var persistentContainer: PersistentContainer!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Load model in the persistent container.
        let model = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        persistentContainer = PersistentContainer(    name: "Model", model: model, store: .memory)
        
        // Pass the view context to the root view controller.
        if let viewController = window?.rootViewController as? ManagedObjectSettable {
            viewController.persistentContainer = persistentContainer
        }
        return true
    }
}

