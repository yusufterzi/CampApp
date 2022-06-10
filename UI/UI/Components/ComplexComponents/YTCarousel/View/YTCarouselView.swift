//
//  YTCarouselView.swift
//  YTUI
//
//  Created by yusuf terzi on 1.10.2021.
//

import Common
import Carbon
import SnapKit
import UIKit
import SDWebImage
import FirebaseStorageUI
public protocol YTCarouselViewProtocol: BaseView {
  
}

public final class YTCarouselView: UIView, Tappable, YTCarouselViewProtocol {
  
  private let backLeftImageView: UIImageView = UIImageView().then {
    $0.layer.cornerRadius = 5
    $0.clipsToBounds = true
  }
  let rightBlurEffectView = UIVisualEffectView()

  private let backRightImageView: UIImageView = UIImageView().then {
    $0.layer.cornerRadius = 5
    $0.clipsToBounds = true
  }
  let leftBlurEffectView = UIVisualEffectView()

  private let frontImageView: UIImageView = UIImageView().then {
    $0.layer.cornerRadius = 5
    $0.clipsToBounds = true
  }
  
  private let locationLabel: IconedLabel = IconedLabel()
  private let pointLabel: IconedLabel = IconedLabel()
  private let pageView: YTPageStackView = YTPageStackView()
  
  public var presenter: YTCarouselPresenterProtocol?

  public init() {
    super.init(frame: .zero)
      initialize()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configureView(presenter: YTCarouselPresenterProtocol?) {
    self.presenter = presenter
    
    loadUI()
  }
  
  public func loadUI() {
    guard let presenter = presenter else {
      return
    }

    setupPageView()
    setupBackLeft()
    setupBackRight()

    let currentItem = presenter.items[presenter.index]
    if let ref = currentItem.imageReference?[currentItem.introImageIndex ?? 0] {
        frontImageView.sd_setImage(with: ref)
    } else {
      frontImageView.image = nil
    }
    
    let starPresenter = IconedLabelPresenter(title: presenter.point,
                                             image: ImageProvider.star,
                                             textColor: ColorProvider.whiteTextColor.color)
    starPresenter.space = 4
    starPresenter.textFont = FontProvider.listSmallRegular
    starPresenter.imageTintColor = ColorProvider.whiteTextColor.color
    starPresenter.radius = 12
    starPresenter.backgroundColor = ColorProvider.blackTextColor.color.withAlphaComponent(0.15)
    pointLabel.configureView(presenter: starPresenter)
    
    let locationPresenter = IconedLabelPresenter(title: presenter.location,
                                                 image: ImageProvider.mapPin,
                                                 textColor: ColorProvider.segmentItemSelectedText.color)
    locationPresenter.textFont = FontProvider.listSmallRegular
    locationPresenter.space = 4
    locationPresenter.radius = 12
    locationPresenter.backgroundColor = ColorProvider.locationBgColor.color
    locationPresenter.imageTintColor = ColorProvider.segmentItemSelectedText.color
    locationLabel.configureView(presenter: locationPresenter)
    
    onTap { [weak self] in
        self?.presenter?.onTap?()
    }
    
  }
}

private extension YTCarouselView {
  func initialize() {
    setupViews()
    setupConstraints()
  }

  func setupBackRight() {
    guard let presenter = presenter else {
      return
    }
    if presenter.index < (presenter.items.count - 1) {
      if let ref = presenter.items[presenter.index + 1].imageReference?.first {
        backRightImageView.sd_setImage(with: ref)
        backRightImageView.isHidden = false
      }
    } else {
      backRightImageView.isHidden = true
    }
    
    if backRightImageView.subviews.count == 0 {
      let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
      rightBlurEffectView.effect = blurEffect
      rightBlurEffectView.frame = CGRect(x: 0, y: 0, width: 500, height: 210)
      rightBlurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      backRightImageView.addSubview(rightBlurEffectView)
    }
    rightBlurEffectView.layer.opacity = 1

  }
  
