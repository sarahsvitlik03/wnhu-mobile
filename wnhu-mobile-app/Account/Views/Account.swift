//
//  Account.swift
//  wnhu-mobile
//
//  Created by Sarah Svitlik on 12/23/25.
//

import SwiftUI

struct Account: View {
    @EnvironmentObject var userData: UserData
    var fullName: String { "\(userData.user.firstName) \(userData.user.lastName)" }
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 0.98, green: 0.25, blue: 0.25),
                            Color(red: 0.60, green: 0.00, blue: 0.00)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .scaledToFit()
                .frame(width: 150)
                .foregroundColor(.white)
                .shadow(radius: 8)
                .padding(.top, 30)


            Text(fullName)
                .padding(.top, 5)
                .font(.title3.weight(.medium))
                .padding(.bottom, 1)
            Text(userData.user.email)
                .padding(.bottom, 10)
                .foregroundColor(.secondary)

            Divider()
                .frame(height: 1)
                .background(Color.white.opacity(0.3))
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            
            HStack {
                Image(systemName: "hand.thumbsup.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .padding(.trailing, 20 )
                    .padding(.leading, 25 )
                Text("Liked Songs")
                    .font(.system(size: 22))

            }
            .frame(maxWidth: 350, maxHeight: 100, alignment: .leading)
            .background( RoundedRectangle(cornerRadius: 16) .fill(Color.red.opacity(0.1)) )
            
                .padding(.bottom, 200)

        }
    }
}

#Preview {
    Account()
        .environmentObject(UserData())
}


/* Notes for next time
 *
 *   Circle at the top with picture of a person, name + unh email
 *   Make json data to pull from
 *   Have name, email, again
 *   Have liked songs be a pop up
 *   Account settings section
 *       Change name
 *       Change password
 *       Log out
 *
 *
 
 */

