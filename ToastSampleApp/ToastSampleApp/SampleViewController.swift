//
//  SampleViewController.swift
//  ToastSampleApp
//
//  Created by 구본의 on 2023/06/23.
//

import UIKit
import Toast

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
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Bottom", for: .normal)
    button.backgroundColor = .lightGray
    button.tintColor = .darkText
    return button
  }()
  
  private let topButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Top", for: .normal)
    button.backgroundColor = .lightGray
    button.tintColor = .darkText
    return button
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [bottomButton, topButton])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 20
    return stackView
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
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      stackView.heightAnchor.constraint(equalToConstant: 60)
    ])
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
        direction: .bottomToTop
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
        direction: .topToBottom
      )
    case .ToastWithImageView:
      Toast.showToast(
        message: "Toast With Image",
        image: UIImage(systemName: "heart.fill"),
        direction: .topToBottom
      )
    case .CustomDesign:
      Toast.showToast(
        message: "Toast With Custom Design",
        design: customDesign,
        direction: .topToBottom
      )
      
    case .CustomLayout:
      Toast.showToast(
        message: "Toast With Image",
        image: UIImage(systemName: "heart.fill")!,
        layout: customLayout,
        direction: .topToBottom
      )
      
    case .CustomAnimation:
      Toast.showToast(
        message: "Toast With Custom Animation",
        animation: customAnimation,
        direction: .topToBottom
      )
    }
  }
}
