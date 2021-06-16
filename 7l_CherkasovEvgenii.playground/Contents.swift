import UIKit

struct Car{
    var mark: String
    var year: Int
    var status: State
    var priceForDay: Int
    var book: [Int: (startDate: Int, endDate: Int)]?
    
    enum State{
        case Active
        case NotActive
        case OnRent
    }
}

enum RentCarError: Error{
    case alreadyRented
    case invalidCarName
    case insufficientFunds(monyNeeded: Int)
}


class CarRent{
    var carPark = [ "Toyota 2010": Car(mark: "Toyota", year: 2010, status: .OnRent, priceForDay: 1200),
                    "Skoda 2021": Car(mark: "Skoda", year: 2021, status: .Active, priceForDay: 2300),
                    "Audi 2016": Car(mark: "Audi", year: 2016, status: .OnRent, priceForDay: 1500, book: [1: (2021_01_01, 2021_01_03)])
                    
    ]
    
    func rent(rent rentCarName: String,forDays numberOfDays: Int ) throws ->  Car{
        guard let car = carPark[rentCarName] else {
            throw RentCarError.invalidCarName
        }
        guard car.status != .OnRent else {
            throw RentCarError.alreadyRented
        }

        var price = numberOfDays * car.priceForDay
        
        carPark[rentCarName]?.status = .OnRent
        
        return carPark[rentCarName]!
    }
}

let myCarRent = CarRent()
do{
   try myCarRent.rent(rent: "Skoda 2021", forDays: 2)
}catch RentCarError.alreadyRented{
    print("Автомобиль уже забронирован")
}catch RentCarError.invalidCarName{
    print("Данного автомобиля нет в наличии")
}

