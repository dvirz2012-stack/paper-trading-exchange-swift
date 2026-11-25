import SwiftUI
import ExchangeEngine

public enum AppTab {

    case home, learn

}

struct HomeView: View {
    
    var greeting: String {
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
            
            case 7..<12: return "Good Morning, "
            case 12..<17: return "Good Afternoon, "
            case 17..<20: return "Good Evening, "
            case 5..<7: return "Here's our early bird, "
            default: return "Here's our night owl, "
            
        }
        
    }
    
    @AppStorage("name") var name: String = "Dvir"
    
    var body: some View {
            
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        Text(greeting)
                            .fontDesign(.rounded)
                            .bold()
                            .font(.title3)
                            .foregroundStyle(.gray)
                        Text("\(name)!")
                            .fontDesign(.rounded)
                            .bold()
                            .font(.largeTitle)
                    
                    }
                    Spacer()
                    Circle()
                        .fill(Color.mist)
                        .frame(width: 52, height: 52)
                        .overlay {
                            
                            Text("🐛")
                                .font(.largeTitle)
                                .fontDesign(.rounded)
                                
                            
                        }
                    
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Your Portfolio")
                        .fontDesign(.rounded)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.gray)
                    Text(10000, format: .currency(code: "USD"))
                        .fontDesign(.rounded)
                        .font(.largeTitle)
                        .bold()
                        .monospacedDigit()
                        .foregroundStyle(Color.softGreen)
                    Text("▲ 10.00%  this week")
                        .fontDesign(.rounded)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Color.softGreen)
                    
                    
                }
                .card()
                
            }
            .padding(20)
            
        }
        .fontDesign(.rounded)
        .background(Color.cloud)
        
    }
    
}

#Preview {
    HomeView()
}
