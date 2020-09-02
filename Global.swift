//
//  Global.swift
//  LabStreamingLayer
//
//  Created by Maximilian Kraus on 19.12.19.
//  Copyright © 2019 Maximilian Kraus. All rights reserved.
//

import Foundation

public func resolveAll() -> [StreamInfo] {
  var buffer = Array<lsl_streaminfo?>(repeating: nil, count: 2)
  lsl_resolve_all(&buffer, 2, LSL_FOREVER)
  return buffer.compactMap { $0 }.map(StreamInfo.init)
}

public func resolve(property: String, value: String, min: Int32 = 1) -> [StreamInfo] {
  var buffer = Array<lsl_streaminfo?>(repeating: nil, count: Int(min))
  lsl_resolve_byprop(&buffer, UInt32(buffer.count), property, value, min, LSL_FOREVER)
  return buffer.compactMap { $0 }.map(StreamInfo.init)
}
