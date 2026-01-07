import Foundation
import SwiftUI

final class UserData: ObservableObject {
    @Published var firstName: String
    @Published var lastName: String
    @Published var email: String
    @Published var age: Int
    @Published var gender: String
    @Published var unhStudent: Bool
    
    
    init(firstName: String = "Sarah", lastName: String = "Svitlik", email: String = "ssvit1@unh.newhaven.edu", age: Int = 22, gender: String = "Female", unhStudent: Bool = true) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.age = age
        self.gender = gender
        self.unhStudent = unhStudent
    }
}
