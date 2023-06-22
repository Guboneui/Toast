//  ToastDesign.swift


import UIKit

public struct ToastDesign {
  let bgColor: UIColor
  let textColor: UIColor
  let textFont: UIFont
  let cornerRadius: CGFloat
  public init(
    bgColor: UIColor = UIColor.black,
    textColor: UIColor = UIColor.white,
    textFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium),
    cornerRadius: CGFloat = 4.0
  ) {
    self.bgColor = bgColor
    self.textColor = textColor
    self.textFont = textFont
    self.cornerRadius = cornerRadius
  }
}
