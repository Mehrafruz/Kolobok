//
//  UIButtonExtensions.swift
//  WhereGoWithoutSB
//
//  Created by Мехрафруз on 01.03.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

extension UIButton {
  func pulsate() {
      let pulse = CASpringAnimation(keyPath: "transform.scale")
      pulse.duration = 0.6
      pulse.fromValue = 0.95
      pulse.toValue = 1.0
      pulse.autoreverses = true
      pulse.repeatCount = 2
      pulse.initialVelocity = 0.5
      pulse.damping = 1.0
      
      layer.add(pulse, forKey: "pulse")
  }
}
