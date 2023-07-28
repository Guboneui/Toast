//  ToastManager.swift

import UIKit

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
    direction: ToastDirection = .bottomToTop,
    addHideGesture: Bool = false
  ) {
    
    toastBaseView = ToastView(
      design: design,
      layout: layout,
      animation: animation,
      direction: direction
    )
    
    if let windowScene = windowScene,
       let window = windowScene.windows.first,
       let toastBaseView {
      
      if addHideGesture { addGestureRecognizers(at: toastBaseView) }
      if animation.addAlphaEffect { toastBaseView.alpha = 0.0 }
      
      setupToastLayout(
        at: window,
        toastView: toastBaseView,
        direction: direction,
        horizontalMargin: toastBaseView.layout.toastHorizontalMargin
      )
      
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
      
      showAnimation(
        at: window,
        with: toastBaseView,
        layout: layout,
        animation: animation,
        direction: direction
      )
    }
  }
  
  private func setupToastLayout(
    at window: UIWindow,
    toastView: ToastView,
    direction: ToastDirection,
    horizontalMargin: CGFloat
  ) {
    
    window.addSubview(toastView)
    switch direction {
    case .bottomToTop:
      let horizontalMargin: CGFloat = toastView.layout.toastHorizontalMargin
      NSLayoutConstraint.activate([
        toastView.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor),
        toastView.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: horizontalMargin),
        toastView.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -horizontalMargin)
      ])
    case .topToBottom:
      let horizontalMargin: CGFloat = toastView.layout.toastHorizontalMargin
      NSLayoutConstraint.activate([
        toastView.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor),
        toastView.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: horizontalMargin),
        toastView.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -horizontalMargin)
      ])
    }
    window.bringSubviewToFront(toastView)
  }
  
  private func makeToastContents(
    toastView: ToastView,
    message: String
  ) {
    let toastLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.text = message
      label.font = toastView.design.textFont
      label.textColor = toastView.design.textColor
      label.numberOfLines = 0
      label.textAlignment = toastView.design.textAlignment
      label.lineBreakMode = .byCharWrapping
      return label
    }()
    
    let horizontalMargin: CGFloat = toastView.layout.contentsHorizontalMargin
    let verticalMargin: CGFloat = toastView.layout.contentsVerticalMargin
    
    toastView.addSubview(toastLabel)
    
    NSLayoutConstraint.activate([
      toastLabel.topAnchor.constraint(equalTo: toastView.topAnchor, constant: verticalMargin),
      toastLabel.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: horizontalMargin),
      toastLabel.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -horizontalMargin),
      toastLabel.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -verticalMargin)
    ])
  }
  
  private func makeToastContents(
    toastView: ToastView,
    image: UIImage,
    message: String
  ) {
    let toastImage: UIImageView = {
      let imageView = UIImageView()
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.image = image
      imageView.contentMode = .scaleAspectFit
      return imageView
    }()
    
    let toastLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.text = message
      label.font = toastView.design.textFont
      label.textColor = toastView.design.textColor
      label.numberOfLines = 0
      label.lineBreakMode = .byCharWrapping
      return label
    }()
    
    let horizontalMargin: CGFloat = toastView.layout.contentsHorizontalMargin
    let verticalMargin: CGFloat = toastView.layout.contentsVerticalMargin
    let imageLabelOffset: CGFloat = toastView.layout.imageLabelOffset
    let imageSize: CGSize = toastView.layout.imageSize ?? .zero
    
    toastView.addSubview(toastImage)
    toastView.addSubview(toastLabel)
    
    NSLayoutConstraint.activate([
      toastImage.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: horizontalMargin),
      toastImage.centerYAnchor.constraint(equalTo: toastView.centerYAnchor),
      toastImage.widthAnchor.constraint(equalToConstant: imageSize.width),
      toastImage.heightAnchor.constraint(equalToConstant: imageSize.height),
      
      toastLabel.centerYAnchor.constraint(equalTo: toastImage.centerYAnchor),
      toastLabel.leadingAnchor.constraint(equalTo: toastImage.trailingAnchor, constant: imageLabelOffset),
      toastLabel.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -horizontalMargin)
    ])
    
    toastView.layoutIfNeeded()
    
    let toastLabelHeight: CGFloat = toastLabel.frame.height
    let toastImageHeight: CGFloat = toastImage.frame.height
    
    if toastLabelHeight >= toastImageHeight {
      NSLayoutConstraint.activate([
        toastLabel.topAnchor.constraint(equalTo: toastView.topAnchor, constant: verticalMargin),
        toastLabel.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -verticalMargin)
      ])
    } else {
      NSLayoutConstraint.activate([
        toastImage.topAnchor.constraint(equalTo: toastView.topAnchor, constant: verticalMargin),
        toastImage.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -verticalMargin)
      ])
    }
  }
}

// MARK: - Toast Animation
extension ToastManager {
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
        if animation.addAlphaEffect { toastView.alpha = 1.0 }
        
        switch direction {
        case .bottomToTop:
          toastView.transform = CGAffineTransform(translationX: 0, y: -layout.toastOffset)
        case .topToBottom:
          toastView.transform = CGAffineTransform(translationX: 0, y: layout.toastOffset)
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
    ThreadChecker.check {
      UIView.animate(
        withDuration: animation.hideDuringTime,
        delay: 0.0,
        options: animation.hideAnimation
      ) {
        if animation.addAlphaEffect { toastView.alpha = 0.0 }

        switch direction {
        case .bottomToTop, .topToBottom:
          toastView.transform = .identity
        }
      } completion: { [weak self] _ in
        toastView.animation.completion?()
        toastView.removeFromSuperview()
        self?.removeGestures()
        self?.toastBaseView = nil
      }
    }
  }
}

// MARK: - Toast Gestures
extension ToastManager {
  private func addGestureRecognizers(at toastView: ToastView) {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    toastView.addGestureRecognizer(tapGesture)
    
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
    swipeGesture.direction = .up // You can change the direction as per your requirement
    toastView.addGestureRecognizer(swipeGesture)
  }
  
  @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
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
