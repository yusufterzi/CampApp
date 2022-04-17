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

enum Constant {
    static let headerEdge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 24)
}
protocol CampAddingPresenterProtocol {
    var camp: CampModel { get set }
    var campImages: [CampImageModel]? { get set }
}

final class CampAddingPresenter: CampAddingPresenterProtocol, BaseListPresenter {
    public var campImages: [CampImageModel]?
    internal weak var view: BaseListView?
    internal var interactor: CampAddingInteractorProtocol?
    internal var router: UnownedRouter<ProfileRoute>
    public var camp: CampModel
    private var imageArray: [UIImage]?
    
    init(view: BaseListView, router: UnownedRouter<ProfileRoute>) {
        self.view = view
        self.router = router
        self.interactor = CampAddingInteractor()
        self.camp = CampModel()
    }
    
    func loadUI() {
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
                                           headerEdgeInsets: Constant.headerEdge,
                                           placeHolder: StringProvider.campAreaNamePlaceHolder,
                                           text: self.camp.name)
        
        presenter.textEdited = { [weak self] campName in
            self?.camp.name = campName
        }
        
        
        let component = TextFieldComponent(id: "",
                                           presenter: presenter)
        return CellNode(component)
    }
    private func campLocationSearchView() -> CellNode {
        
        let presenter = TextFieldPresenter(headerTitle: StringProvider.location,
                                           headerFont: FontProvider.regular12,
                                           headerColor: ColorProvider.semiDarkTextColor.color,
                                           headerEdgeInsets: Constant.headerEdge,
                                           placeHolder: StringProvider.locationPlaceHolder,
                                           image: ImageProvider.arrowBottom,
                                           isUserInteractionEnabled: false,
                                           text: self.camp.address)
        presenter.onTap = { [weak self] in
            
            self?.router.trigger(.maps({ location in
                self?.camp.longitude = location.coordinate?.longitude
                self?.camp.latitude = location.coordinate?.latitude
                self?.camp.city = location.city
                self?.camp.address = location.address
                self?.loadUI()
            }), with: TransitionOptions(animated: true))
        }
        
        let component = TextFieldComponent(id: "",
                                           presenter: presenter)
        return CellNode(component)
    }
    private func campLocationView() -> CellNode {
        
        let presenter = TextFieldPresenter(headerTitle: StringProvider.locationName,
                                           headerFont: FontProvider.regular12,
                                           headerColor: ColorProvider.semiDarkTextColor.color,
                                           headerEdgeInsets: Constant.headerEdge,
                                           placeHolder: StringProvider.locationNamePlaceHolder,
                                           text: self.camp.subLocation)
        presenter.textEdited = { [weak self] location in
            self?.camp.subLocation = location
        }
        
        let component = TextFieldComponent(id: "",
                                           presenter: presenter)
        return CellNode(component)
    }
    private func campDescriptionView() -> CellNode {
        
        let presenter = MultilineTextViewPresenter(headerTitle: StringProvider.description,
                                                   headerFont: FontProvider.regular12,
                                                   headerColor: ColorProvider.semiDarkTextColor.color,
                                                   headerEdgeInsets: Constant.headerEdge,
                                                   placeHolder: StringProvider.descriptionPlaceHolder,
                                                   text: self.camp.description)
        presenter.textEdited = { [weak self] description in
            self?.camp.description = description
        }
        let component = MultilineTextViewComponent(id: "",
                                                   presenter: presenter)
        return CellNode(component)
    }
    
    private func campUploadImageView() -> CellNode {
        
        let presenter = CampAreaCollectionPresenter()
        presenter.selectedImagesHandler = { [weak self] images in
            self?.campImages = presenter.selectedImages.compactMap( { CampImageModel(campImage: $0) } )
        }
        
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
            guard let self = self else { return }
            self.interactor?.campImages = self.campImages ?? .init()
            self.interactor?.camp = self.camp 
            self.interactor?.camp.images = self.campImages?.compactMap( {$0.uuid})
            self.interactor?.uploadData()
            self.router.trigger(.back, with: TransitionOptions(animated: true))
        }
        let component = ButtonComponent(id: "",
                                        presenter: presenter)
        return CellNode(component)
    }
    
    
}
