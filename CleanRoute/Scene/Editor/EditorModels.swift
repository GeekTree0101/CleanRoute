enum EditorModels {
  
  enum Content {
    
    struct Request {
      
    }
    
    struct Response {
      
      var content: String?
    }
    
    struct ViewModel {
      
      var content: String?
    }
    
  }
  
  enum ContentEdit {
    
    struct Request {
      
      var currentText: String?
    }
    
    struct Response {
      
    }
    
    struct ViewModel {
      
    }
  }
}
