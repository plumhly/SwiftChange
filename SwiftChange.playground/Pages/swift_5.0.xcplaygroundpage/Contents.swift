//: [Previous](@previous)

import Foundation



//1.compactMapValues
do {
    let person = ["name": "li", "age": nil]
    let dic = person.compactMapValues { $0 } // ["name": "li"]
//    print(dic)
    
    let times = [
        "Hudson": "38",
        "Clarke": "42",
        "Robinson": "35",
        "Hartis": "DNF"
    ]
    
    let finisher1 = times.mapValues(Int.init)
    print(finisher1)
    
    let finisher2 = times.compactMapValues(Int.init)
    print(finisher2)
}


// 2 Checking for integer multiples
do {
    print(4.isMultiple(of: 2))
}

// 3 Flattening nested optionals resulting from try?
do {
    struct User {
        var id: Int
        init?(id: Int) {
            if id < 1 {
                return nil
            }
            self.id = id
        }
        
        func getMessage() throws -> String? {
            return "哈哈哈"
        }
    }
    
    let user = User(id: 1)
    let name = try? user?.getMessage()
    //Optional Chain 不会叠加Optional
    #if swift(>=5.1)
        print("swift 5.1")
    #endif
}

//4. Dynamically callable types
//@dynamicMemberLookup, and serves the same purpose: to make it easier for Swift code to work alongside dynamic languages such as Python and JavaScript.
//You can apply it to structs, enums, classes, and protocols.
//If you implement withKeywordArguments: and don’t implement withArguments:, your type can still be called without parameter labels – you’ll just get empty strings for the keys.
//If your implementations of withKeywordArguments: or withArguments: are marked as throwing, calling the type will also be throwing.
//You can’t add @dynamicCallable to an extension, only the primary definition of a type.
//You can still add other methods and properties to your type, and use them as normal.
do {
    @dynamicCallable
    struct RandomNumberGenerator {
        func generatoe(numberOfZeroes: Int) -> Double {
            let max = pow(10, Double(numberOfZeroes))
            return Double.random(in: 0...max)
        }
        
        func dynamicallyCall(withKeywordArguments args: KeyValuePairs<String, Int>) -> Double {
            let numberOfZeroes = Double(args.first?.value ?? 0)
            let maximum = pow(10, numberOfZeroes)
            return Double.random(in: 0...maximum)
        }
        
//        func dynamicallyCall(withArguments args: [Int]) -> Double {
//            let number = Double(args[0])
//            let max = pow(10, number)
//            return Double.random(in: 0...max)
//        }
    }
    
    let random = RandomNumberGenerator()
//    let result = random.generatoe(numberOfZeroes: 1)
    let result1 = random(a: 1)
    let result2 = random(0)
    
}

//5.Customizing string interpolation

//To make this work, we need to fulfill some specific criteria:
// * Whatever type we create should conform to ExpressibleByStringLiteral, ExpressibleByStringInterpolation, and CustomStringConvertible. The latter is only needed if you want to customize the way the type is printed.
// * Inside your type needs to be a nested struct called StringInterpolation that conforms to StringInterpolationProtocol.
// * The nested struct needs to have an initializer that accepts two integers telling us roughly how much data it can expect.
// * It also needs to implement an appendLiteral() method, as well as one or more appendInterpolation() methods.
// * Your main type needs to have two initializers that allow it to be created from string literals and string interpolations

struct User {
    var name: String
    var age: Int
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: User) {
        appendInterpolation("My name is \(value.name) and I'm \(value.age)")
    }
    
    mutating func appendInterpolation(_ number: Int, style: NumberFormatter.Style) {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        if let result = formatter.string(from: number as NSNumber) {
            appendLiteral(result)
        }
    }
    
    mutating func appendInterpolation(repeat str: String, _ count: Int) {
        for _ in 0 ..< count {
            appendLiteral(str)
        }
    }
    
    mutating func appendInterpolation(_ values: [String], empty defaultValue: @autoclosure () -> String) {
        if values.isEmpty {
            appendLiteral(defaultValue())
        } else {
            appendLiteral(values.joined(separator: ", "))
        }
    }
}

//let user = User(name: "plum", age: 28)
//print("User details:\(user)")
//print(user)

//let number = Int.random(in: 0...100)
//let lucky = "The lucky number this week is \(number, style: .spellOut)"
//print(lucky)

//print("body shark\(repeat: "doo", 8)")

let names = [String]()
print("List of students: \(names, empty: "No none")")

struct HTMLComponent: ExpressibleByStringLiteral, ExpressibleByStringInterpolation, CustomStringConvertible {
    
    struct StringInterpolation: StringInterpolationProtocol {
        var out = ""
        init(literalCapacity: Int, interpolationCount: Int) {
            print("\(literalCapacity), \(interpolationCount)")
            out.reserveCapacity(literalCapacity * 2)
        }
        
        mutating func appendLiteral(_ literal: String) {
            print("Literal Appending \(literal)")
            out.append(literal)
        }
        
        mutating func appendInterpolation(twitter: String) {
            print("twitter Appending \(twitter)")
            out.append("<a href=\"https://twitter/\(twitter)\">@\(twitter)</a>")
        }
        
        mutating func appendInterpolation(email: String) {
            print("email Appending \(email)")
            out.append("<a href=\"mailto:\(email)\">\(email)</a>")
        }
    }
    
    var description: String
    
    init(stringLiteral value: String) {
        print("====stringLiteral")
        description = value
    }
    
    init(stringInterpolation: StringInterpolation) {
        print("===stringInterpolation")
        description = stringInterpolation.out
    }
}

let text: HTMLComponent = "You should follow me on Twitter \(twitter: "twostraws"), or you can email me at \(email: "paul@hackingwithswift.com")."
let otherText: HTMLComponent = "哈哈哈"
print(text)
print(otherText)

// 6. A standard Result type
// * Result has a get() method that either returns the successful value if it exists, or throws its error otherwise.
// * Second, Result has an initializer that accepts a throwing closure: if the closure returns a value successfully that gets used for the success case, otherwise the thrown error is placed into the failure case.
// * Third, rather than using a specific error enum that you’ve created, you can also use the general Error protocol.

// 7.Raw strings
do {
    let name1 = "plum"
    let string = #"hi \(name1)"#
    print(string)
}
