//  ToastManager.swift

import UIKit
import PinLayout

public class ToastManager {
  
  public static var shared = ToastManager()
  
  private init() {}
  
  private var windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
  private var toastBaseView: ToastView?
  
  public func showToast(
    message: String,
    image: UIImage? = nil,
    design: ToastDesign = ToastDesign(),
    layout: ToastLayout = ToastLayout(),
    animation: ToastAnimation = ToastAnimation(),
    direction: ToastDirection = .BottomToTop,
    isAutoHidden: Bool = true
  ) {
    toastBaseView = ToastView(design: design, layout: layout, animation: animation, direction: direction)
    
    
    if let windowScene = windowScene,
       let window = windowScene.windows.first,
       let toastBaseView {
        addGestureRecognizers(at: toastBaseView)
        window.addSubview(toastBaseView)
        toastBaseView.alpha = 0.0
        switch direction {
        case .BottomToTop:
          toastBaseView.pin
            .bottom(window.pin.safeArea)
            .horizontally(toastBaseView.layout.toastHorizontalMargin)
        case .TopToBottom:
          toastBaseView.pin
            .top(window.pin.safeArea)
            .horizontally(toastBaseView.layout.toastHorizontalMargin)
        }
      
      if let toastImage = image {
        makeToastContents(
          toastView: toastBaseView,
          image: toastImage,
          message: message
        )
      } else {
        makeToastContents(
          toastView: toastBaseView,
          message: message
        )
      }
      
      window.bringSubviewToFront(toastBaseView)
      
      showAnimation(
        at: window,
        with: toastBaseView,
        layout: layout,
        animation: animation,
        direction: direction
      )
    }
  }
  
  private func makeToastContents(
    toastView: ToastView,
    message: String
  ) {
    let toastLabel: UILabel = {
      let label = UILabel()
      label.text = message
      label.font = toastView.design.textFont
      label.textColor = toastView.design.textColor
      label.numberOfLines = 0
      label.lineBreakMode = .byCharWrapping
      return label
    }()
    
    toastView.addSubview(toastLabel)
    toastLabel.pin
      .horizontally(toastView.layout.contentsHorizontalMargin)
      .sizeToFit(.width)
    
    toastView.pin.wrapContent(.vertically, padding: toastView.layout.contentsVerticalMargin)
  }
  
  private func makeToastContents(
    toastView: ToastView,
    image: UIImage,
    message: String
  ) {
    let toastImage: UIImageView = {
      let imageView = UIImageView()
      imageView.image = image
      imageView.contentMode = .scaleAspectFit
      return imageView
    }()
    
    let toastLabel: UILabel = {
      let label = UILabel()
      label.text = message
      label.font = toastView.design.textFont
      label.textColor = toastView.design.textColor
      label.numberOfLines = 0
      label.lineBreakMode = .byCharWrapping
      return label
    }()
    
    toastView.addSubview(toastImage)
    toastView.addSubview(toastLabel)
    
    toastImage.pin
      .topLeft(toastView.layout.contentsHorizontalMargin)
      .size(toastView.layout.imageSize ?? .zero)
    
    toastLabel.pin
      .after(of: toastImage, aligned: .center)
      .right(toastView.layout.contentsHorizontalMargin)
      .sizeToFit(.width)
      .marginLeft(toastView.layout.imageLabelOffset)
    
    toastView.pin.wrapContent(.vertically, padding: toastView.layout.contentsVerticalMargin)
  }
  
  private func showAnimation(
    at window: UIWindow,
    with toastView: ToastView,
    layout: ToastLayout,
    animation: ToastAnimation,
    direction: ToastDirection
  ) {
    ThreadChecker.check {
      UIView.animate(
        withDuration: animation.showDuringTime,
        delay: 0.0,
        options: animation.showAnimation
      ) {
        toastView.alpha = 1.0
        
        switch direction {
        case .BottomToTop:
          toastView.pin
            .bottom(window.pin.safeArea)
            .horizontally(layout.toastHorizontalMargin)
            .marginBottom(layout.toastOffset)
        case .TopToBottom:
          toastView.pin
            .top(window.pin.safeArea)
            .horizontally(layout.toastHorizontalMargin)
            .marginTop(layout.toastOffset)
        }
      } completion: { _ in
        DispatchQueue.main.asyncAfter(deadline: .now() + animation.waitTime) { [weak self] in
          self?.hideAnimation(
            at: window,
            with: toastView,
            layout: layout,
            animation: animation,
            direction: direction
          )
        }
      }
    }
  }
  
  private func hideAnimation(
    at window: UIWindow,
    with toastView: ToastView,
    layout: ToastLayout,
    animation: ToastAnimation,
    direction: ToastDirection
  ) {
    
    UIView.animate(
      withDuration: animation.hideDuringTime,
      delay: 0.0,
      options: animation.hideAnimation
    ) {
      toastView.alpha = 0.0
      
      switch direction {
      case .BottomToTop:
        toastView.pin
          .bottom(window.pin.safeArea)
          .horizontally(layout.toastHorizontalMargin)
      case .TopToBottom:
        toastView.pin
          .top(window.pin.safeArea)
          .horizontally(layout.toastHorizontalMargin)
      }
    } completion: { [weak self] _ in
      toastView.animation.completion?()
      toastView.removeFromSuperview()
      self?.removeGestures()
      self?.toastBaseView = nil
    }
  }
}

extension ToastManager {
  private func addGestureRecognizers(at toastView: ToastView) {
    // Add Tap Gesture Recognizer
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    toastView.addGestureRecognizer(tapGesture)
    
    // Add Swipe Gesture Recognizer
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
    swipeGesture.direction = .up // You can change the direction as per your requirement
    toastView.addGestureRecognizer(swipeGesture)
  }
  
  @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
    // Handle tap gesture here
    if gesture.state == .ended {
      if let windowScene,
         let window = windowScene.windows.first,
         let toastBaseView {
        self.hideAnimation(
          at: window,
          with: toastBaseView,
          layout: toastBaseView.layout,
          animation: toastBaseView.animation,
          direction: toastBaseView.direction
        )
      }
    }
  }
  
  @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
    // Handle swipe gesture here
    if gesture.state == .ended {
      // Perform your desired action
      if let windowScene,
         let window = windowScene.windows.first,
         let toastBaseView {
        self.hideAnimation(
          at: window,
          with: toastBaseView,
          layout: toastBaseView.layout,
          animation: toastBaseView.animation,
          direction: toastBaseView.direction
        )
      }
    }
  }
  
  private func removeGestures() {
    if let toastBaseView,
       let tapGesture = toastBaseView.gestureRecognizers?.first(where: { $0 is UITapGestureRecognizer }) {
      toastBaseView.removeGestureRecognizer(tapGesture)
    }
    
    if let toastBaseView,
       let swipeGesture = toastBaseView.gestureRecognizers?.first(where: { $0 is UISwipeGestureRecognizer }) {
      toastBaseView.removeGestureRecognizer(swipeGesture)
    }
            
            
  }
}
