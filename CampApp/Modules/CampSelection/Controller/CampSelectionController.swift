//
//  CampSelectionController.swift
//  CampApp
//
//  Created by Nurullah Vural on 15.02.2022.
//

import UIKit
import Common

final class CampSelectionController: UIViewController, Storyboarded {
    
    private var presenter: CampSelectionPresenter?
    @IBOutlet public var titleLabel: UILabel!
    @IBOutlet public var mainView: UIView!
    @IBOutlet public var caravanView: UIView!
    @IBOutlet public var tentView: UIView!
    @IBOutlet public var bungalowView: UIView!
    @IBOutlet var caravanImageView: UIImageView!
    @IBOutlet var caravanLabel: UILabel!
    @IBOutlet var tentImageView: UIImageView!
    @IBOutlet var tentLabel: UILabel!
    @IBOutlet var bungalowImageView: UIImageView!
    @IBOutlet var bungalowLabel: UILabel!
    @IBOutlet var doesntMatterButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadUI(viewController: self)
    }
    public func setupPresenter(presenter: CampSelectionPresenter) {
        self.presenter = presenter
        
    }
   
}
