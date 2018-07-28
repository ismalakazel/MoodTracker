import UIKit


/**
 
 A view controller that manages a table view of words you today.
 
 */
internal class MoodViewController: UIViewController {
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - @IBOutlet

    @IBOutlet private weak var tableView: UITableView!

    @IBOutlet private weak var saveButton: UIBarButtonItem!
    
    // MARK: - Property

    private let dataSource: [String] = ["Intelligent", "Stupid", "Okay"]
    
    // MARK: - @IBAction

    @IBAction private func save(_ sender: UIBarButtonItem) {
        print("ToDo: Save mood selection to Core Data")
    }
}

// MARK: - UITableViewDataSource

extension MoodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoodTableViewCell.identifier, for: indexPath) as! MoodTableViewCell
        cell.moodLabel.text = dataSource[indexPath.row]
        return cell
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


