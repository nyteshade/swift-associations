import XCTest
@testable import Associations

/// Example class demonstrating usage
class MyClass: Associable {
  var property: String?
  
  init() {
    associate("Hello", forKey: "Greeting")
  }
  
  deinit {
    print("Disassociating")
    disassociateAll()
  }
}

final class AssociationsTests: XCTestCase {
  func testRemovingAndCheckingForAssociation() throws {
    let instance = MyClass()
    
    let key = "Meaning of life"
    let saysWho = "Who said the meaning of life was that value?"
    
    instance.associate(42, forKey: key)
    instance.associate("Douglas Adams", forKey: saysWho)
    
    if let author: String = instance.associatedValue(forKey: saysWho) {
      XCTAssert(author == "Douglas Adams")
    }
    
    instance.disassociate(forKey: saysWho)
    XCTAssert(!instance.isAssociated(withKey: saysWho))
  }
  
  func testMakingAndRetrievingAssociations() throws {
    // XCTest Documentation
    // https://developer.apple.com/documentation/xctest
    
    // Defining Test Cases and Test Methods
    // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    
    var instance: MyClass? = MyClass()
    
    if let greeting: String = instance?.associatedValue(forKey: "Greeting") {
      XCTAssert(greeting == "Hello")
    }
    
    if let instance = instance {
      instance.associate("Brielle", forKey: "name")
      instance.associate(42, forKey: "age")
      
      let name: String? = instance.associatedValue(forKey: "name")
      let age: Int? = instance.associatedValue(forKey: "age")
      
      if let age = age, let name = name {
        print("My name is \(name), I am \(age) year(s) old.")
      }
    }

    // When `instance` is set to nil, the associated object is automatically released,
    // but we can also manually disassociate all before deinitialization.
    instance = nil
  }
}
