//
//  Dirble.swift
//  RadioStation
//
//  Created by Joaquin on 9/5/21.
//

import Foundation
import UIKit
import CoreData

enum DirbleAPI {
    static func fetchFavouriteStations() -> [Station]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StationEntity")
        fetchRequest.predicate = NSPredicate(format: "isFavourite == %@", NSNumber(booleanLiteral: true))
        
        var favStations : [Station]? = nil
        do {
            let records = try context.fetch(fetchRequest) as! [StationEntity]
            favStations = records.map {
                (station) -> Station in
                return Station(from: station)
            }
                
        }catch let error {
            print(error)
        }
        
        return favStations
    }
}


