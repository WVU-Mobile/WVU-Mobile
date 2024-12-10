//
//  EmergencyView.swift
//  WVU Mobile
//
//  Created by Kaitlyn Landmesser on 11/19/24.
//

import SwiftUI

struct EmergencyNumberModel: Hashable {
    let name: String
    let phoneNumber: String
    
    var url: URL? {
        let cleanString = phoneNumber.trimmingCharacters(in: CharacterSet(charactersIn: "-"))
        return URL(string: "tel://\(cleanString)")
    }
}

/// A view to present emergency services on campus.
struct EmergencyView: View {
    let emergencyNumbers: [EmergencyNumberModel] = [
        EmergencyNumberModel(
            name: "Emergency - 911",
            phoneNumber: "911"
        ),
        EmergencyNumberModel(
            name: "Carruth Center for Counseling and Psychological Services",
            phoneNumber: "304-293-4431"
        ),
        EmergencyNumberModel(
            name: "University Police Department",
            phoneNumber: "304-293-2677"
        ),
        EmergencyNumberModel(
            name: "Title IX anonymous on-call line",
            phoneNumber: "304-906-9930"
        ),
        EmergencyNumberModel(
            name: "Ruby Memorial Hospital",
            phoneNumber: "304-598-4000"
        )
    ]
    
    let otherNumbers: [EmergencyNumberModel] = [
        EmergencyNumberModel(
            name: "Student Help Line",
            phoneNumber: "304-293-5555"
        ),
        EmergencyNumberModel(
            name: "Mountaineer Parents Club Helpline",
            phoneNumber: "800-988-0096"
        ),
    ]

    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Styles.Colors.background1, Styles.Colors.background2]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                ScrollView (.vertical, showsIndicators: true) {
                    Spacer()
                    VStack {
                        Text("Available 24/7")
                            .font(Styles.Fonts.body)
                            .foregroundColor(Styles.Colors.text2)
                        VStack {
                            ForEach(emergencyNumbers, id: \.self) { model in
                                NumberView(model: model)
                            }
                        }.padding()
                        
                        Text("During University Hours")
                            .font(Styles.Fonts.body)
                            .foregroundColor(Styles.Colors.text2)
                            .padding()
                        VStack {
                            ForEach(otherNumbers, id: \.self) { model in
                                NumberView(model: model)
                            }
                        }.padding()
                    }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Emergency Resources")
                    .font(Styles.Fonts.toolbar)
                    .foregroundColor(Styles.Colors.text)
            }
        }
        .toolbarBackground(Styles.Colors.background1, for: .navigationBar)
    }
}

struct NumberView: View {
    var model: EmergencyNumberModel
    var body: some View {
        VStack {
            Button {
                if let url = model.url {
                    UIApplication.shared.open(url)
                }
            } label: {
                Text(model.name)
                    .font(Styles.Fonts.bodyStrong)
                    .foregroundColor(Styles.Colors.text2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 5)
                Text(model.phoneNumber)
                    .font(Styles.Fonts.body)
                    .foregroundColor(Styles.Colors.accentBlue)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding()
        .background(Styles.Colors.background2)
        .cornerRadius(Styles.Constants.cornerRadius)
        .shadow(color: Styles.Colors.shadow, radius: Styles.Constants.cornerRadius)
    }
}
