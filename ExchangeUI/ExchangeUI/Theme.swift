import SwiftUI

extension Color {

    static let ocean = Color(red: 61/255, green: 111/255, blue: 217/255)
    static let sky = Color(red: 91/255, green: 141/255, blue: 239/255)
    static let mist = Color(red: 234/255, green: 241/255, blue: 253/255)
    static let cloud = Color(red: 247/255, green: 249/255, blue: 252/255)
    static let softGreen = Color(red: 59/255, green: 170/255, blue: 122/255)
    static let softRed = Color(red: 224/255, green: 99/255, blue: 107/255)
    
}

extension View {
    
    func card() -> some View {
            
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(
                Color(.secondarySystemGroupedBackground),
                in: RoundedRectangle(cornerRadius: 20, style: .continuous)
            )
            .shadow(color: .ocean.opacity(0.08), radius: 12, y: 4)
        
    }
    
}

