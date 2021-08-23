//
//  UIImageView+zoom.swift
//  test1
//
//  Created by 장진혁 on 2021/08/22.
//

import UIKit

extension UIImageView {
  
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }

  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
    
    if scale.a < 1.1 {
      ListHelper.shared.isZoom = false
    } else {
      ListHelper.shared.isZoom = true
    }
  }
}
