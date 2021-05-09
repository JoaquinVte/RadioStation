//
//  RadioAPI.swift
//  RadioStation
//
//  Created by Joaquin on 7/5/21.
//

import Foundation

enum RadioAPI {
    static let BaseURL = "https://de1.api.radio-browser.info/"
    static let Format = "json"
    
    static let TagsURL = "\(BaseURL)\(Format)/tags"
    static let StationsByTagURL = "\(BaseURL)\(Format)/stations/bytag/"
    
    static func getTags(onComplete: @escaping (([Tag])->Void)){
        guard let url = URL(string: TagsURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            guard let data = data else { return }
            
            guard let tags = try? JSONDecoder().decode([Tag].self, from: data) else { return }
            onComplete(tags)
            
        }.resume()
    }
    
    static func getStationsByTag(tagName: String, onComplete: @escaping (([Station])->Void)){
        
        //print(StationsByTagExactURL + tag)
        
        guard let url = URL(string: (StationsByTagURL + tagName).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed )!) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            guard let data = data else { return }
            
            guard let stations = try? JSONDecoder().decode([Station].self, from: data) else {return}
            onComplete(stations)
            
        }.resume()
    }
    
}

struct Tag : Decodable {
    let name: String
    let stationcount: Int
}

struct Station : Decodable {
    let name: String
    let url_resolved: String
    let favicon: String
}
