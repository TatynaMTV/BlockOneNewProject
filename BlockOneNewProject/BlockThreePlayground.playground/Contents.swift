import UIKit

// Задание #1. Написать простое замыкание в переменной myClosure, замыкание должно выводить в консоль фразу "I love Swift". Вызвать это замыкание. Далее написать функцию, которая будет запускать заданное замыкание заданное количество раз. Объявить функцию так: func repeatTask (times: Int, task: () -> Void). Функция должна запускать times раз замыкание task . Используйте эту функцию для печати «I love Swift» 10 раз.

var myClosure: () -> Void = {
    print("I love Swift")
}

myClosure()

func repeatTask (times: Int, task: () -> Void) {
    for _ in 1...times { task() }
}

repeatTask(times: 10, task: myClosure)

// Задание #2. Условия: есть начальная позиция на двумерной плоскости, можно осуществлять последовательность шагов по четырем направлениям up, down, left, right. Размерность каждого шага равна 1. Создать перечисление Directions с направлениями движения.
// Создать переменную location с начальными координатами (0,0), создать массив элементами которого будут направления из перечисления. Положить в этот массив следующую последовательность шагов: [.up, .up, .left, .down, .left, .down, .down, .right, .right, .down, .right]. Програмно вычислить какие будут координаты у переменной location после выполнения этой последовательности шагов.

enum Directions {
    case up   // swiftlint:disable:this identifier_name
    case down
    case left
    case right
}

var location = (0, 0)
let stepsArray: [Directions] = [.up, .up, .left, .down, .left, .down, .down, .right, .right, .down, .right]

func steps(point: (Int, Int), steps: [Directions]) -> (Int, Int) {
  var x = point.0 // swiftlint:disable:this identifier_name
  var y = point.1 // swiftlint:disable:this identifier_name

    for step in steps {
        switch step {
        case .up: y += 1
        case .down: y -= 1
        case .left: x -= 1
        case .right: x += 1
        }
    }

    let newPoint = (x, y)
    return newPoint
}

var newLocation = steps(point: location, steps: stepsArray)

// Задание #3. Создать класс Rectangle с двумя неопциональными свойствами: ширина и длина. Реализовать в этом классе метод вычисляющий и выводящий в консоль периметр прямоугольника. Создать экземпляр класса и вызвать у него этот метод.

class Rectangle {
    var length: Float
    var width: Float
    init(length: Float, width: Float) {
        self.length = length
        self.width = width
    }

    func perimetr() {
        let perimetr = 2 * (length + width)
        print(perimetr)
    }
}

var newRectangle = Rectangle(length: 5, width: 2)
newRectangle.length
newRectangle.width
newRectangle.perimetr()

// Задание #4. Создать расширение класса Rectangle, которое будет обладать вычисляемым свойством площадь. Вывести в консоль площадь уже ранее созданного объекта.

extension Rectangle {
    var square: Float {
        length * width
    }
}

let sqareNewRectangle = newRectangle.square
print(sqareNewRectangle)
