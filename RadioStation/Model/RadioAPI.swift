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
    static let StationsByTagExactURL = "\(BaseURL)\(Format)/stations/bytagexact/"
    
    static func getTags(onComplete: @escaping (([String])->Void)){
        guard let url = URL(string: TagsURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            guard let data = data else { return }
            do {
                guard let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] else { return }
                
                guard let jsonArray = jsonResponse as? [[String: Any]] else { return }
                
                var tags = [String]()
                for object in jsonArray {
                    guard let name = object["name"] as? String else { return }
                    tags.append(name)
                }
                onComplete(tags)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    static func getStationsByTag(tag: String, onComplete: @escaping (([String])->Void)){
        
        //print(StationsByTagExactURL + tag)
        
        guard let url = URL(string: StationsByTagExactURL + tag) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            guard let data = data else { return }
            do {
                guard let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] else { return }
                
                guard let jsonArray = jsonResponse as? [[String: Any]] else { return }
                
                var stations = [String]()
                for object in jsonArray {
                    guard let name = object["name"] as? String else { return }
                    stations.append(name)
                }
                onComplete(stations)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
}
