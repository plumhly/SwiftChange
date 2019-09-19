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
    let s = user?.getMessage()
    //Optional Chain 不会叠加Optional
}
