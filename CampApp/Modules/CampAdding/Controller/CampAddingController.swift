//
//  CampAddingController.swift
//  CampApp
//
//  Created by Nurullah Vural on 2.03.2022.
//

import Carbon
import XCoordinator
import YTUI
import Common

class CampAddingController: BaseListController<CampAddingPresenter> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorProvider.whiteTextColor.color
        self.title  = StringProvider.addCamp
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}


