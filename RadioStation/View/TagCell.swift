//
//  TagCell.swift
//  RadioStation
//
//  Created by Joaquin on 6/5/21.
//

import UIKit

class TagCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblInitial: UILabel!
    @IBOutlet weak var lblCantidad: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setTag(tag : Tag)  {
        // let newString = aString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        lblTitle.text=tag.name
        lblInitial.text = String(Array(tag.name)[0]).uppercased()
        lblCantidad.text = "Nº Estaciones: \(tag.stationcount)"
    }
}
