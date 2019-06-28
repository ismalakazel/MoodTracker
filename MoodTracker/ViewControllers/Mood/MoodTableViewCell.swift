import UIKit


/**
 
 A table view cell to display a word describing a mood.
 
 */
class MoodTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var moodLabel: UILabel!
    
    // MARK: - ManagedTableViewCell
    
    func configure(with model: AnswerResponse) {
        moodLabel.text = model.text
    }
}
