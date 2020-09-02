//
//  Outlet.swift
//  LabStreamingLayer
//
//  Created by Maximilian Kraus on 16.01.20.
//  Copyright © 2020 Maximilian Kraus. All rights reserved.
//

import Foundation

public class Outlet {
  let base: lsl_outlet
  let streamInfo: StreamInfo
  
  
  public init(streamInfo: StreamInfo) {
    self.streamInfo = streamInfo
    self.base = lsl_create_outlet(streamInfo.base, 0, 1)
  }
}


extension Outlet {
  public var hasConsumers: Bool {
    lsl_have_consumers(base) > 0
  }
  
  public func push(data: String) throws {
    guard streamInfo.channelFormat == .string else { throw Error.argument }
    
    let errorCode = lsl_push_sample_c(base, data)
    if errorCode != 0 {
      throw Error(rawValue: errorCode)!
    }
  }
}
