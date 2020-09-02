//
//  Sample.swift
//  LabStreamingLayer
//
//  Created by Maximilian Kraus on 18.12.19.
//  Copyright © 2019 Maximilian Kraus. All rights reserved.
//

import Foundation

public struct Sample<T> {
  public let value: T
  
  init(value: T) {
    self.value = value
  }
}
