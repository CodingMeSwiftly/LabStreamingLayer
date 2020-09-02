//
//  StreamInfo.swift
//  LabStreamingLayer
//
//  Created by Maximilian Kraus on 17.12.19.
//  Copyright © 2019 Maximilian Kraus. All rights reserved.
//

import Foundation

public class StreamInfo {
  public let base: lsl_streaminfo
  
  deinit {
    lsl_destroy_streaminfo(base)
  }
  
  public init(base: lsl_streaminfo) {
    self.base = base
  }
  
  public init(name: String, format: ChannelFormat, id: String) {
    self.base = lsl_create_streaminfo(name, "", 1, LSL_IRREGULAR_RATE, lsl_channel_format_t(rawValue: format.rawValue), id)
  }
}


extension StreamInfo: CustomDebugStringConvertible {
  public var debugDescription: String {
    "\(name) :: \(type) :: \(sourceId)"
  }
}


public extension StreamInfo {
  var name: String {
    String(cString: lsl_get_name(base))
  }
  
  var type: String {
    String(cString: lsl_get_type(base))
  }
  
  var channelCount: Int32 {
    lsl_get_channel_count(base)
  }
  
  var nominalSamplingRate: Double {
    lsl_get_nominal_srate(base)
  }
  
  var sourceId: String {
    String(cString: lsl_get_source_id(base))
  }
  
  var protocolVersion: Int32 {
    lsl_get_version(base)
  }
  
  var createdAt: Double {
    lsl_get_created_at(base)
  }
  
  var channelFormat: ChannelFormat {
    let raw = lsl_get_channel_format(base).rawValue
    return ChannelFormat(rawValue: raw)!
  }
  
  var numberOfBytesPerSample: Int32 {
    lsl_get_sample_bytes(base)
  }
  
  var numberOfBytesPerChannel: Int32 {
    lsl_get_channel_bytes(base)
  }
}
