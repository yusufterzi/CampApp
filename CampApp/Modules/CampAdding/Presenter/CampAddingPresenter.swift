//
//  CampAddingPresenter.swift
//  CampApp
//
//  Created by Nurullah Vural on 2.03.2022.
//

import XCoordinator
import Carbon
import Common
import YTUI
import YTNetwork
import AttributedStringBuilder

protocol CampAddingPresenterProtocol {
    
}

final class CampAddingPresenter: CampAddingPresenterProtocol, BaseListPresenter {
    
    internal weak var view: BaseListView?
    internal var interactor: CampAddingInteractorProtocol?
    internal var router: UnownedRouter<ProfileRoute>

    init(view: BaseListView, router: UnownedRouter<ProfileRoute>) {
        self.view = view
        self.router = router
        self.interactor = CampAddingInteractor()
    }
    
    func loadUI() {
        self.dataLoaded()
    }
    
    func dataLoaded() {
        //guard let interactor = interactor else { return }
        var cells: [CellNode] = []
        
        cells.append(campAreaNameView())
        cells.append(campLocationSearchView())
        cells.append(campLocationView())
        cells.append(campDescriptionView())
        cells.append(campUploadImageView())
        cells.append(saveButtonView())


        let section = Section(id: "", header: nil, cells: cells, footer: nil)
        
        view?.sendAction(.loadData([section]))
    }
    
    private func campAreaNameView() -> CellNode {
        
        let presenter = TextFieldPresenter(headerTitle: StringProvider.campAreaName,
                                           headerFont: FontProvider.regular12,
                                           headerColor: ColorProvider.semiDarkTextColor.color,
                                           headerEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 24), placeHolder: StringProvider.campAreaNamePlaceHolder)
        
        
        let component = TextFieldComponent(id: "",
                                      presenter: presenter)
        return CellNode(component)
    }
    private func campLocationSearchView() -> CellNode {
        
        let presenter = TextFieldPresenter(headerTitle: StringProvider.location,
                                           headerFont: FontProvider.regular12,
                                           headerColor: ColorProvider.semiDarkTextColor.color,
                                           headerEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 24), placeHolder: StringProvider.locationPlaceHolder,
                                           image: ImageProvider.arrowBottom,
                                           isUserInteractionEnabled: false)
        presenter.onTap = { [weak self] in
            print("Open Apple Maps!")
            
        }
        let component = TextFieldComponent(id: "",
                                      presenter: presenter)
        return CellNode(component)
    }
    private func campLocationView() -> CellNode {
        
        let presenter = TextFieldPresenter(headerTitle: StringProvider.locationName,
                                           headerFont: FontProvider.regular12,
                                           headerColor: ColorProvider.semiDarkTextColor.color,
                                           headerEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 24), placeHolder: StringProvider.locationNamePlaceHolder)
        let component = TextFieldComponent(id: "",
                                      presenter: presenter)
        return CellNode(component)
    }
    private func campDescriptionView() -> CellNode {
        
        let presenter = MultilineTextViewPresenter(headerTitle: StringProvider.description,
                                           headerFont: FontProvider.regular12,
                                           headerColor: ColorProvider.semiDarkTextColor.color,
                                           headerEdgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 24), placeHolder: StringProvider.descriptionPlaceHolder)
        let component = MultilineTextViewComponent(id: "",
                                      presenter: presenter)
        return CellNode(component)
    }
    
    private func campUploadImageView() -> CellNode {
        
        let presenter = CampAreaCollectionPresenter()
        let component = CampAreaCollectionComponent(id: "",
                                      presenter: presenter)
        return CellNode(component)
    }
    
    private func saveButtonView() -> CellNode {
        
        let presenter = ButtonPresenter(textFont: FontProvider.bold18,
                                        textColor: ColorProvider.onboardingYellowButtonText.color,
                                        text: StringProvider.save,
                                        backgroundColor: ColorProvider.onboardingRedColor.color)
        presenter.tapped = { [weak self] in
            print("Save Button Tapped!")
        }
        let component = ButtonComponent(id: "",
                                      presenter: presenter)
        return CellNode(component)
    }
    
  

    
    
}
