//
//  ProfilePresenter.swift
//  CampApp
//
//  Created by Nurullah Vural on 28.02.2022.
//

import XCoordinator
import Carbon
import Common
import YTUI
import YTNetwork
import AttributedStringBuilder

protocol ProfilePresenterProtocol {
    
}

final class ProfilePresenter: ProfilePresenterProtocol, BaseListPresenter {
    
    internal weak var view: BaseListView?
    internal var interactor: ProfileInteractorProtocol?
    internal var router: UnownedRouter<ProfileRoute>
    
    init(view: BaseListView, router: UnownedRouter<ProfileRoute>) {
        self.view = view
        self.router = router
        self.interactor = ProfileInteractor()
    }
    
    func loadUI() {
        self.dataLoaded()
    }
    
    func dataLoaded() {
        //guard let interactor = interactor else { return }
        var cells: [CellNode] = []
        cells.append(addCampRow())
        let section = Section(id: "", header: nil, cells: cells, footer: nil)
        view?.sendAction(.loadData([section]))
    }
    
    private func addCampRow() -> CellNode {
        let presenter = TextRowPresenter(text: StringProvider.addCampArea,
                                         color: ColorProvider.blackTextColor.color,
                                         font: FontProvider.profileRowTextFont,
                                         image: ImageProvider.arrowRight)
        presenter.onTap = { [weak self] in
            debugPrint("add camping tapped")
            self?.router.trigger(.searchCampArea, with: TransitionOptions(animated: true))
        }
        let addCampRow = TextRowComponent(id: "addCamping", presenter: presenter)
        return CellNode(addCampRow)
    }
    
}
