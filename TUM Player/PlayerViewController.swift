//
//  PlayerViewController.swift
//  TUM Player
//
//  Created by Finn Gaida on 16.05.17.
//
//

import UIKit
import AVKit
import AVFoundation

class PlayerViewController: AVPlayerViewController {

    var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let win = UIApplication.shared.keyWindow else { return }
        slider = UISlider(frame: CGRect(x: 20, y: 60, width: win.bounds.width - 40, height: 50))
        slider.minimumValue = 0.0
        slider.maximumValue = 10.0
        slider.value = 1.0
        slider.alpha = 0
        slider.addTarget(self, action: #selector(changeRate(slider:)), for: .valueChanged)
        win.addSubview(slider)
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        guard let win = UIApplication.shared.keyWindow else { return }
        if toInterfaceOrientation == .landscapeLeft || toInterfaceOrientation == .landscapeRight {
            slider.frame = CGRect(x: 20, y: 40, width: 50, height: win.bounds.width - 40)
        } else {
            slider.frame = CGRect(x: 20, y: 60, width: win.bounds.width - 40, height: 50)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) { 
            self.slider.alpha = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) { 
            self.slider.alpha = 0
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.slider.removeFromSuperview()
    }
    
    func changeRate(slider: UISlider) {
        self.player?.rate = slider.value
    }

}
