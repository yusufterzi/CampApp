//
//  GenericResult.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import Foundation

public typealias GenericResult<Value> = Result<Value, Error>

public enum CampError: Error {
  case snapshotFailed
  case databaseParseError
  case genericNetworkError
  case genericError
  
  var localizedDescription: String {
    switch self {
    case .genericNetworkError:
      return "Network failed, please try again."
    case .genericError:
      return "Oops, there is a problem. Please try later."
    default:
      return "A problem occured, please try later!"
    }
  }
}

public extension Result {
  
  var isSuccess: Bool {
    switch self {
    case .success:
      return true
    case .failure:
      return false
    }
  }
  
  var value: Success? {
    return try? get()
  }
  
  var error: Failure? {
    switch self {
    case .success:
      return nil
    case .failure(let error):
      return error
    }
  }
}

public extension Result where Success == Void {
  
  static var success: Result<Success, Failure> {
    return Result<Success, Failure>.success(())
  }
}
