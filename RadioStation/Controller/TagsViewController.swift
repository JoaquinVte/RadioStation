//
//  ViewController.swift
//  RadioStation
//
//  Created by Joaquin on 6/5/21.
//

import UIKit

class TagsViewController: UITableViewController {
    
    var tempTags : [String] = ["Jazz","Blues","Classical","Country"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "TagCell", bundle:nil), forCellReuseIdentifier:"TagCell")
        
        let width = tableView.frame.size.width
        let height = tableView.frame.size.height
        
        let imgView = UIImageView(frame: CGRect(x: 0,y: 0,width: width,height: height))
        let img = UIImage.init(named: "bg")
                
        imgView.image = img
        imgView.contentMode = UIView.ContentMode.scaleAspectFill       
        
        tableView.backgroundView = imgView
        
    }
}

//  MARK: Table view delegate
extension TagsViewController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
      
        tableView.deselectRow(at: indexPath,animated:true);
        
    }
    
}


// MARK: Table view data source
extension TagsViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell( withIdentifier: "TagCell", for: indexPath) as! TagCell
                 
        cell.setTitle(title: tempTags[indexPath.row])
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.clear
        } else {
            cell.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        }
        
        return cell
    }
    
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempTags.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
}




