protocol ShowPresenterLogic: class {
  
  func presentContent(_ res: ShowViewModels.Content.Response)
}

class ShowPresenter: ShowPresenterLogic {
  
  weak var display: ShowDisplayLogic?
  
  func presentContent(_ res: ShowViewModels.Content.Response) {
    let viewModel = ShowViewModels.Content.ViewModel(content: res.content)
    display?.displayContent(viewModel)
  }

}
