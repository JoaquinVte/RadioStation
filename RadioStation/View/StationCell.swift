//
//  StationCell.swift
//  RadioStation
//
//  Created by Joaquin on 7/5/21.
//

import UIKit

class StationCell: UITableViewCell {

    @IBOutlet weak var lblStation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setStationName(name:String){
        lblStation.text=name
    }

}
