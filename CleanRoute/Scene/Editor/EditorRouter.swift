import UIKit

protocol EditorDataPassing: class {
  
  var dataStore: EditorDataStore? { get }
  var sourceVC: UIViewController? { get set }
}

protocol EditorRouterLogic: class {
  
  func popViewController()
  func dismiss()
}

class EditorRouter: EditorDataPassing {
  
  var dataStore: EditorDataStore?
  var sourceVC: UIViewController?
  
  weak var vc: EditorViewController?
  
}

extension EditorRouter: EditorRouterLogic {
  
  
  func popViewController() {
    switch sourceVC {
    case .some(let showVC as ShowViewController):
      showVC.router?.dataStore?.content = dataStore?.content
    default:
      break
    }
  }
  
  func dismiss() {
    switch sourceVC {
    case .some(let showVC as ShowViewController):
      showVC.router?.dataStore?.content = dataStore?.content
    default:
      break
    }
    
    vc?.navigationController?.dismiss(animated: true, completion: nil)
  }
}
