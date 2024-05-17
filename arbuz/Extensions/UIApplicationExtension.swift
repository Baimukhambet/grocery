import UIKit

extension UIApplication {
    static let windowSize = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.bounds.size
    
}
