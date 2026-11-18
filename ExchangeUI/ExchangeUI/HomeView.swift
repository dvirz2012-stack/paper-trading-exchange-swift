import SwiftUI
import ExchangeEngine

struct HomeView: View {
    
    var greeting: String {
        
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
            
            case 6..<12: return "Good Morning!"

            case 12: return "Good Noon!"
            
            case 13..<17: return "Good Afternoon!"
            
            case 17..<22: return "Good Evening!"
            
            default: return "Good Night!"

            
        }
        
    }
    
    let book: OrderBook = (try? runEngine()) ?? OrderBook()
    var maxQuantity: Int {
        
        (book.buyersDepth + book.sellersDepth).map { $0.quantity}.max() ?? 1
        
    }
    
    static func runEngine() throws -> OrderBook {
        
        let book: OrderBook = OrderBook()
        let buyOrder1: Order = try Order(side: Side.buy, quantity: 5, price: 10000, type: OrderType.limit)
        let buyOrder2: Order = try Order(side: Side.buy, quantity: 4, price: 10100, type: OrderType.limit)
        let sellOrder1: Order = try Order(side: Side.sell, quantity: 5, price: 10200, type: OrderType.limit)
        let sellOrder2: Order = try Order(side: Side.sell, quantity: 4, price: 10300, type: OrderType.limit)
        
        book.addOrder(order: buyOrder1)
        book.addOrder(order: buyOrder2)
        book.addOrder(order: sellOrder1)
        book.addOrder(order: sellOrder2)
       
        return book
    }
    
    
    var body: some View {
        
        TabView {
            
            Tab("Home", systemImage: "house") {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text(greeting)
                    
                }
                Spacer()
                
            }
            
        }
            
    }
}

