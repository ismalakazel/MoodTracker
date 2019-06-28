import UIKit


/**
 
 A view to indicate some processing is being done.
 
 */
class LoadingView: UIView {
    
    // MARK: - @IBOutlet
    
    /// An activity indicator to tell an activity is in progress.
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public Method
    
    func show() {
        layer.opacity = 1
        isHidden = false
    }
    
    func hide() {
        let animator = UIViewPropertyAnimator(duration: 0.15, curve: .easeIn) {
            self.layer.opacity = 0
        }
        animator.addCompletion { _ in
            self.isHidden = true
        }
        animator.startAnimation()
    }
}
