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
    
    var body: some View {
        
        Text("Create Your Profile")
        
        Divider()
            .frame(height: 1)
            .background(Color.black.opacity(0.3))
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
        
        TextField("First Name", text: $firstName)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .autocapitalization(.none)
        
        TextField("Last Name", text: $lastName)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .autocapitalization(.none)
        
        Toggle("UNH Student?", isOn: $isUNHStudent)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
        HStack {
            Text("Gender: ")
            Picker("Gender", selection: $gender ) {
                Text("Male").tag( "Male" )
                Text("Female").tag( "Female" )
                Text("Rather not say").tag( "Rather not say")
            }
            .pickerStyle(.menu)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
        }
        HStack {
            Text("Age:")
            Picker("Age", selection: $age) {
                ForEach(13...100, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(.menu)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
        }

        Button(action: {
            print("Button Press")
        }) {
            Text("Create Account")
        }
    }
}

#Preview {
    ProfileSetup()
}

/* Create a function that sends JSON data of the state variables after pressing create account */
