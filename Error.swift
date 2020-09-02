//
//  Error.swift
//  LabStreamingLayer
//
//  Created by Maximilian Kraus on 18.12.19.
//  Copyright © 2019 Maximilian Kraus. All rights reserved.
//

import Foundation

enum Error: Int32, Swift.Error {
  case none = 0
  case timeout = -1
  case lost = -2
  case argument = -3
  case `internal` = -4
  
  
  init(code: lsl_error_code_t) {
    self.init(rawValue: code.rawValue)!
  }
}
