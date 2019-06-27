import UIKit


/**
 
 A view to indicate some processing is being done.
 
 */
internal class LoadingView: UIView {
    
    // MARK: - @IBOutlet
    
    /// An activity indicator to tell an activity is in progress.
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private
    
    // MARK: - Function
    
    /**
    
     Adds this view in a parent UIView and constrains itself to full width and height of parent.
     
     - parameter view: The parent view that will display this loading view.
     
     */
    func insertIn(view: UIView) {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }
    
    func load() {
        layer.opacity = 1
        isHidden = false
    }
    
    /// Hides this view using a fading animation.
    func dismiss() {
        let animator = UIViewPropertyAnimator(duration: 0.15, curve: .easeIn) {
            self.layer.opacity = 0
        }
        animator.addCompletion { _ in
            self.isHidden = true
        }
        animator.startAnimation()
    }
}
