import UIKit
import CoreData


/**
 
 A view controller that manages a table view of words you today.
 
 */
internal class MoodViewController: UIViewController, ManagedObjectSettable {
    
    // MARK: - ManagedObjectSettable

    var persistentContainer: PersistentContainer!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ["Intelligent", "Okay", "Bad"].forEach { text in
            let answer = Answer(moc: persistentContainer.viewContext)
            answer.text = text
        }
        tableView.dataSource = dataSource
        dataSource.fetch()
    }

    // MARK: - Property
    
    private lazy var dataSource: ManagedTableViewDataSource<MoodTableViewCell>! = {
        return ManagedTableViewDataSource<MoodTableViewCell>(tableView: tableView, moc: viewContext)
    }()
    
    /// A context to save answers.
    private lazy var viewContext: NSManagedObjectContext! = {
       return persistentContainer.viewContext
    }()
    
    // MARK: - @IBOutlet

    @IBOutlet private weak var tableView: UITableView!

    @IBOutlet private weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    // MARK: - @IBAction

    @IBAction private func save(_ sender: UIBarButtonItem) {
        guard let selection = tableView.indexPathForSelectedRow else { return }
        viewContext.performChanges {
            let answer = self.dataSource.objectAtIndexPath(selection)
            answer.lid = UUID()
        }
    }
    
    @IBAction private func filter(_ sender: UISegmentedControl) {
        defer {
            dataSource.fetch()
        }
        switch sender.selectedSegmentIndex {
        case 1:
            dataSource.setFetchRequest(fetchRequest: Answer.fetchByLid)
            questionLabel.text = "My past moods."
            saveButton.isEnabled = false
        default:
            dataSource.setFetchRequest(fetchRequest: Answer.fetchRequest)
            questionLabel.text = "Which word best describes your day?"
            saveButton.isEnabled = true
        }
    }
}

// MARK: - UITableViewDelegate

extension MoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        saveButton.isEnabled = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }
}


