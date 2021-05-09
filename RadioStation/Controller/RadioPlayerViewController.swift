//
//  RadioPlayerViewController.swift
//  RadioStation
//
//  Created by Joaquin on 8/5/21.
//

import UIKit
import AVKit
import CoreData

class RadioPlayerViewController: UIViewController {
    
    
    @IBOutlet weak var imageStation: UIImageView!
    @IBOutlet weak var playStopButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var niStation: UINavigationItem!
    
    var station : Station!
    var isFavourite : FavState!
    
    lazy var player: AVPlayer = {
        initAudioSession()
        return AVPlayer()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       setupView()
        
    }
    
    func setupView(){
        
        niStation.title = station.name
        imageStation.imageFromURL(url: station?.favicon ?? "", defaultImage: "radio-station")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StationEntity")
        let namePredicate = NSPredicate(format: "name == %@", station.name)
        let isFavPredicate = NSPredicate(format: "isFavourite == %@", NSNumber(booleanLiteral: true))
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [namePredicate,isFavPredicate])
        fetchRequest.predicate = compoundPredicate
        
        do{
            let count = try context.count(for: fetchRequest)
            if count == 1 {
                updateFavourteUI(for: .favourite)
                self.isFavourite = .favourite
            } else {
                self.isFavourite = .notFavourite
            }
        } catch let error {
            print(error)
        }
        
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
        switch isFavourite {
        case .favourite:
            removeFromFavourites()
        default :
            addToFavourites()
        }

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
    func updateFavourteUI(for state: FavState){
        switch state {
        case .favourite:           
            UIView.transition(with: favButton, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
                self.favButton.setBackgroundImage(UIImage(named: "fav-del"), for: .normal)
            }, completion: nil)
        case .notFavourite:
            UIView.transition(with: favButton, duration: 0.5, options: [.transitionFlipFromRight], animations: {
                self.favButton.setBackgroundImage(UIImage(named: "fav-add"), for: .normal)
            }, completion: nil)
        }
    }
    func addToFavourites(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "StationEntity", in: context)!
        let stationRecord = NSManagedObject(entity: entity, insertInto: context)
        
        stationRecord.setValue(self.station.name, forKey: "name")
        stationRecord.setValue(self.station.favicon, forKey: "imageURL")
        stationRecord.setValue(self.station.url_resolved, forKey: "streamURL")
        stationRecord.setValue(true, forKey: "isFavourite")
        
        appDelegate.saveContext()
        updateFavourteUI(for: .favourite)
        self.isFavourite = .favourite
    }
    func removeFromFavourites(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StationEntity")
        fetchRequest.predicate = NSPredicate(format: "name == %@", station.name)
        fetchRequest.fetchLimit = 1
        
        do{
            let record = try context.fetch(fetchRequest)
            record.first?.setValue(NSNumber(booleanLiteral: false), forKey: "isFavourite")
            
            appDelegate.saveContext()
            
            self.isFavourite = .notFavourite
            updateFavourteUI(for: .notFavourite)
        } catch let error {
            print(error)
        }
    }
}

enum PlayerState {
    case playing, paused
}
enum FavState {
    case favourite, notFavourite
}
