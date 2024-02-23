class Shape {
    var area : Double

    init(area: Double) {
        self.area = area
    }
}

class Square : Shape {
    var width : Double
    var height : Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
        super.init(area: height * width)
    }
}

class Circle : Shape {
    var radius : Double

    init(radius: Double) {
        self.radius = radius
        super.init(area: 2 * 3.14 * radius * radius)
    }
}

class House {
    var width: Int
    var height: Int
    var isDestroyed: Bool = false
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    func create() {
        let area = width * height
        print("Создан дом площадью: \(area) м^2")
    }
    
    func destroy() {
        isDestroyed = true
        print("Дом уничтожен")
    }
}

let myHouse = House(width: 10, height: 20)
myHouse.create()
myHouse.destroy()

class Student: Comparable {
    var fullName: String
    var age: Int
    
    init(fullName: String, age: Int) {
        self.fullName = fullName
        self.age = age
    }
    
    static func < (o1: Student, o2: Student) -> Bool {
        return o1.fullName < o2.fullName || (o1.fullName == o2.fullName && o1.age < o2.age)
    }
    
    static func == (o1: Student, o2: Student) -> Bool {
        return o1.fullName == o2.fullName && o1.age == o2.age
    }
}

var students = [
    Student(fullName: "Дима Блин", age: 20),
    Student(fullName: "Аня Смит", age: 18),
    Student(fullName: "Кирилл Соболь", age: 22)
]

students.sort { $0.fullName < $1.fullName }
students.forEach { print($0.fullName) }

students.sort { $0.age < $1.age }
students.forEach { print($0.fullName, $0.age) }

//Структура имеет конструктор по умолчанию со всеми полями.
//Её поля иммутабельны, если экземпляр объявлен иммутабельным
//Базово её значение копируется, а не передаётся по ссылке.
//Это значит, что в функции, при присваивании, в массиве мы работаем с копией экземпляра, и значения "исходника" не меняются.
//От структуры нельзя сделать наследование
struct structPoint {
    var x: Int
    var y: Int
}

//Если поля не optional, нужен конструктор по умолчанию
//При отправлении объекта в функцию как параметр, в функцию передаётся ссылка. Т.е. изменения в функции распространяются на "оригинал".
//То же самое и с массивом и присваиванием, но как я понял это условно подходит под функцию
//Можно наследоваться от класса
class classPoint {
    var x: Int?
    var y: Int?
}

enum Suit: String, CaseIterable {
    case hearts = "Черви"
    case diamonds = "Бубны"
    case clubs = "Крести"
    case spades = "Пики"
}

enum Rank: String, CaseIterable {
    case two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9", ten = "10"
    case jack = "Джокер", queen = "Королева", king = "Король", ace = "Туз"
}

struct Card {
    let rank: Rank
    let suit: Suit
    
    var description: String {
        return "\(rank.rawValue) \(suit.rawValue)"
    }
}

func generateDeck() -> [Card] {
    var deck = [Card]()
    for suit in Suit.allCases {
        for rank in Rank.allCases {
            let card = Card(rank: rank, suit: suit)
            deck.append(card)
        }
    }
    return deck
}

func dealHand(from deck: [Card]) -> [Card] {
    var shuffledDeck = deck
    shuffledDeck.shuffle()
    return Array(shuffledDeck.prefix(5))
}

func checkForFlush(_ hand: [Card]) -> Bool {
    let firstSuit = hand[0].suit
    return hand.allSatisfy { $0.suit == firstSuit }
}

func checkHand(_ hand: [Card]) {
    print("Комбинация:")
    for card in hand {
        print(" - \(card.description)")
    }
    
    if checkForFlush(hand) {
        print("У вас флэш!")
    } else {
        print("У вас не флэш.")
    }
}

let deck = generateDeck()
let hand = dealHand(from: deck)

checkHand(hand)