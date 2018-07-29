import UIKit


/**
 
 A table view cell to display past moods.
 
 */
internal class PastMoodTableViewCell: UITableViewCell, ManagedTableViewCell {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var moodLabel: UILabel!
    
    // MARK: - ManagedTableViewCell
    
    func configure(model: Answer) {
        moodLabel.text = model.text
    }
}
