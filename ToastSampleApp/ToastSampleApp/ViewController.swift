//  ViewController.swift
//  ToastSampleApp

import UIKit

enum ToastCategory: String {
  case DefaultToast = "Default Toast"
  case ToastWithImageView = "Toast with ImageView"
  case CustomDesign = "Toast with Custom Design"
  case CustomLayout = "Toast with Custom Layout"
  case CustomAnimation = "Toast with Custom Animation"
  
}

class ViewController: UIViewController {

  private let toastCategory: [ToastCategory] = [
    .DefaultToast,
    .ToastWithImageView,
    .CustomDesign,
    .CustomLayout,
    .CustomAnimation
  ]
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .white
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.title = "TOAST"
    self.setupViews()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.setupLayouts()
  }

  private func setupViews() {
    self.view.addSubview(tableView)
  }
  
  private func setupLayouts() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toastCategory.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = toastCategory[indexPath.row].rawValue
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let type: ToastCategory = toastCategory[indexPath.row]
    let vc = SampleViewController(type: type)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

