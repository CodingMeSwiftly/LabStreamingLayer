//
//  ChannelFormat.swift
//  LabStreamingLayer
//
//  Created by Maximilian Kraus on 17.12.19.
//  Copyright © 2019 Maximilian Kraus. All rights reserved.
//

import Foundation

public enum ChannelFormat: UInt32 {
  case float32 = 1
  case double64 = 2
  case string = 3
  case int32 = 4
  case int16 = 5
  case int8 = 6
  case int64 = 7
  case undefined = 0
  
  
  init(format: lsl_channel_format_t) {
    self.init(rawValue: format.rawValue)!
  }
}
