import SwiftUI
import ExchangeEngine

extension View {
    
    func card() -> some View {
        
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 16))
    }
    
}

struct ContentView: View {
    
    @AppStorage("name") var name: String = ":)"
    
    var greeting: String {
        
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
            
            case 6..<12: return "Good Morning, " + name + "!"

            case 12: return "Good Noon, " + name + "!"
            
            case 13..<17: return "Good Afternoon, " + name + "!"
            
            case 17..<22: return "Good Evening, " + name + "!"
            
            default: return "Good Night, " + name + "!"

            
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
                
                VStack(alignment: .leading, spacing: 16) {

                    Button("The cool programmer :)") {
                        
                        name = "Dvir"
                        
                    }
                    Text(greeting)
                        .font(.largeTitle)
                        .bold()
                    Divider()
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Your Portfolio")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .bold()
                        Text(10000, format: .currency(code: "USD"))
                            .font(.largeTitle)
                            .bold()
                        Text("▲ +10.00% this week")
                            .font(.caption)
                            .foregroundStyle(.green)
                            .bold()

                    }
                    .card()
                    Divider()
                    HStack(spacing: 16) {
                        
                        VStack(alignment: .leading, spacing: 16) {
                            
                            Text("Best Bid")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .bold()
                            
                            if let bid = book.bestBid {
                                
                                Text(Double(bid) / 100, format: .currency(code: "USD"))
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.green)
                                
                            } else {
                                
                                Text("-")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.gray)
                                
                            }
                        
                        }
                        .card()
                        VStack(alignment: .leading, spacing: 16) {
                            
                            Text("Best Ask")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .bold()
                            
                            if let ask = book.bestAsk {
                                

                                Text(Double(ask) / 100, format: .currency(code: "USD"))
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.red)
                            
                            } else {
                                
                               Text("-")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.gray)
                                
                            }
                            
                        }
                        .card()
                    }
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

            }
            
        }
            
    }
}

#Preview {
    ContentView()
}
