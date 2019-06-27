import Foundation


/// A base Operation subclass that can be used to perform and mark task as finished
class BaseOperation: Operation {
    
    // KVO used by the operation queue to check if this operation is executing
    override public var isExecuting: Bool {
        get {
            return _finished
        }
        set {
            _executing = newValue
        }
    }
    
    // KVO used by the operation queue to check if this operation is finished
    override public var isFinished: Bool {
        get {
            return _finished
        }
        set {
            _finished = newValue
        }
    }
    
    // Mark operation concurrency type
    override public var isAsynchronous: Bool {
        return true
    }
    
    // Called by the operation queue
    override public func start() {
        guard !isExecuting else { return }
        
        guard !isCancelled else {
            _finished = true
            return
        }
        
        _executing = true
        
        main()
    }
    
    // Perform a task here. Call finish() once task is completed
    override func main() {
        guard !isCancelled else {
            _executing = false
            _finished = true
            return
        }
    }
    
    override func cancel() {
        super.cancel()
        finish()
    }
    
    /// Finishes operation
    func finish() {
        self._executing = false
        self._finished = true
    }
    
    /// Changes isExecuting KVO
    fileprivate var _executing: Bool = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    /// Changes isFinished KVO
    fileprivate var _finished: Bool = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
}
