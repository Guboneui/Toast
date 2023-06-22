//  ToastView.swift

import UIKit

public protocol ToastInterface {
  var design: ToastDesign { get set }
  var layout: ToastLayout { get set }
  var animation: ToastAnimation { get set }
  var direction: ToastDirection { get set }
}

public class ToastView: UIView, ToastInterface {
  public var design: ToastDesign
  public var layout: ToastLayout
  public var animation: ToastAnimation
  public var direction: ToastDirection
  
  public init(design: ToastDesign, layout: ToastLayout, animation: ToastAnimation, direction: ToastDirection) {
    self.design = design
    self.layout = layout
    self.animation = animation
    self.direction = direction
    super.init(frame: .zero)
    self.backgroundColor = design.bgColor
    self.layer.masksToBounds = true
    self.layer.cornerRadius = design.cornerRadius
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
