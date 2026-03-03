//
//  ProfileSetup.swift
//  wnhu-mobile-app
//
//  Created by Sarah Svitlik on 1/19/26.
//

import SwiftUI

struct ProfileSetup: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var isUNHStudent: Bool = false
    @State var age: Int = 0
    @State var gender: String = ""
    @State var isMobile: Bool = true
    @State var isAdmin: Bool = false
    @EnvironmentObject var userData: UserData
    @State private var navigateToStream = false

    
    var body: some View {
        VStack {
            Text("Setup Your WNHU Profile")
                .foregroundStyle(.primary)
            
            Divider()
                .frame(height: 1)
                .background(Color.secondary.opacity(0.3))
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            
            TextField("First Name", text: $firstName)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(20)
                .textInputAutocapitalization(.never)
                .foregroundStyle(.primary)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            
            TextField("Last Name", text: $lastName)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(20)
                .textInputAutocapitalization(.never)
                .foregroundStyle(.primary)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            
            Toggle("UNH Student", isOn: $isUNHStudent)
                .foregroundStyle(.primary)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(20)
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            
            HStack {
                Text("Gender:")
                    .frame(width: 100, alignment: .leading)
                    .foregroundStyle(.secondary)
                Picker("Gender", selection: $gender ) {
                    Text("Male").tag( "Male" )
                    Text("Female").tag( "Female" )
                    Text("Rather not say").tag( "Rather not say")
                }
                .pickerStyle(.menu)
                .foregroundStyle(.primary)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(20)
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
            
            HStack {
                Text("Age:")
                    .frame(width: 100, alignment: .leading)
                    .foregroundStyle(.secondary)
                Picker("Age", selection: $age) {
                    ForEach(13...100, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .pickerStyle(.menu)
                .foregroundStyle(.primary)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(20)
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
            
            Button("Create Account") {
                createUser { success in
                    print("Created:", success)
                    print("Button pressed")
                }
            }

        }
        .tint(.red)
        .background(Color(.systemBackground))
    }
    
    /* Creates user */
    func createUser(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:8000/createUserMobile") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let body: [String: Any] = [
            "email": userData.user.email,
            "first": firstName,
            "last": lastName,
            "gender": gender,
            "age": age,
            "isUNHStudent": isUNHStudent,
            "mobile_or_web": isMobile,
            "is_admin": isAdmin,
            "dateCreated": Date().description
        ]
        
        print(body)
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let http = response as? HTTPURLResponse {
                completion(http.statusCode == 200)   
            } else {
                completion(false)
            }
        } .resume()
    }
}

#Preview {
    ProfileSetup().environmentObject(UserData())
}

