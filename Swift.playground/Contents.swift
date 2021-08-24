import Foundation

var numbers = [1,1,1,1,1]
var target = 3

var number: [Int] = []
var targets: Int = 0
var count: Int = 0

func solution(_ numbers:[Int], _ target:Int) -> Int {
    number = numbers
    targets = target
    
    calculrate(index: 0, sum: 0)

    return count
}

func calculrate(index: Int, sum: Int) {
    if index == number.count {
        if sum == targets {
            count += 1
        }
        return
    }
    calculrate(index: index + 1, sum: sum + number[index])
    calculrate(index: index + 1, sum: sum - number[index])
}
