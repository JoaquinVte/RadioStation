//
//  RadioPlayerViewController.swift
//  RadioStation
//
//  Created by Joaquin on 8/5/21.
//

import UIKit
import AVKit

class RadioPlayerViewController: UIViewController {
    
    
    @IBOutlet weak var imageStation: UIImageView!
    @IBOutlet weak var playStopButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var niStation: UINavigationItem!
    
    var station : Station!
    
    lazy var player: AVPlayer = {
        initAudioSession()
        return AVPlayer()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        niStation.title = station.name
        imageStation.imageFromURL(url: station?.favicon ?? "", defaultImage: "radio-station")
        
    }
    
    @IBAction func playStopButtonPressed(_ sender: UIButton) {
        if(player.isPlaying == .playing){
            pauseStream()
        } else {
            playStream(from: station.url_resolved)
        }
    }
    
    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        changeVolume(value: volumeSlider.value)
    }
    
    @IBAction func favButtonPressed(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AVPlayer {
    var isPlaying : PlayerState {
        if(self.rate != 0 && self.error == nil) {
            print("playing")
            return .playing
        } else {
            print("paused")
            return .paused
        }
    }
}

extension RadioPlayerViewController{
    func initAudioSession() {
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true, options: [])
        }catch let error {
            print(error)
        }
    }
    
    func playStream(from url: String) {
        guard let url = URL(string: url) else { return }
        
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
        player.play()
        
        player.volume = volumeSlider.value
        updatePlayerUI(for: .playing)
    }
    func pauseStream(){
        player.pause()
        updatePlayerUI(for: .paused)
    }
    func changeVolume(value: Float){
        player.volume = volumeSlider.value
    }
    func updatePlayerUI(for state: PlayerState) {
        switch state {
        case .paused:
            playStopButton.setBackgroundImage(UIImage(named: "play-button"), for: .normal)
        case .playing:
            playStopButton.setBackgroundImage(UIImage(named: "pause-button"), for: .normal)
        }
    }
}

enum PlayerState {
    case playing, paused
}
