import UIKit


/**
 
 A table view cell to display a single UILabel.
 
 */
internal class MoodTableViewCell: UITableViewCell, ManagedTableViewCell {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var moodLabel: UILabel!
    
    // MARK: - ConfigurableCell
    
    func configure(model: Answer) {
        moodLabel.text = model.text
    }
}
