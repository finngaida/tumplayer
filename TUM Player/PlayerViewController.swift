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
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resetTimer()
        
        guard let win = UIApplication.shared.keyWindow else { return }
        slider = UISlider(frame: CGRect(x: 20, y: 60, width: win.bounds.width - 40, height: 50))
        slider.minimumValue = 0.0
        slider.maximumValue = 10.0
        slider.value = 1.0
        slider.alpha = 0
        slider.addTarget(self, action: #selector(changeRate(slider:)), for: .valueChanged)
        win.addSubview(slider)
        
        let button = UIButton(frame: self.view.frame)
        button.addTarget(self, action: #selector(showSlider), for: .touchUpInside)
        self.contentOverlayView?.addSubview(button)
    }
    
    func resetTimer() {
        if timer != nil { timer.invalidate() }
        timer = Timer(timeInterval: 3, repeats: false) { _ in self.hideSlider() }
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    func showSlider() {
        
        UIView.animate(withDuration: 0.5) {
            self.slider.alpha = 1
        }
        
        resetTimer()
    }
    
    func hideSlider() {
        UIView.animate(withDuration: 0.5) {
            self.slider.alpha = 0
        }
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        guard let win = UIApplication.shared.keyWindow else { return }
        if toInterfaceOrientation == .landscapeLeft || toInterfaceOrientation == .landscapeRight {
            slider.frame = CGRect(x: 20, y: 40, width: max(win.bounds.width, win.bounds.height) - 40, height: 50)
        } else {
            slider.frame = CGRect(x: 20, y: 60, width: min(win.bounds.width, win.bounds.height) - 40, height: 50)
        }
        showSlider()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showSlider()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideSlider()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.slider.removeFromSuperview()
    }
    
    func changeRate(slider: UISlider) {
        self.player?.rate = slider.value
        resetTimer()
    }

}
