import AsyncDisplayKit

protocol ShowDisplayLogic: class {
  
  func displayContent(_ viewModel: ShowViewModels.Content.ViewModel)
}

class ShowViewController: ASViewController<ASDisplayNode> {
  
  // MARK: - UI Prbops
  lazy var contentNode: ASEditableTextNode = {
    let node = ASEditableTextNode()
    node.isUserInteractionEnabled = false
    node.textContainerInset = .init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    node.typingAttributes = [
      NSAttributedString.Key.font.rawValue:
      UIFont.boldSystemFont(ofSize: 15.0)
    ]
    return node
  }()
  
  private var interactor: ShowInteractorLogic?
  public var router: (ShowRouterLogic & ShowDataPassing)?
  
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
    self.title = "Viwer"
    
    if #available(iOS 13.0, *) {
      self.node.backgroundColor = .systemBackground
    } else {
      self.node.backgroundColor = .white
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(
      barButtonSystemItem: .edit,
      target: self,
      action: #selector(didTapEditBarButtonItem))
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    interactor?.loadContent(.init())
  }
  
  private func configure() {
    let vc = self
    let interactor = ShowInteractor.init()
    let presenter = ShowPresenter.init()
    let router = ShowRouter.init()
    
    vc.interactor = interactor
    interactor.presenter = presenter
    presenter.display = vc
    
    router.dataStore = interactor
    router.vc = vc
    vc.router = router
  }
}

extension ShowViewController {
  
  @objc func didTapEditBarButtonItem() {
    // Test
    let rand = Int.random(in: 0...100)
    if rand % 2 == 0 {
      self.router?.presentEditor()
    } else {
      self.router?.pushEditor()
    }
  }
}

extension ShowViewController: ShowDisplayLogic {
  
  func displayContent(_ viewModel: ShowViewModels.Content.ViewModel) {
    self.contentNode.textView.text = viewModel.content
    self.node.setNeedsLayout()
  }
  
}
