import UIKit
import CoreData


/**
 
 A view controller that manages a table view of words you today.
 
 */
internal class MoodViewController: UIViewController, ManagedObjectSettable {
    
    // MARK: - ManagedObjectSettable

    var managedObjectContext: NSManagedObjectContext!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = ["Intelligent", "Okay", "Bad"]
        dataSource = TableViewDataSource<MoodTableViewCell>()
        dataSource.data = data
        tableView.dataSource = dataSource
        tableView.rowHeight = 120
        tableView.estimatedRowHeight = 120
        tableView.reloadData()
    }
    
    // MARK: - Property
    
    private var dataSource: TableViewDataSource<MoodTableViewCell>!
    
    // MARK: - @IBOutlet

    @IBOutlet private weak var tableView: UITableView!

    @IBOutlet private weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    // MARK: - @IBAction

    @IBAction private func save(_ sender: UIBarButtonItem) {
        guard let selection = tableView.indexPathForSelectedRow else { return }
        managedObjectContext.performChanges {
            // Save answer to context.
            let answer = Answer(moc: self.managedObjectContext)
            answer.text = self.dataSource.data[selection.row]
            answer.lid = UUID()
            answer.date = Date()
            
            // Save question to context.
            let question = Question(moc: self.managedObjectContext)
            question.text = self.questionLabel.text!
            question.id = 1
            question.date = Date()
        }
    }
}

// MARK: - UITableViewDelegate

extension MoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // Necessary in order to remove checkmark after saving to core data.
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        saveButton.isEnabled = true
        return indexPath
    }
}


