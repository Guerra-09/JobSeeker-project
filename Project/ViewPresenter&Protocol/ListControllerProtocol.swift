protocol ListControllerProtocol: AnyObject {
    func listSuccess(model: [CompanyModel])
    func categorySuccess(model: [CategoryModel])
    func offerSuccess(model: [JobOfferModel])
    func errorList()
    
}
