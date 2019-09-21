import UIKit

protocol ShowDataPassing: class {
  
  var dataStore: ShowDataStore? { get }
  var sourceVC: UIViewController? { get set }
}

protocol ShowRouterLogic: class {
  
  func presentEditor()
  func pushEditor()
}

class ShowRouter: ShowDataPassing {
  
  var dataStore: ShowDataStore?
  var sourceVC: UIViewController?
  
  weak var vc: ShowViewController?
  
}

extension ShowRouter: ShowRouterLogic {
  
  func presentEditor() {
    let editorVC = EditorViewController.init()
    
    editorVC.router?.dataStore?.content = dataStore?.content
    editorVC.router?.sourceVC = vc
    
    let navVC = UINavigationController(rootViewController: editorVC)
    vc?.present(navVC, animated: true, completion: nil)
  }
  
  func pushEditor() {
    let editorVC = EditorViewController.init()
    
    editorVC.router?.dataStore?.content = dataStore?.content
    editorVC.router?.sourceVC = vc
    
    vc?.navigationController?.pushViewController(editorVC, animated: true)
  }
}
