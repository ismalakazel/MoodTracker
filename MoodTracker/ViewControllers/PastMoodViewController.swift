import UIKit
import CoreData


/**
 
 A view controller that manages a table view of words you today.
 
 */
internal class PastMoodViewController: UIViewController, ManagedObjectSettable {
    
    // MARK: - ManagedObjectSettable
    
    var managedObjectContext: NSManagedObjectContext!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.setFetchRequest(fetchRequest: Answer.fetchRequest)
        tableView.dataSource = dataSource
        tableView.rowHeight = 120
        tableView.estimatedRowHeight = 120
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.fetch()
    }
    
    // MARK: - Property
    
    private lazy var dataSource: ManagedTableViewDataSource<PastMoodTableViewCell>! = {
        return ManagedTableViewDataSource<PastMoodTableViewCell>(tableView: tableView, moc: managedObjectContext)
    }()

    // MARK: - @IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
}


