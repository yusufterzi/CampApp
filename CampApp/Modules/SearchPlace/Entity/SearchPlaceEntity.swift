//
//  SearchPlaceEntity.swift
//  CampApp
//
//  Created by yusuf terzi on 21.04.2022.
//

import UIKit
import Foundation



struct GooglePlacesResponse : Codable {
  let results : [Place]
  enum CodingKeys : String, CodingKey {
    case results = "results"
  }
}


struct Place : Codable {
  
  let geometry : Location
  let name : String
  let place_id: String
  let openingHours : OpenNow?
  let photos : [PhotoInfo]?
  let types : [String]
  let address : String
  
  
  enum CodingKeys : String, CodingKey {
    case geometry = "geometry"
    case name = "name"
    case place_id = "place_id"
    case openingHours = "opening_hours"
    case photos = "photos"
    case types = "types"
    case address = "vicinity"
  }
  
  
  struct Location : Codable {
    
    let location : LatLong
    
    enum CodingKeys : String, CodingKey {
      case location = "location"
    }
    
    
    struct LatLong : Codable {
      
      let latitude : Double
      let longitude : Double
      
      enum CodingKeys : String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
      }
    }
    
  }
  
  struct OpenNow : Codable {
    
    let isOpen : Bool
    
    enum CodingKeys : String, CodingKey {
      case isOpen = "open_now"
    }
  }
  
  struct PhotoInfo : Codable {
    
    let height : Int
    let width : Int
    let photoReference : String
    
    enum CodingKeys : String, CodingKey {
      case height = "height"
      case width = "width"
      case photoReference = "photo_reference"
    }
  }
}

struct GooglePlacesDetailsResponse : Codable {
  let result : PlaceDetails
  enum CodingKeysDetails : String, CodingKey {
    case result = "result"
  }
}



struct PlaceDetails : Codable {
  
  let place_id: String
  let geometry : Location
  let name : String
  let formatted_address : String
  let photos : [PhotoInfo]?
  
  
  enum CodingKeysDetails : String, CodingKey {
    case place_id = "place_id"
    case geometry = "geometry"
    case name = "name"
    case formatted_address = "formatted_address"
    case photos = "photos"
  }
  
  struct PhotoInfo : Codable {
    
    let height : Int
    let width : Int
    let photoReference : String
    
    enum CodingKeys : String, CodingKey {
      case height = "height"
      case width = "width"
      case photoReference = "photo_reference"
    }
  }
  struct Location : Codable {
    
    let location : LatLong
    
    enum CodingKeys : String, CodingKey {
      case location = "location"
    }
    
    
    struct LatLong : Codable {
      
      let latitude : Double
      let longitude : Double
      
      enum CodingKeys : String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
      }
    }
    
  }
  
}




