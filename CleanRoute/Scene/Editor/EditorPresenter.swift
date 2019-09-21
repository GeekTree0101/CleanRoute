import UIKit

protocol EditorPresenterLogic: class {
  
  func presentContent(_ res: EditorModels.Content.Response)
}

class EditorPresenter: EditorPresenterLogic {
  
  weak var display: EditorDisplayLogic?
  
  func presentContent(_ res: EditorModels.Content.Response) {
    
    let viewModel = EditorModels.Content.ViewModel(content: res.content)
    display?.displayContent(viewModel)
  }
  
}
