//  ToastAnimation.swift

import UIKit

public struct ToastAnimation {
  let showDuringTime: TimeInterval
  let showAnimation: UIView.AnimationOptions
  let waitTime: TimeInterval
  let hideDuringTime: TimeInterval
  let hideAnimation: UIView.AnimationOptions
  let addAlphaEffect: Bool
  var completion: (()->())?
  
  public init(
    showDuringTime: TimeInterval = 0.3,
    showAnimation: UIView.AnimationOptions = .curveEaseIn,
    waitTime: TimeInterval = 1.7,
    hideDuringTime: TimeInterval = 0.3,
    hideAnimation: UIView.AnimationOptions = .curveEaseOut,
    addAlphaEffect: Bool = true,
    completion: (()->())? = nil
  ) {
    self.showDuringTime = showDuringTime
    self.showAnimation = showAnimation
    self.waitTime = waitTime
    self.hideDuringTime = hideDuringTime
    self.hideAnimation = hideAnimation
    self.addAlphaEffect = addAlphaEffect
    self.completion = completion
  }
}
