# Associable

Associable is a Swift package that provides a protocol for associating values with class instances using the Objective-C runtime. This allows you to add custom data to any class instance without modifying the class definition itself.

## Features

- Associate values with class instances using a key
- Retrieve associated values using a key
- Check if a value is associated with a key
- Disassociate values for a specific key
- Disassociate all associated values

## Installation

### Swift Package Manager

To install Associable using Swift Package Manager, add the following line to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/your-username/Associable.git", from: "1.0.0")
]
```

## Usage

1. Import the Associable package in your Swift file:

```swift
import Associable
```

2. Make your class conform to the `Associable` protocol:

```swift
class MyClass: Associable {}
```

3. Associate a value with an instance of your class:

```swift
let instance = MyClass()
instance.associate("Hello, World!", forKey: "greeting")
```

4. Retrieve the associated value:

```swift
let greeting: String? = instance.associatedValue(forKey: "greeting")
print(greeting) // Outputs "Hello, World!"
```

5. Check if a value is associated with a key:

```swift
if instance.isAssociated(withKey: "greeting") {
    print("A greeting is associated")
} else {
    print("No greeting is associated")
}
```

6. Disassociate a value for a specific key:

```swift
instance.disassociate(forKey: "greeting")
```

7. Disassociate all associated values:

```swift
instance.disassociateAll()

// also for any class that is Associable
deinit {
  disassociateAll()
}
```

## License

Associable is released under the MIT License.
