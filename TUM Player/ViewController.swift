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

    var module: Module = Module.la
    var data: [Model]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 65, left: 0, bottom: 50, right: 0)
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(chooseSemester(_:)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = module.title()
        
        DispatchQueue.main.async {
            do {
                self.data = try Server.getInfo(for: self.module)
                self.tableView.reloadData()
            } catch let e {
                print("ouch \(e)")
            }
        }
    }
    
    func setSemester(_ i: Int) {
        guard let items = self.tabBarController?.tabBar.items,
            let controllers = self.tabBarController?.viewControllers,
            let first = controllers[0] as? ViewController,
            let second = controllers[1] as? ViewController,
            let third = controllers[2] as? ViewController else { return }
        
        items[0].title = i == 0 ? "DS" : "LA"
        first.module = i == 0 ? .ds : .la
        
        items[1].title = i == 0 ? "PGDP" : "GAD"
        second.module = i == 0 ? .pgdp : .gad
        
        items[2].title = i == 0 ? "ERA" : "EIST"
        third.module = i == 0 ? .era : .eist
        
        self.viewDidAppear(false)
    }
    
    @IBAction func chooseSemester(_ sender: Any) {
        let alert = UIAlertController(title: "Choose a semester", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "First (WS1617)", style: .default, handler: { _ in
            self.setSemester(0)
        }))
        alert.addAction(UIAlertAction(title: "Second (SS17)", style: .default, handler: { _ in
            self.setSemester(1)
        }))
        self.present(alert, animated: true, completion: nil)
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