  func setupBackLeft() {
    guard let presenter = presenter else {
      return
    }
    if presenter.index != 0 {
      if let ref = presenter.items[presenter.index - 1].imageReference?.first {
        backLeftImageView.sd_setImage(with: ref)
        backLeftImageView.isHidden = false
      }
    } else {
     backLeftImageView.isHidden = true
   }
    
    if backLeftImageView.subviews.count == 0 {
      let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
      leftBlurEffectView.effect = blurEffect
      leftBlurEffectView.frame = CGRect(x: 0, y: 0, width: 500, height: 210)
      leftBlurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      backLeftImageView.addSubview(leftBlurEffectView)
    }
    leftBlurEffectView.layer.opacity = 1
  }
  
  func setupPageView() {
    let presenter = YTPageStackViewPresenter(itemCount: self.presenter?.items.count ?? 0)
    presenter.selectedItemIndex = self.presenter?.index ?? 0
    pageView.configureView(presenter: presenter)
  }
  
  func setupViews() {
    addSubview(backLeftImageView)
    addSubview(backRightImageView)
    addSubview(frontImageView)
    addSubview(pointLabel)
    addSubview(locationLabel)
    addSubview(pageView)
    
    let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
    frontImageView.isUserInteractionEnabled = true
    frontImageView.addGestureRecognizer(gesture)
  }
  
  func setupConstraints() {
    backLeftImageView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(12)
      $0.top.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-50)
      $0.bottom.equalToSuperview().offset(-32)
    }
    
    backRightImageView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(50)
      $0.top.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-12)
      $0.bottom.equalToSuperview().offset(-32)
    }
    
    frontImageView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(24)
      $0.top.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.bottom.equalToSuperview().offset(-24)
      $0.height.equalTo(210)
    }
    
    pointLabel.snp.makeConstraints {
      $0.top.equalTo(frontImageView.snp.top).offset(16)
      $0.height.equalTo(24)
      $0.trailing.equalTo(frontImageView.snp.trailing).offset(-8)
    }
    
    locationLabel.snp.makeConstraints {
      $0.top.equalTo(frontImageView.snp.top).offset(16)
      $0.height.equalTo(24)
      $0.leading.equalTo(frontImageView.snp.leading).offset(8)
    }
    
    pageView.snp.makeConstraints {
      $0.bottom.equalTo(frontImageView.snp.bottom).offset(-8)
      $0.leading.equalTo(frontImageView.snp.leading).offset(16)
      $0.height.equalTo(6)
    }
    
  }

}

private extension YTCarouselView {
  
  func remakeOriginConsts() {
    frontImageView.snp.remakeConstraints {
      $0.leading.equalToSuperview().offset(24)
      $0.top.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview().offset(-24)
      $0.bottom.equalToSuperview().offset(-24)
      $0.height.equalTo(210)
    }
    pageView.layer.opacity = 0
    pointLabel.layer.opacity = 0
    locationLabel.layer.opacity = 0
    self.view.layoutIfNeeded()
    
    backLeftImageView.snp.remakeConstraints {
      $0.leading.equalToSuperview().offset(12)
      $0.top.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-50)
      $0.bottom.equalToSuperview().offset(-32)
    }
    
