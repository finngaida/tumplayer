//
//  ViewController.swift
//  TUM Player
//
//  Created by Finn Gaida on 01/02/2017.
//
//

import UIKit

enum Notifications {
    static let tapped = Notification.Name("tapped")
}

class ViewController: UITableViewController {

    var data: [Model]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 65, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            do {
                self.data = try Server.getInfo(for: Module.ds)
                print("got data: \(self.data)")
                self.tableView.reloadData()
            } catch let e {
                print("ouch \(e)")
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let model = data?[indexPath.row] else { return cell }
        
        cell.textLabel?.text = model.name
        cell.detailTextLabel?.text = DateFormatter().string(from: model.date)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let model = data?[indexPath.row] else { return print("oops") }
        NotificationCenter.default.post(name: Notifications.tapped, object: model)
    }

}

