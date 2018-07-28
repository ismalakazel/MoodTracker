import UIKit


/**
 
 A table view cell to display a single UILabel.
 
 */
internal class MoodTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var moodLabel: UILabel!
    
    // MARK: - ConfigurableCell
    
    func configure(with model: String) {
        moodLabel.text = model
    }
}
