protocol ShowInteractorLogic: class {
  
  func loadContent(_ request: ShowViewModels.Content.Request)
}

protocol ShowDataStore: class {
  
  var content: String? { get set }
}


class ShowInteractor: ShowDataStore {
  
  var content: String? = nil
  
  var presenter: ShowPresenterLogic?
  
}

extension ShowInteractor: ShowInteractorLogic {
  
  func loadContent(_ request: ShowViewModels.Content.Request) {
    
    let res = ShowViewModels.Content.Response(content: self.content)
    presenter?.presentContent(res)
  }
  
}
