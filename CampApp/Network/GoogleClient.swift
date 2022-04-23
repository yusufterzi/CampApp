//
//  GoogleClient.swift
//  CampApp
//
//  Created by Nurullah Vural on 23.04.2022.
//
import SwiftUI
import Foundation
import CoreLocation

protocol GoogleClientRequest {
  var googlePlacesKey : String { get set }
  func getGooglePlacesDetailsData(place_id: String, using completionHandler: @escaping (GooglePlacesDetailsResponse?) -> ())
}


final class GoogleClient: GoogleClientRequest {
  
  let session = URLSession(configuration: .default)
  var googlePlacesKey: String = "AIzaSyDfgZ54ZmQdrnCJKL4wz1Se6IhCi0ac1-0"
  
  
  func getGooglePlacesDetailsData(place_id: String, using completionHandler: @escaping (GooglePlacesDetailsResponse?) -> ())  {
    
    let url = googlePlacesDetailsURL(forKey: googlePlacesKey, place_ID: place_id)
    
    let task = session.dataTask(with: url) { (responseData, _, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      guard let data = responseData else {
        print("Could not decode JSON response. responseData was: ", responseData)
        completionHandler(nil)
        return
      }
      // for decode data 
      var string = data.base64EncodedString()
      let detailsResponse = try? JSONDecoder().decode(GooglePlacesDetailsResponse.self, from: data)
      completionHandler(detailsResponse)
      
      
    }
    task.resume()
    
  }
  
  func googlePlacesDetailsURL(forKey apiKey: String, place_ID: String) -> URL {
    print("passed  place_ID  before url creation ", place_ID)
    
    let baseURL = "https://maps.googleapis.com/maps/api/place/details/json?"
    let place_idString = "place_id=" + place_ID
    let fields = "fields=name"
    let key = "key=" + apiKey
    
    print("Details request URL:", URL(string: baseURL + place_idString + "&" + fields + "&" + key)!)
    return URL(string: baseURL + place_idString + "&" + fields + "&" + key)!
  }
  
  
  
}


