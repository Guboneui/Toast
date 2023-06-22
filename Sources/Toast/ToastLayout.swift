//  ToastLayout.swift

import UIKit

public struct ToastLayout {
  var imageSize: CGSize?
  let imageLabelOffset: CGFloat
  let toastOffset: CGFloat
  let toastHorizontalMargin: CGFloat
  let contentsHorizontalMargin: CGFloat
  let contentsVerticalMargin: CGFloat
  
  public init(
    imageSize: CGSize? = CGSize(width: 18, height: 18),
    imageLabelOffset: CGFloat = 8.0,
    toastOffset: CGFloat = 12.0,
    toastHorizontalMargin: CGFloat = 20.0,
    contentsHorizontalMargin: CGFloat = 20.0,
    contentsVerticalMargin: CGFloat = 12.0
  ) {
    self.imageSize = imageSize
    self.imageLabelOffset = imageLabelOffset
    self.toastOffset = toastOffset
    self.toastHorizontalMargin = toastHorizontalMargin
    self.contentsHorizontalMargin = contentsHorizontalMargin
    self.contentsVerticalMargin = contentsVerticalMargin
  }
}

