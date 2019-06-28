import UIKit
import CoreData


/**
 
 A view controller that manages a table view of words you today.
 
 */
class MoodViewController: UIViewController, PersistentContainerSettable, URLSessionSettable {
    
    // MARK: - URLSessionSettable
    
    var session: URLSession!
    
    // MARK: - PersistentContainerSettable

    var container: PersistentContainer!
    
    // MARK: - IBOutlet
    
    @IBOutlet private(set) weak var loadingView: LoadingView!
    @IBOutlet private(set) weak var questionLabel: UILabel!
    @IBOutlet private(set) weak var tableView: UITableView!
    @IBOutlet private(set) weak var saveButton: UIBarButtonItem!
    
    // MARK: - Private Property

    private var model: MoodModelController!
    private var dataSource = TableViewDataSource<MoodTableViewCell>()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = MoodModelController(container: container, session: session)
        tableView.dataSource = dataSource

        model.fetchQuestion { response in
            DispatchQueue.main.async { [weak self] in
                self?.loadingView.hide()
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


