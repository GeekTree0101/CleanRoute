//
//  CleanRouteTests.swift
//  CleanRouteTests
//
//  Created by Hyeon su Ha on 20/09/2019.
//  Copyright © 2019 Geektree0101. All rights reserved.
//

import XCTest
import Nimble

@testable import CleanRoute

class CleanRouteTests: XCTestCase {
  
  var showVC: ShowViewController!
  var editorRouter: EditorRouter!
  var editorDataStore: Stub_EditorDataStore!
  
  override func setUp() {
    super.setUp()
    self.showVC = ShowViewController.init()
    self.editorRouter = EditorRouter.init()
    self.editorDataStore = Stub_EditorDataStore()
    self.editorRouter.dataStore = self.editorDataStore
    self.editorRouter.sourceVC = self.showVC
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testDataPssingWithDismiss() {
    // Given
    self.editorDataStore.content = "success content passing"
    
    // When
    self.editorRouter.dismiss()
    
    // Then
    expect(self.showVC.router?.dataStore?.content) == "success content passing"
  }
  
  func testDataPassingWithPop() {
    // Given
    self.editorDataStore.content = "success content passing2"
    
    // When
    self.editorRouter.popViewController()
    
    // Then
    expect(self.showVC.router?.dataStore?.content) == "success content passing2"
  }
}

extension CleanRouteTests {
  
  class Stub_EditorDataStore: EditorDataStore {
    
    var content: String?
  }
}
