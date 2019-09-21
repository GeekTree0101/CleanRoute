protocol EditorInteractorLogic: class {
  
  func loadContent(_ request: EditorModels.Content.Request)
  func updateCurrentTypedContent(_ request: EditorModels.ContentEdit.Request)
}

protocol EditorDataStore: class {
  
  var content: String? { get set }
}


class EditorInteractor: EditorDataStore {
  
  var content: String? = nil
  var presenter: EditorPresenterLogic?
}

extension EditorInteractor: EditorInteractorLogic {
  
  func loadContent(_ request: EditorModels.Content.Request) {
    
    let res = EditorModels.Content.Response(content: self.content)
    presenter?.presentContent(res)
  }
  
  func updateCurrentTypedContent(_ request: EditorModels.ContentEdit.Request) {
    
    self.content = request.currentText
    let res = EditorModels.Content.Response.init(content: self.content)
    presenter?.presentContent(res)
  }
  
}
