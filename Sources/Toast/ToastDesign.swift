//  ToastDesign.swift

import UIKit

public struct ToastDesign {
  let bgColor: UIColor
  let textColor: UIColor
  let textFont: UIFont
  let textAlignment: NSTextAlignment
  let cornerRadius: CGFloat
  
  public init(
    bgColor: UIColor = UIColor.black,
    textColor: UIColor = UIColor.white,
    textAlignment: NSTextAlignment = .left,
    textFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium),
    cornerRadius: CGFloat = 4.0
  ) {
    self.bgColor = bgColor
    self.textColor = textColor
    self.textFont = textFont
    self.textAlignment = textAlignment
    self.cornerRadius = cornerRadius
  }
}
