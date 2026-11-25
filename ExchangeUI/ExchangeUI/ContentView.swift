import SwiftUI
import ExchangeEngine

enum AppTabs {
    
    case home, trade, learn
    
}

struct ContentView: View {
    
    @State private var selectedTab: AppTabs = .home
    @State private var book: OrderBook = (try? OrderBook.sample()) ?? OrderBook()
        
    var body: some View {
        
        TabView {
            
            Tab("Home" ,systemImage: "house") {
                
                HomeView()
                
            }
            
            Tab("Trade", systemImage: "chart.bar.fill") {
                
                
                
            }
            
            Tab("Learn", systemImage: "book.fill") {
                
                
                
            }
            
        }
    
    }
}

#Preview {
    ContentView()
}
