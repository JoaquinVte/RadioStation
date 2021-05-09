//
//  RadioPlayerViewController.swift
//  RadioStation
//
//  Created by Joaquin on 8/5/21.
//

import UIKit

class RadioPlayerViewController: UIViewController {
    
    
    @IBOutlet weak var imageStation: UIImageView!
    @IBOutlet weak var playStopButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var niStation: UINavigationItem!
    
    var station : Station!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        niStation.title = station.name
        
    }
    
    @IBAction func playStopButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func volumeSliderChanged(_ sender: UISlider) {
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
