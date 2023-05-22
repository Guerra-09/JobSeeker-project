import UIKit

final class ListPresenter {
    
    private weak var view: ListControllerProtocol?
    private var listCompany: CompanyService?
    private var listCategory: CategoryService?
    private var listOffers: JobOffersService?
    
    init(listCompany: CompanyService, listCategory: CategoryService, listOffers: JobOffersService) {
        self.listCompany = listCompany
        self.listCategory = listCategory
        self.listOffers = listOffers
    }
    
    func attach(view: ListControllerProtocol) {
        self.view = view
    }
    
    func showCompanyList() {
        self.listCompany?.fetchingAPIData(completionHandler: { [weak self] model, error  in
            

            
            if let model = model  {
                self?.view?.listSuccess(model: model.data)
            } else {
                self?.view?.errorList()
            }
            
            
            
        })
    }
    
    func showCategoryList() {
        self.listCategory?.fetchCategories(completionHandler: { [weak self] model, Error in
            
            if let model = model {
                self?.view?.categorySuccess(model: model.data)
            } else {
                self?.view?.errorList()
            }
            
        })
    }
    
    func showOffersCategory(type: String) {
        self.listOffers?.fetchingOffersData(jobId: type, completionHandler: { [weak self] model, Error in
            
            if let model = model {
                self?.view?.offerSuccess(model: model.data)
            } else {
                self?.view?.errorList()
            }
        })
    }
    
}
