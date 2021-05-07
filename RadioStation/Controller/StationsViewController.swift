//
//  StationsViewController.swift
//  RadioStation
//
//  Created by Joaquin on 7/5/21.
//

import UIKit

class StationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tagSelected : String!
    
    var tempStations : [String] = []
    
    func fillStations(stations : [String])->Void {
        for station in stations {
            tempStations.append(station)
        }
        DispatchQueue.main.async {
            self.tableViewStations.reloadData()
        }
    }

    @IBOutlet weak var tableViewStations: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        RadioAPI.getStationsByTag(tag: tagSelected, onComplete: fillStations)
        
        tableViewStations.register(UINib(nibName: "StationCell", bundle:nil), forCellReuseIdentifier:"StationCell")
        
        let width = tableViewStations.frame.size.width
        let height = tableViewStations.frame.size.height
        
        let imgView = UIImageView(frame: CGRect(x: 0,y: 0,width: width,height: height))
        let img = UIImage.init(named: "bg")
                
        imgView.image = img
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        
        tableViewStations.backgroundView = imgView
    }
    
    
    // MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tempStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell( withIdentifier: "StationCell", for: indexPath) as! StationCell
                 
        cell.setStationName(name: tempStations[indexPath.row])
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
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