    backRightImageView.snp.remakeConstraints {
      $0.leading.equalToSuperview().offset(50)
      $0.top.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-12)
      $0.bottom.equalToSuperview().offset(-32)
    }
    
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.pageView.layer.opacity = 1
      self?.pointLabel.layer.opacity = 1
      self?.locationLabel.layer.opacity = 1
      self?.view.layoutIfNeeded()
    }
  }
  
  @objc func handlePan(sender: UIPanGestureRecognizer) {
    guard var presenter = presenter else { return }
    if sender.state == .began {
      presenter.gestureStartPoint = sender.location(in: self)
    } else if sender.state == .changed {
      let location = sender.location(in: self)
      presenter.addVelocity(value: presenter.gestureLastPoint.x - location.x)
      presenter.gestureLastPoint = location

      let xDif = presenter.gestureStartPoint.x - location.x
      var yDif = presenter.gestureStartPoint.y - location.y
      if yDif > 0 && yDif > 20 {
        yDif = 20
      }
      if yDif < 0 && yDif < -20 {
        yDif = -20
      }

      frontImageView.snp.remakeConstraints {
        $0.leading.equalToSuperview().offset(24 - xDif)
        $0.top.equalToSuperview().offset(24 - yDif)
        $0.trailing.equalToSuperview().offset(-24 - xDif)
        $0.bottom.equalToSuperview().offset(-24 - yDif)
        $0.height.equalTo(210)
      }

      if xDif > 0 {
        var ratio = xDif / 200
        if ratio > 0.7 {
          ratio = 0.7
        }
        debugPrint(ratio)
        rightBlurEffectView.layer.opacity = Float(1 - ratio)
        sendSubviewToBack(backLeftImageView)
      } else {
        var ratio = (-1 * xDif) / 200
        if ratio > 0.7 {
          ratio = 0.7
        }

        leftBlurEffectView.layer.opacity = Float(1 - ratio)
        sendSubviewToBack(backRightImageView)
      }
      
    } else if sender.state == .cancelled || sender.state == .ended {
      let velocity = presenter.velocityArray.reduce(0, +) / 10
      debugPrint(velocity)
      if velocity > 1 && presenter.index < (presenter.items.count - 1){
        sendImageToSpace(imageView: frontImageView, isRight: true)
      } else if velocity < -1 && presenter.index > 0{
        sendImageToSpace(imageView: frontImageView, isRight: false)
      } else {
        frontImageView.snp.remakeConstraints {
          $0.leading.equalToSuperview().offset(24)
          $0.top.equalToSuperview().offset(24)
          $0.trailing.equalToSuperview().offset(-24)
          $0.bottom.equalToSuperview().offset(-24)
          $0.height.equalTo(210)
        }

        UIView.animate(withDuration: 0.3) { [weak self] in
          self?.rightBlurEffectView.layer.opacity = 1
          self?.leftBlurEffectView.layer.opacity = 1
          self?.view.layoutIfNeeded()
        }
      }
    }
    
    func sendImageToSpace(imageView: UIImageView, isRight: Bool) {
      let screenSize: CGRect = UIScreen.main.bounds
      let offset = isRight ? (-screenSize.width - 50) : (screenSize.width + 50)
      
      imageView.snp.updateConstraints {
        $0.leading.equalToSuperview().offset(offset)
        $0.top.equalToSuperview().offset(24)
        $0.trailing.equalToSuperview().offset(offset)
        $0.bottom.equalToSuperview().offset(-24)
        $0.height.equalTo(210)
      }
      
      if isRight {
        presenter.index += 1
        sendSubviewToBack(backLeftImageView)
        backRightImageView.snp.updateConstraints {
          $0.leading.equalToSuperview().offset(24)
          $0.top.equalToSuperview().offset(24)
          $0.trailing.equalToSuperview().offset(-24)
          $0.bottom.equalToSuperview().offset(-24)
        }
      } else {
        presenter.index -= 1
        sendSubviewToBack(backRightImageView)
        backLeftImageView.snp.updateConstraints {
          $0.leading.equalToSuperview().offset(24)
          $0.top.equalToSuperview().offset(24)
          $0.trailing.equalToSuperview().offset(-24)
          $0.bottom.equalToSuperview().offset(-24)
        }
      }
      
      

      UIView.animate(withDuration: 0.5) { [weak self] in
        self?.view.layoutIfNeeded()
        self?.leftBlurEffectView.layer.opacity = 0
        self?.rightBlurEffectView.layer.opacity = 0
      } completion: { [weak self] _ in
        self?.loadUI()
        
        self?.remakeOriginConsts()
      }

    }
    
  }
}
