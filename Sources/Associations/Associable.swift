//
//  Associable.swift
//  
//
//  Created by Brielle Harrison on 4/7/24.
//

import Foundation

/// A protocol that enables the association of values with class instances. This can be used to
/// add custom data to any class instance without modifying the class definition itself.
public protocol Associable: AnyObject { }

public extension Associable {
  /// Associates a value with this instance using a specified key. The value is retained
  /// non-atomically with the instance.
  ///
  /// - Parameters:
  ///   - value: The value to associate with this instance.
  ///   - key: The key under which to store the value.
  ///
  /// Example:
  /// ```
  /// class MyClass: Associable {}
  /// let instance = MyClass()
  /// instance.associate("Hello, World!", forKey: "greeting")
  /// ```
  func associate<T>(_ value: T, forKey key: String) {
    let keyPointer = UnsafeRawPointer(bitPattern: key.hashValue)!
    objc_setAssociatedObject(self, keyPointer, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
  
  /// Retrieves the value associated with this instance for a specified key.
  ///
  /// - Parameter key: The key for the associated value.
  /// - Returns: The value associated with the key, or nil if no value is associated.
  ///
  /// Example:
  /// ```
  /// class MyClass: Associable {}
  /// let instance = MyClass()
  /// instance.associate("Hello, World!", forKey: "greeting")
  /// let greeting: String? = instance.associatedValue(forKey: "greeting")
  /// print(greeting) // Outputs "Hello, World!"
  /// ```
  func associatedValue<T>(forKey key: String) -> T? {
    let keyPointer = UnsafeRawPointer(bitPattern: key.hashValue)!
    return objc_getAssociatedObject(self, keyPointer) as? T
  }
  
  /// Checks whether a non-nil value is associated with this instance for the specified key.
  ///
  /// - Parameter key: The key used to check for an associated value.
  /// - Returns: `true` if there is a value associated with the key, `false` otherwise.
  ///
  /// Example:
  /// ```
  /// class MyClass: Associable {}
  /// let instance = MyClass()
  /// instance.associate("Hello, World!", forKey: "greeting")
  /// if instance.isAssociated(withKey: "greeting") {
  ///   print("A greeting is associated")
  /// } else {
  ///   print("No greeting is associated")
  /// }
  /// ```
  func isAssociated(withKey key:String) -> Bool {
    let keyPointer = UnsafeRawPointer(bitPattern: key.hashValue)!
    let value: Any? = objc_getAssociatedObject(self, keyPointer)
    
    return value != nil
  }
  
  /// Disassociates the value for this instance for the specified key.
  ///
  /// - Parameter key: The key for which the association should be removed.
  ///
  /// Example:
  /// ```
  /// class MyClass: Associable {}
  /// let instance = MyClass()
  /// instance.associate("Hello, World!", forKey: "greeting")
  /// instance.disassociate(forKey: "greeting")
  /// ```
  func disassociate(forKey key: String) {
    let keyPointer = UnsafeRawPointer(bitPattern: key.hashValue)!
    objc_setAssociatedObject(self, keyPointer, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
  
  /// Disassociates all values associated with this instance.
  ///
  /// Example:
  /// ```
  /// class MyClass: Associable {}
  /// let instance = MyClass()
  /// instance.associate("Hello, World!", forKey: "greeting")
  /// instance.associate(42, forKey: "number")
  /// instance.disassociateAll()
  /// ```
  func disassociateAll() {
    objc_removeAssociatedObjects(self)
  }
}
