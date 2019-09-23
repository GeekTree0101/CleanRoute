import AsyncDisplayKit

protocol EditorDisplayLogic: class {
  
  func displayContent(_ viewModel: EditorModels.Content.ViewModel)
}

class EditorViewController: ASViewController<ASDisplayNode> {
  
  // MARK: - UI Props
  lazy var contentNode: ASEditableTextNode = {
    let node = ASEditableTextNode()
    node.isUserInteractionEnabled = true
    node.textContainerInset = .init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    node.typingAttributes = [
      NSAttributedString.Key.font.rawValue:
        UIFont.boldSystemFont(ofSize: 15.0)
    ]
    node.delegate = self
    return node
  }()
  
  private var interactor: EditorInteractorLogic?
  public var router: (EditorRouterLogic & EditorDataPassing)?
  
  init() {
    super.init(node: .init())
    self.node.automaticallyManagesSubnodes = true
    self.node.automaticallyRelayoutOnSafeAreaChanges = true
    
    self.node.layoutSpecBlock = { [weak self] (node, _) -> ASLayoutSpec in
      guard let self = self else {
        return LayoutSpec { EmptyLayout() }
      }
      
      var insets = node.safeAreaInsets
      insets.top += 50.0
      
      return LayoutSpec {
        InsetLayout(insets: insets) {
          self.contentNode
        }
      }
    }
    
    self.configure()
    self.title = "Editor"
    
    if #available(iOS 13.0, *) {
      self.node.backgroundColor = .systemBackground
    } else {
      self.node.backgroundColor = .white
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    interactor?.loadContent(.init())
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if navigationController?.isBeingPresented == true {
      self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(
        barButtonSystemItem: .cancel,
        target: self,
        action: #selector(didTapCloseEditor))
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    guard self.isMovingFromParent == true else { return }
    self.router?.popViewController()
  }
  
  private func configure() {
    let vc = self
    let interactor = EditorInteractor.init()
    let presenter = EditorPresenter.init()
    let router = EditorRouter.init()
    
    vc.interactor = interactor
    interactor.presenter = presenter
    presenter.display = vc
    
    router.dataStore = interactor
    router.vc = vc
    vc.router = router
  }
}

extension EditorViewController {
  
  @objc func didTapCloseEditor() {
    self.router?.dismiss()
  }
}

extension EditorViewController: ASEditableTextNodeDelegate {
  
  func editableTextNodeDidUpdateText(_ editableTextNode: ASEditableTextNode) {
    
    let request = EditorModels.ContentEdit.Request.init(currentText: editableTextNode.textView.text)
    self.interactor?.updateCurrentTypedContent(request)
  }
}

extension EditorViewController: EditorDisplayLogic {
  
  func displayContent(_ viewModel: EditorModels.Content.ViewModel) {
    
    self.contentNode.textView.text = viewModel.content
    self.node.setNeedsLayout()
  }
  
}
