import UIKit

var str = "Hello, playground"

do {
    let firstNumber = 4
    let secondNumber = 2
    if firstNumber.isMultiple(of: secondNumber) {
        print("是倍数")
    }
}

do {
    let row = #"哈哈哈\"""\\\\"#
    let multiline = #"""
                        d交换机按房间安静甲方 ”“”“row"""\"""plain"""
                        mutlll
                    """#
    print(multiline)
}

do {
    var number = 0
    let stringNumber = "ieiie10020"
    stringNumber.forEach { number += $0.isNumber ? 1 : 0}
    print(number)
}

do {
    let username = "bond007"
    var letters = 0
//    swift 4.2
    username.unicodeScalars.forEach {
        letters += (65...90) ~= $0.value || (97...122) ~= $0.value ? 1 : 0
    }
    
//    swift 5
    username.unicodeScalars.forEach {
        letters += $0.properties.isAlphabetic ? 1 : 0
    }
    print(letters)
    
    print(Int("ten"))
}

do {
    enum Age {
        case old
        case new
//        case want
    }
    
    func test(age: Age) {
        switch age {
        case .old:
            print("old")
        @unknown default:
            print("哈哈哈")
        }
    }
    
    test(age: .new)
}

do {
    let dic = ["name": "plum", "age": nil]
    let other = dic.compactMapValues { $0 }
    print(other)
    
    #if swift(>=5)
        print("swoft")
    #endif
}

// MARK: - d
do {
    
}
