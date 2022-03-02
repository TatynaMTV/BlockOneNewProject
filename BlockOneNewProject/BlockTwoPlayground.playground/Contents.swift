import UIKit

// Задание #1. Вычислить среднее значение двух переменных типа Double

let a = 2.1
let b = 3.7

var avarage = (a + b) / 2

// Задание #2. Создать кортеж со строковыми значениями и вывести их на консоль

var (firstName, lastName) = ("Nikita", "Petrov")
print("Full name: \(firstName) \(lastName)")

// Задание #3. Создать две опциональные переменные типа Float. Одной из них задать первоначальное значение. Написать функцию, которая принимает на вход опциональную переменную типа Float. Функция должна безопасно извлечь значение из входящей переменной. Если значение удалось получить - необходимо вывести его в консоль, если значение у переменной отсутствует вывести в консоль фразу "Variable can't be unwrapped". Вызвать функцию дважды с двумя ранее созданными переменными.

let firstVar: Float? = 1.8
let secondVar: Float? = nil

func unwrapped(variable: Float?) {
    if let newVar = variable {
        print("Variable: \(newVar)")
    } else {
        print("Variable can't be unwrapped")
    }
}

unwrapped(variable: firstVar)
unwrapped(variable: secondVar)

// Задание #4. Напиcать программу для вывода первых 15 чисел последовательности Фибоначчи

func fibonacci(n: Int) -> [Int] {
    var array = [0, 1]
    while array.count < n {
        array.append(array[array.count - 1] + array[array.count - 2])
    }
    return array
}

fibonacci(n: 15)

// Задание #5. Напишите программу для сортировки массива, использующую метод пузырька. Сортировка должна происходить в отдельной функции, принимающей на вход исходный массив.

var someIntArray = [3, 5, 7, 2, 0, 1, 6, 4]

func bubbleSort<T: Comparable>(array: inout [T]) -> [T] {
    for i in 0..<array.count {
        for j in 1..<array.count - i {
            if array[j] < array[j - 1] {
                let temp = array[j - 1]
                array[j - 1] = array[j]
                array[j] = temp
            }
        }
    }
    return array
}

bubbleSort(array: &someIntArray)

// Задание #6. Напишите программу, решающую задачу: есть входящая строка формата "abc123", где сначала идет любая последовательность букв, потом число. Необходимо получить новую строку, в конце которой будет число на единицу больше предыдущего, то есть "abc124".

