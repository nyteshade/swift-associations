//
//  Associable.swift
//  
//
//  Created by Brielle Harrison on 4/7/24.
//

import Foundation

/// Protocol that enables association of values with class instances.
public protocol Associable: AnyObject { }

public extension Associable {
  /// Associates a value with the current instance using a string key.
  func associate<T>(_ value: T, forKey key: String) {
    let keyPointer = UnsafeRawPointer(bitPattern: key.hashValue)!
    objc_setAssociatedObject(self, keyPointer, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
  
  /// Retrieves the associated value for the current instance using a string key.
  func associatedValue<T>(forKey key: String) -> T? {
    let keyPointer = UnsafeRawPointer(bitPattern: key.hashValue)!
    return objc_getAssociatedObject(self, keyPointer) as? T
  }
  
  /// Checks to see if a non-nil value is associated with the object and the supplied key
  ///
  /// - Parameter withKey: the key used to check for an associated value
  /// - 
  func isAssociated(withKey key:String) -> Bool {
    let keyPointer = UnsafeRawPointer(bitPattern: key.hashValue)!
    let value: Any? = objc_getAssociatedObject(self, keyPointer)
    
    return value != nil
  }
  
  /// Disassociates the value for the current instance for a given key.
  func disassociate(forKey key: String) {
    let keyPointer = UnsafeRawPointer(bitPattern: key.hashValue)!
    objc_setAssociatedObject(self, keyPointer, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
  
  /// Disassociates all values for the current instance.
  func disassociateAll() {
    objc_removeAssociatedObjects(self)
  }
}
