import UIKit
import CoreData


/**
 
 A view controller that manages a table view of words you today.
 
 */
class MoodViewController: UIViewController, PersistentContainerSettable {
    
    // MARK: - PersistentContainerSettable

    var container: PersistentContainer!
    
    // MARK: - Private Property

    private var model: MoodModelController!
    private var dataSource = TableViewDataSource<MoodTableViewCell>()
    
    // MARK: - IBOutlet

    @IBOutlet private weak var loadingView: LoadingView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = MoodModelController(container: container)
        tableView.dataSource = dataSource

        model.fetch { response in
            DispatchQueue.main.async { [weak self] in
                self?.loadingView.dismiss()
                self?.questionLabel.text = response.text
                self?.dataSource.data = response.answers
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK - @IBAction

    @IBAction private func save(_ sender: UIBarButtonItem) {
        guard let selection = tableView.indexPathForSelectedRow else { return }
        model.save(answerResponse: dataSource.data[selection.row], and: questionLabel.text!)
    }
}

// MARK: - UITableViewDelegate

extension MoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.visibleCells.forEach { cell in cell.accessoryType = .none }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        saveButton.isEnabled = true
        return indexPath
    }
}


