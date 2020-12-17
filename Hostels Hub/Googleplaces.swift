//
//  Googleplaces.swift
//  Hostels Hub
//
//  Created by Apple on 14/10/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
class Googleplaces {

    func getHostels(placename : String, completion: @escaping (Bool ,[HostelsModel]) -> ()) {
        
        let  placenameforearch = "Boys hostel \(placename)"
        var hostelsarr = [HostelsModel]()
        let googleplacesapikey = Constants.shared.gmsAPIkey
        
        var str = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(placenameforearch)&key=\(googleplacesapikey)"
        print(str)
        str = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: "\(str)") else {
            completion(false,[])
            return}
        print("")
       
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    completion(false,[])
                    return }
            print("Data Response: ")
            print(dataResponse)
            do {
                if let json = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? NSDictionary {
                    if let results = json["results"] as? NSArray {
                        
                        print(results)
                        var addressArr = [String]()
                        var nameArr = [String]()
                        
                        
                        var i = 0
                        for place in results {
                            
                            let obj = place as! NSDictionary
                            let name = obj["name"] as? String
                            let rating = obj["rating"] as? Double
                            let address = obj["formatted_address"] as? String  ?? ""
                            let comb = name! + ", " + address
                            let placeid = obj["place_id"] as? String
                            
                            let geometry =  obj["geometry"] as! NSDictionary
                            let geometrylocatiojn =  geometry["location"] as! NSDictionary
                            
                            let lat = geometrylocatiojn["lat"] as? Double
                            let lng = geometrylocatiojn["lng"] as? Double
                            
                            var placeObj = HostelsModel()
                            
                            placeObj.name = name
                            placeObj.address = address
                            placeObj.lat = lat
                            placeObj.lng = lng
                            placeObj.placeid = placeid
                            placeObj.rating = "\(rating!)"
                            
                            hostelsarr.append(placeObj)
                            
                            print("Lat \(lat)")
                            print("lng \(lng)")
                            
                            print(comb)
                            nameArr.append(name!)
                            addressArr.append(comb)
                            
                            
                        }
                        
                        
                        
                        completion(true,hostelsarr)
                    }
                }
                
                
            } catch let parsingError {
                print("Error", parsingError)
                completion(false,[])
            }
        }
        task.resume()

    }

}
