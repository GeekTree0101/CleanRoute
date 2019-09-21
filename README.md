# CleanRouter
> CleanSwift, Convenience routing example between scenes [Research Repository]

[![CI Status](https://github.com/Geektree0101/CleanRoute/workflows/ci/badge.svg)](https://geektree0101.github.io/)

<img src="https://github.com/GeekTree0101/CleanRoute/blob/master/res/CleanRoute.png" />


### Hard codeded finding previous viewController logic

> EditRouter.swift
```swift
func movingFromParent(segue: UIStoryboardSegue?) {
    if let segue = segue {
      let destinationVC = segue.destination as? ShowViewController
      destinationVC?.router?.dataStore?.content = self.dataStore?.content
    } else {
      let destinationVC = self.viewController?.navigationController?.topViewController as? ShowViewController
      destinationVC?.router?.dataStore?.content = self.dataStore?.content
    }
}

func dismiss(segue: UIStoryboardSegue?) {
    if let segue = segue {
      let destinationVC = segue.destination as? ShowViewController
      destinationVC?.router?.dataStore?.content = self.dataStore?.content
    } else {
      let parentNavVC = self.viewController?.navigationController?.presentingViewController as? UINavigationController
      let destinationVC = parentNavVC?.topViewController as? ShowViewController
      destinationVC?.router?.dataStore?.content = self.dataStore?.content
      self.viewController?.dismiss(animated: true)
    }
}
```
In Storyboard case, doesn't matter about finding previous viewController. 
but, Hard codeded find previous viewController logic isn't only hard to define previous viewController also easy to occur unexpected bugs. 



### Using defined sourceVC prop from DataPassing
In my case, EditorDataPassing supports defined previous viewController property. aka sourceVC(UIViewController) 

> EditorRouter.swift
```swift
protocol EditorDataPassing: class {
  
  var dataStore: EditorDataStore? { get }
  var sourceVC: UIViewController? { get set } // <- Here!!!!!
}
```

> ShowRouter.swift
```swift

extension ShowRouter: ShowRouterLogic {
  
  func presentEditor() {
    let editorVC = EditorViewController.init()
    
    editorVC.router?.dataStore?.content = dataStore?.content
    editorVC.router?.sourceVC = vc // <- Here!!!!!
    
    let navVC = UINavigationController(rootViewController: editorVC)
    vc?.present(navVC, animated: true, completion: nil)
  }
  
  func pushEditor() {
    let editorVC = EditorViewController.init()
    
    editorVC.router?.dataStore?.content = dataStore?.content
    editorVC.router?.sourceVC = vc // <- Here!!!!!
    
    vc?.navigationController?.pushViewController(editorVC, animated: true)
  }
}

```

> EditorRouter.swift
```swift
func movingFromParent(segue: UIStoryboardSegue?) {
    if let segue = segue {
      let destinationVC = segue.destination as? ShowViewController
      destinationVC?.router?.dataStore?.content = self.dataStore?.content
    } else {
      let destinationVC = self.sourceVC as? ShowViewController
      destinationVC?.router?.dataStore?.content = self.dataStore?.content
    }
}

func dismiss(segue: UIStoryboardSegue?) {
    if let segue = segue {
      let destinationVC = segue.destination as? ShowViewController
      destinationVC?.router?.dataStore?.content = self.dataStore?.content
    } else {
      let destinationVC = self.sourceVC as? ShowViewController
      destinationVC?.router?.dataStore?.content = self.dataStore?.content
      self.viewController?.dismiss(animated: true)
    }
}
```