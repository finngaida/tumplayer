//
//  DetailViewController.swift
//  TUM Player
//
//  Created by Finn Gaida on 01/02/2017.
//
//

import UIKit
import AVKit
import AVFoundation

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: Notifications.tapped, object: nil, queue: nil) { (notification) in
            guard let model = notification.object as? Model else { return print("damn") }
            
            _ = self.navigationController?.popToRootViewController(animated: true)
            self.performSegue(withIdentifier: "swoosh", sender: model)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "swoosh", let model = sender as? Model, let dest = segue.destination as? AVPlayerViewController {
            dest.player = AVPlayer(url: model.slides)
        }
    }
}
