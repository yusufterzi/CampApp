//
//  SelectionView.swift
//  YTUI
//
//  Created by Nurullah Vural on 10.05.2022.
//


import Foundation
import UIKit
import Common
import Carbon

public final class SelectionView: UIView, Tappable {
  
  public var presenter: SelectionViewPresenterProtocol?
  private var header: Label = Label().then {
    $0.textColor = ColorProvider.semiDarkTextColor.color
    $0.font = FontProvider.regular12
    $0.edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 24)
  }
  private var selectedItemList: [SelectionRowPresenter] = []
  
  internal let vStackView = UIStackView().then {
    $0.axis = .vertical
    $0.cornerRadius = 10
    $0.backgroundColor = ColorProvider.whiteTextColor.color
  }
  
  internal let rowView = UIView().then {
    $0.backgroundColor = ColorProvider.lightGray.color
  }
  
  
  public init() {
    super.init(frame: .zero)
    initialize()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView() {
    loadUI()
  }
  public func loadUI() {
    guard let presenter = presenter else {
      return
    }
    
    if ((presenter.itemList.first as? CampTypeEnum) != nil) {
      selectedItemList.append(SelectionRowPresenter(item: CampTypeEnum.all, isSelected: true))
      presenter.selectionHandler?(selectedItemList)
    }
    header.text = presenter.header
    loadStack()
    
  }
  
  private func loadStack() {
    guard let presenter = presenter else {
      return
    }
    
    vStackView.removeArrangedSubviews()
    vStackView.spacing = 2
    
    for item in presenter.itemList {
      
      let selectionRowView: SelectionRowView = SelectionRowView()
      let selectionRowPresenter = SelectionRowPresenter(item: item, isSelected: selectedItemList.contains(where: { $0.item.id == item.id }))
      selectionRowPresenter.onTap = { [weak self] rowModel in
        guard let self = self else { return }
        
        if presenter.multipleSelection {
          if rowModel.isSelected {
            self.selectedItemList.append(rowModel)
          } else {
            if self.selectedItemList.count > 1 {
              self.selectedItemList.removeAll(where: { $0.item.id == rowModel.item.id })
            }
          }
        } else {
          self.selectedItemList.removeAll()
          self.selectedItemList.append(rowModel)
        }
        self.loadStack()
        self.presenter?.selectionHandler?(self.selectedItemList)
      }
      
      selectionRowView.configureView(presenter: selectionRowPresenter)
      vStackView.addArrangedSubview(selectionRowView)
    }
  }
}

extension SelectionView {
  func initialize() {
    setupViews()
    setupConstraints()
  }
  func setupViews() {
    
    addSubview(header)
    addSubview(vStackView)
    
  }
  
  func setupConstraints() {
    
    header.snp.makeConstraints{
      $0.top.equalToSuperview().offset(6)
      $0.trailing.equalToSuperview().offset(-16)
      $0.leading.equalToSuperview().offset(16)
      $0.height.equalTo(15)
    }
    
    vStackView.snp.makeConstraints {
      $0.top.equalTo(header.snp.bottom).offset(6)
      $0.trailing.equalToSuperview().offset(-16)
      $0.leading.equalToSuperview().offset(16)
      $0.bottom.equalToSuperview().offset(-8)
    }
    
  }
}
