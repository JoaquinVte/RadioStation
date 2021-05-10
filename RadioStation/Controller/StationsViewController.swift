//
//  StationsViewController.swift
//  RadioStation
//
//  Created by Joaquin on 7/5/21.
//

import UIKit

class StationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tagSelected : Tag?
    
    var tempStations : [Station] = []
    
    func fillStations(stations : [Station])->Void {
        for station in stations {
            tempStations.append(station)
        }
        DispatchQueue.main.async {
            self.tableViewStations.reloadData()
        }
    }

    @IBOutlet weak var tableViewStations: UITableView!
    @IBOutlet weak var niStations: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if(tagSelected != nil){
            niStations.title = tagSelected?.name ?? "desconocido"
            
            RadioAPI.getStationsByTag(tagName: niStations.title!, onComplete: fillStations)
        } else {
            niStations.prompt = "Favoritos"
        }
        
        tableViewStations.register(UINib(nibName: "StationCell", bundle:nil), forCellReuseIdentifier:"StationCell")
        
        let width = tableViewStations.frame.size.width
        let height = tableViewStations.frame.size.height
        
        let imgView = UIImageView(frame: CGRect(x: 0,y: 0,width: width,height: height))
        let img = UIImage.init(named: "bg")
                
        imgView.image = img
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        
        tableViewStations.backgroundView = imgView
    }
    
    func changeFavouriteStations() -> Void {
        if tagSelected == nil {
            tempStations = DirbleAPI.fetchFavouriteStations()!
        
            DispatchQueue.main.async {
                self.tableViewStations.reloadData()
            }
        }
    }
    
    
    // MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tempStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell( withIdentifier: "StationCell", for: indexPath) as! StationCell
                 
        cell.setStation(station: tempStations[indexPath.row])
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
    
    //  MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath,animated:true);
         
        performSegue(withIdentifier: "showPlayer", sender: tempStations[indexPath.row])
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showPlayer" , let playerVC = segue.destination as? RadioPlayerViewController {
            guard let selectedStation = sender as? Station else { return }
            playerVC.station = selectedStation
            playerVC.stationsChangeHandler = changeFavouriteStations
        }
    }


}


