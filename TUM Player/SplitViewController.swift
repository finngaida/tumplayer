//
//  SplitViewController.swift
//  TUM Player
//
//  Created by Finn Gaida on 02/02/2017.
//
//

import UIKit
import AVKit
import AVFoundation

class SplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(forName: Notifications.tapped, object: nil, queue: nil) { (notification) in
            guard let model = notification.object as? Model else { return print("damn") }
//            guard let detail = self.viewControllers.last as? DetailViewController else { return print("wow") }
            
//            _ = detail.navigationController?.popToRootViewController(animated: true)
//            detail.performSegue(withIdentifier: "swoosh", sender: model)
            
            let playVC = AVPlayerViewController()
            playVC.player = AVPlayer(url: model.slides)
            self.viewControllers[1] = playVC
            playVC.player?.play()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
