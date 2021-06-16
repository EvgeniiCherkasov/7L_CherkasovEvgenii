import UIKit

struct Car{
    var mark: String
    var year: Int
    var status: State
    var priceForDay: Int
    
    enum State{
        case Active
        case NotActive
        case OnRent
    }
}

enum RentCarError: Error{
    case alreadyRented
    case invalidCarName
    case notActiveCar
    case insufficientFunds(monyNeeded: Int)
}


class CarRent{
    var carPark = [ "Toyota 2010": Car(mark: "Toyota", year: 2010, status: .NotActive, priceForDay: 1200),
                    "Skoda 2021": Car(mark: "Skoda", year: 2021, status: .OnRent, priceForDay: 2300),
                    "Audi 2016": Car(mark: "Audi", year: 2016, status: .Active, priceForDay: 1500)
                    
    ]
    
    func rent(rent rentCarName: String,forDays numberOfDays: Int ) throws ->  Car{
        guard let car = carPark[rentCarName] else {
            throw RentCarError.invalidCarName
        }
        guard car.status != .OnRent else {
            throw RentCarError.alreadyRented
        }

        guard car.status != .NotActive else {
            throw RentCarError.notActiveCar
        }

        let price = numberOfDays * car.priceForDay
        
        print("Автомобиль \(carPark[rentCarName]!.mark) \(carPark[rentCarName]!.year) арендован на \(numberOfDays) дня.\nСтоимость аренды \(price)")
        
        carPark[rentCarName]?.status = .OnRent
        
        return carPark[rentCarName]!
    }
}

func callRentFunc(car: String, numberOfDays: Int) throws{
    
    let myCarRent = CarRent()

    do{
        try myCarRent.rent(rent: car, forDays: numberOfDays)
    }catch RentCarError.alreadyRented{
        print("Автомобиль \(myCarRent.carPark[car]!.mark) \(myCarRent.carPark[car]!.year) уже забронирован")
    }catch RentCarError.invalidCarName{
        print("Данного автомобиля нет в наличии")
    }catch RentCarError.notActiveCar{
        print("Автомобиль не доступен")
    }
}

try! callRentFunc(car: "Skoda 2021", numberOfDays: 2)
try! callRentFunc(car: "Toyota 2010", numberOfDays: 3)
try! callRentFunc(car: "Audi 2016", numberOfDays: 2)

