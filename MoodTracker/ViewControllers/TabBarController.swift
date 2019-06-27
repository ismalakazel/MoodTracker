import UIKit
import CoreData


/**
 
 The container that holds the main page view controller and a segmented control.
 
 */
class TabBarController: UITabBarController, PersistentContainerSettable {
    
    // MARK: - PersistentContainerSettable

    var container: PersistentContainer!
    
    // MARK: - UITabBarController

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers?.forEach { destination in
            if var destination = destination as? PersistentContainerSettable {
                destination.container = container
            }
        }
    }
}
