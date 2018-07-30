import UIKit
import CoreData


/**
 
 A view controller that manages a table view of words you today.
 
 */
internal class MoodViewController: UIViewController, ManagedObjectSettable, QuestionService {
    
    // MARK: - ManagedObjectSettable

    var managedObjectContext: NSManagedObjectContext!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure loading view.
        loadingView.insertIn(view: self.view)

        // Configure table view and data source.
        dataSource = TableViewDataSource<MoodTableViewCell>()
        tableView.dataSource = dataSource
        
        // Fetch question from remote storage.
        list { result in
            if case .success(let response) = result {
                DispatchQueue.main.async {
                    self.loadingView.dismiss()
                    self.questionLabel.text = response.text
                    self.dataSource.data = response.answers
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - @IBOutlet
    
    /// View shown when the controller is presented and dismissed when answers are loaded.
    @IBOutlet private weak var loadingView: LoadingView!
    
    /// A question posed to the user.
    @IBOutlet weak var questionLabel: UILabel!
    
    /// A table view that shows a set of answers to a question.
    @IBOutlet private weak var tableView: UITableView!

    /// A save button that is only enabled after an answer is chosen.
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    
    // MARK: - Property
    
    /// A data source to manage the list of answers in a table view.
    private var dataSource: TableViewDataSource<MoodTableViewCell>!
    
    // MARK: - @IBAction

    /// Saves the question and the chosen answer to the persistent store.
    @IBAction private func save(_ sender: UIBarButtonItem) {
        guard let selection = tableView.indexPathForSelectedRow else { return }
        managedObjectContext.performChanges {
            // Save answer.
            let answer = Answer(moc: self.managedObjectContext)
            answer.text = self.dataSource.data[selection.row].text
            answer.weight = Int16(self.dataSource.data[selection.row].weight)
            answer.lid = UUID()
            answer.date = Date()
            
            // Save question.
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


