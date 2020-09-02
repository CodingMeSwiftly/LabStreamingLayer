//
//  Inlet.swift
//  LabStreamingLayer
//
//  Created by Maximilian Kraus on 17.12.19.
//  Copyright © 2019 Maximilian Kraus. All rights reserved.
//

import Foundation

public class Inlet {
  let base: lsl_inlet
  let streamInfo: StreamInfo
  private var fullInfo: StreamInfo?
  private var _streamInfo: StreamInfo { fullInfo ?? streamInfo }
  
  deinit {
    lsl_destroy_inlet(base)
  }
  
  public init(streamInfo: StreamInfo) {
    self.streamInfo = streamInfo
    self.base = lsl_create_inlet(streamInfo.base, 1, LSL_NO_PREFERENCE, 1)
  }
}


//MARK: - Properties
public extension Inlet {
  var numberOfSamplesAvailable: UInt32 {
    lsl_samples_available(base)
  }
}


//MARK: - Operations
public extension Inlet {
  func fullInfo(timeout: TimeInterval = LSL_FOREVER) throws -> StreamInfo {
    var error: Int32 = 0
    let info = lsl_get_fullinfo(base, timeout, &error)
    
    if let info = info {
      return StreamInfo(base: info)
    } else {
      throw Error(rawValue: error)!
    }
  }
  
  func openStream(timeout: TimeInterval = LSL_FOREVER) throws {
    var error: Int32 = 0
    lsl_open_stream(base, timeout, &error)
    
    if error != 0 {
      throw Error(rawValue: error)!
    }
  }
  
  func pullSample(timeout: TimeInterval = LSL_FOREVER) throws -> [Float32] {
    guard streamInfo.channelFormat == .float32 else { throw Error.argument }
    
    var buffer = Array<Float32>(repeating: 0, count: Int(streamInfo.channelCount))
    var error: Int32 = 0
    
    lsl_pull_sample_f(base, &buffer, streamInfo.channelCount, timeout, &error)
    
    if error != 0 {
      throw Error(rawValue: error)!
    }
    
    return buffer
  }
  
  func pullSample(timeout: TimeInterval = LSL_FOREVER) throws -> [Double] {
    guard streamInfo.channelFormat == .double64 else { throw Error.argument }
    
    var buffer = Array<Double>(repeating: 0, count: Int(streamInfo.channelCount))
    var error: Int32 = 0
    
    lsl_pull_sample_d(base, &buffer, streamInfo.channelCount, timeout, &error)
    
    if error != 0 {
      throw Error(rawValue: error)!
    }
    
    return buffer
  }
  
  func pullSample(timeout: TimeInterval = LSL_FOREVER) throws -> [Int32] {
    guard streamInfo.channelFormat == .int32 else { throw Error.argument }
    
    var buffer = Array<Int32>(repeating: 0, count: Int(streamInfo.channelCount))
    var error: Int32 = 0
    
    lsl_pull_sample_i(base, &buffer, streamInfo.channelCount, timeout, &error)
    
    if error != 0 {
      throw Error(rawValue: error)!
    }
    
    return buffer
  }
}
