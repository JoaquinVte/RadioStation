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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setTitle(title : String)  {
        lblTitle.text=title
    }
}
