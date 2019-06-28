import UIKit
import CoreData


/**
 
 A UITableViewDataSource that reacts to changes of a NSFetchedResultsController.
 
 */
public final class ManagedTableViewDataSource<C: ManagedTableViewCell>: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    /**
     
     ManagedTableViewDataSource initializer.
     
     - parameter tableView: The UITableView whose data source will be managed by this class.
     - parameter moc: The NSManagedObjectContext to fetch the managed objects from.
     
     */
    public init(tableView: UITableView, moc: NSManagedObjectContext) {
        super.init()
        self.tableView = tableView
        self.tableView.dataSource = self
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: C.Model.fetchRequest, managedObjectContext: moc, sectionNameKeyPath: C.Model.sectionNameKeyPath, cacheName: C.Model.cacheName)
        self.fetchedResultsController.delegate = self
    }
    
    /**
 
     Performs a fetch request to the NSFetchedResultsController.
     
     */
    public func fetch() {
        do {
            try self.fetchedResultsController.performFetch()
            self.tableView.reloadData()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    /**
     
     Sets the fetch request that need to be performed by the NSFetchedResultsController.
     
     */
    public func setFetchRequest(fetchRequest: NSFetchRequest<C.Model>) {
        let moc = fetchedResultsController.managedObjectContext
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: C.Model.cacheName)
    }
    
    /**
     
     Fetches managed object from the fetchedResultsController at a given IndexPath.
     
     - parameter indexPath: The index path to get the model from.
     - returns: A managed object.
     
     */
    public func objectAtIndexPath(_ indexPath: IndexPath) -> C.Model {
        return fetchedResultsController.object(at: indexPath)
    }
    
    // MARK: - UITableViewDataSource
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections, !sections.isEmpty else { return 0 }
        return sections[section].numberOfObjects
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: C.identifier, for: indexPath) as! C
        cell.configure(model: object)
        return cell as! UITableViewCell
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let indexPath = newIndexPath else { fatalError("Index path should be not nil") }
            tableView.insertRows(at: [indexPath], with: .fade)
        case .update:
            guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
            let object = objectAtIndexPath(indexPath)
            guard let cell = tableView.cellForRow(at: indexPath) as? C else { break }
            cell.configure(model: object)
        case .move:
            guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
            guard let newIndexPath = newIndexPath else { fatalError("New index path should be not nil") }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
            tableView.deleteRows(at: [indexPath], with: .fade)
        @unknown default: break
        }
        tableView.reloadData()
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // MARK: - Private
    
    /**
     
     The UITableView whose data source is managed by this class.
     
     */
    private var tableView: UITableView!
    
    /**
     
     A NSFetchedResultsController that forwards changes in the model to the table view.
     
     */
    private var fetchedResultsController: NSFetchedResultsController<C.Model>!
}
