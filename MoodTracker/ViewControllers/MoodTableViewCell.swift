import UIKit


/**
 
 A table view cell to display a word describing a mood.
 
 */
internal class MoodTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var moodLabel: UILabel!
    
    // MARK: - ManagedTableViewCell
    
    func configure(with model: String) {
        moodLabel.text = model
    }
}
