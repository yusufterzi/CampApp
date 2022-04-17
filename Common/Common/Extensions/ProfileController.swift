//
//  ProfileController.swift
//  CampApp
//
//  Created by Nurullah Vural on 28.02.2022.
//

import Carbon
import XCoordinator
import YTUI
import Common

class ProfileController: BaseListController<ProfilePresenter>{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorProvider.whiteTextColor.color
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title  = StringProvider.tabProfile
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
