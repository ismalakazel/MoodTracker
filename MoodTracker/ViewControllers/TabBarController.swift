import UIKit
import CoreData

/**
 
 The container that holds the main page view controller and a segmented control.
 
 */
internal class TabBarController: UITabBarController, ManagedObjectSettable {

    // MARK: - ManagedObjectSettable
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers?.forEach { vc in
            if let viewController = vc as? ManagedObjectSettable {
                viewController.managedObjectContext = managedObjectContext
            }
        }
    }
}
