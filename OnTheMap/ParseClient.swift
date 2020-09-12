//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Haoran Li on 2020-09-11.
//  Copyright © 2020 Haoran Li. All rights reserved.
//

import UIKit

class ParseClient: NSObject {
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1/StudentLocation"
        
        case getLocationsWithLimit(Int)
        case getLocationsSkipping(Int, Int)
        case getLocationsSorted(String)
        case getLocationsUniqueKey(Int)
        
        var stringValue: String {
            switch self {
            case .getLocationsWithLimit(let limit):
                return Endpoints.base + "?limit=\(limit)"
            case .getLocationsSkipping(let limit, let skip):
                return Endpoints.base + "?limit=\(limit)&skip=\(skip)"
            case .getLocationsSorted(let by):
                return Endpoints.base + "?order=-\(by)"
            case .getLocationsUniqueKey(let key):
                return Endpoints.base + "?uniqueKey=\(key)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    
    class func taskForGETRequest<ResponseType: Decodable> (url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask{
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
        return task
        
    }
    
    class func downloadMostRecent100Locations(completion: @escaping ([UserLocation]?, Error?) -> Void) {
        self.taskForGETRequest(url: Endpoints.getLocationsSorted("updatedAt").url, responseType: WrapperUserLocation.self) {
            (response, error) in
            if let response = response {
                completion(Array(response.results[0...99]), nil)
            } else {
                completion(nil, error)
            }
            
        }
    }
        
}
