//
//  BaseListController.swift
//  CampApp
//
//  Created by yusuf terzi on 23.09.2021.
//

import Foundation
import UIKit
import Carbon
import SnapKit
import XCoordinator

open class BaseListController<T: BaseListPresenter>: UIViewController {
  public typealias Presenter = T

  public var presenter: Presenter?
  
  var tableViewStyle: UITableView.Style {
    return .grouped
  }
  
  internal var tableView: UITableView!
  
  internal let renderer = Renderer(
    adapter: UITableViewAdapter(),
    updater: UITableViewUpdater()
  )
  
  internal let rendererWithoutAnimation = Renderer(
    adapter: UITableViewAdapter(),
    updater: UITableViewReloadDataUpdater()
  )
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    initialize()
    
    enableKeyboardOperations()
    
    presenter?.loadUI()
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  public func setupPresenter(presenter: Presenter) {
    self.presenter = presenter
  }
  
  func render(sections: [Section], animated: Bool = true) {
    configureRender(animated: animated)
    
    if animated {
      renderer.render(sections)
    } else {
      rendererWithoutAnimation.render(sections)
    }
  }
  
  private func enableKeyboardOperations() {
    tableView.keyboardDismissMode = .interactive
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
  }

  @objc private func keyboardWillShow(_ notification: Notification) {
    
    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50 + keyboardSize.height, right: 0)
    }
  }

  @objc private func keyboardWillHide(_ notification: Notification) {
    
    if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
  }
}

private extension BaseListController {
  func initialize() {
    setupViews()
    setupConstraints()
    configureRender()
  }
  
  func configureRender(animated: Bool = true) {
    if animated {
      renderer.target = tableView
    } else {
      rendererWithoutAnimation.target = tableView
    }
  }
  
  func setupViews() {
    setupTableView()
    tableView.contentInsetAdjustmentBehavior = .never
    
    view.addSubview(tableView)
  }
  
  func setupConstraints() {
    tableView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  func setupTableView() {
    tableView = UITableView(frame: .zero, style: tableViewStyle).then {
      $0.setContentCompressionResistancePriority(.required, for: .vertical)
      $0.contentInset =  UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
      $0.separatorStyle = .none
      $0.backgroundColor = .white
      $0.rowHeight = UITableView.automaticDimension
      $0.estimatedRowHeight = 44.0
      $0.setContentHuggingPriority(.defaultLow, for: .vertical)
      $0.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0,
                                                width: CGFloat.leastNonzeroMagnitude,
                                                height: CGFloat.leastNonzeroMagnitude))
      $0.tableFooterView = UIView(frame: CGRect(x: 0, y: 0,
                                                width: CGFloat.leastNonzeroMagnitude,
                                                height: CGFloat.leastNonzeroMagnitude))
      
    }
  }
  
}

extension BaseListController: BaseListView {
  
  public func viewUpdated(sections: [Section]) {
    renderer.render(sections)
  }
  
  public func setupTitle(title: String) {
    self.title = title
  }
}
