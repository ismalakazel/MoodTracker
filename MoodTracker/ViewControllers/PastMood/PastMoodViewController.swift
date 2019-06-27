import UIKit
import CoreData


/**
 
 A view controller that manages a table view of words you today.
 
 */
class PastMoodViewController: UIViewController, PersistentContainerSettable {
    
    // MARK: - PersistentContainerSettable
    
    var container: PersistentContainer!
    
    // MARK: - Private Property
    
    private var dataSource: ManagedTableViewDataSource<PastMoodTableViewCell>!
    
    // MARK: - @IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ManagedTableViewDataSource(tableView: tableView, moc: container.viewContext)
        dataSource.setFetchRequest(fetchRequest: Answer.fetchRequest)
        tableView.dataSource = dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.fetch()
    }
}


