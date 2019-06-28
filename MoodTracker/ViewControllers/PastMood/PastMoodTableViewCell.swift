import UIKit


/**
 
 A table view cell to display past moods.
 
 */
class PastMoodTableViewCell: UITableViewCell, ManagedTableViewCell {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!

    // MARK: - ManagedTableViewCell
    
    func configure(model: Answer) {
        answerLabel.text = model.text
        questionLabel.text = model.question.text
   }
}
