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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "swoosh", let model = sender as? Model, let dest = segue.destination as? AVPlayerViewController {
            dest.player = AVPlayer(url: model.slides)
        }
    }
}
