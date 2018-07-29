import UIKit


/**

 A generic tableview data source that works with a ConfigurableCell

 */
class TableViewDataSource<Cell: ConfigurableCell>: NSObject, UITableViewDataSource {
    var data: [Cell.T] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as! Cell
        cell.configure(with: data[indexPath.row] as Cell.T)
        return cell as! UITableViewCell
    }
}
