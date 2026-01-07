import Foundation
import SwiftUI

class UserData: ObservableObject {
    @Published var user = UserModel (
        firstName: "Sarah",
        lastName: "Svitlik",
        username: "sarahsvitlik",
        email: "ssvit1@unh.newhaven.edu",
        joinedDate: "01/05/2026"
    )
}

