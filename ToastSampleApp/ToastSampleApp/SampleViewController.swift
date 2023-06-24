//
//  SampleViewController.swift
//  ToastSampleApp
//
//  Created by 구본의 on 2023/06/23.
//

import UIKit
import Toast
import PinLayout

class SampleViewController: UIViewController {
  
  private let type: ToastCategory
  private let customDesign: ToastDesign = ToastDesign(
    bgColor: .green.withAlphaComponent(0.8),
    textColor: .blue,
    textAlignment: .center,
    textFont: UIFont.systemFont(ofSize: 24, weight: .bold),
    cornerRadius: 0
  )
  
  private let customLayout: ToastLayout = ToastLayout(
    imageSize: CGSize(width: 40, height: 40),
        imageLabelOffset: 0,
        toastOffset: 24,
        toastHorizontalMargin: 40.0,
        contentsHorizontalMargin: 0.0,
        contentsVerticalMargin: 0.0
  )
  
  private lazy var customAnimation: ToastAnimation = ToastAnimation(
    showDuringTime: 1.0,
    showAnimation: .curveEaseInOut,
    hideDuringTime: 1.0,
    hideAnimation: .curveEaseInOut,
    completion: toastCompletion
  )
  
  private func toastCompletion() {
    print("🍞 Toast Completion")
  }
  
  init(type: ToastCategory) {
    self.type = type
    super.init(nibName: nil, bundle: nil)
  }
  
  private let bottomButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Bottom", for: .normal)
    button.backgroundColor = .lightGray
    button.tintColor = .darkText
    return button
  }()
  
  private let topButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Top", for: .normal)
    button.backgroundColor = .lightGray
    button.tintColor = .darkText
    return button
  }()
  
  private lazy var stackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [bottomButton, topButton])
    view.axis = .horizontal
    view.distribution = .fillEqually
    view.spacing = 20
    return view
  }()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.setupViews()
    self.setupGestures()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.setupLayouts()
  }
  
  
  private func setupViews() {
    self.view.addSubview(stackView)
  }
  
  private func setupLayouts() {
    stackView.pin
      .vCenter()
      .horizontally(20)
      .height(60)
  }
  
  private func setupGestures() {
    bottomButton.addTarget(self, action: #selector(bottomButtonAction), for: .touchUpInside)
    topButton.addTarget(self, action: #selector(topButtonAction), for: .touchUpInside)
  }
  
  @objc private func bottomButtonAction() {
    self.bottomToast()
  }
  
  @objc private func topButtonAction() {
    self.topToast()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SampleViewController {
  private func bottomToast() {
    switch type {
    case .DefaultToast:
      // direction의 기본값은 `BottomToTop`입니다.
      Toast.showToast(
        message: "BottomToTop Default Toast",
        direction: .BottomToTop
      )
    case .ToastWithImageView:
      Toast.showToast(
        message: "Toast With Image",
        image: UIImage(systemName: "heart.fill")!
      )
      
    case .CustomDesign:
      Toast.showToast(
        message: "Toast With Custom Design",
        design: customDesign
      )
      
    case .CustomLayout:
      Toast.showToast(
        message: "Toast With Custom Layout",
        image: UIImage(systemName: "heart.fill")!,
        layout: customLayout
      )
      
    case .CustomAnimation:
      Toast.showToast(
        message: "Toast With Custom Animation",
        animation: customAnimation
      )
    }

    
  }
  
  private func topToast() {
    switch type {
    case .DefaultToast:
      Toast.showToast(
        message: "TopToBottom Default Toast",
        direction: .TopToBottom
      )
    case .ToastWithImageView:
      Toast.showToast(
        message: "Toast With Image",
        image: UIImage(systemName: "heart.fill"),
        direction: .TopToBottom
      )
    case .CustomDesign:
      Toast.showToast(
        message: "Toast With Custom Design",
        design: customDesign,
        direction: .TopToBottom
      )
      
    case .CustomLayout:
      Toast.showToast(
        message: "Toast With Image",
        image: UIImage(systemName: "heart.fill")!,
        layout: customLayout,
        direction: .TopToBottom
      )
      
    case .CustomAnimation:
      Toast.showToast(
        message: "Toast With Custom Animation",
        animation: customAnimation,
        direction: .TopToBottom
      )
    }
  }
}
