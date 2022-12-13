//
//  Sustainable_CalculatorApp.swift
//  Sustainable Calculator
//
//  Created by Toby on 25/08/2022.
//


// adding swiftUI dependecny
import SwiftUI
import Foundation

// adding database dependency
import FirebaseCore
import Firebase
// import FirebaseFirestore
// import FirebaseAuth


@main
struct gkhApp: App {
    // register app delegate for Firebase setup
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}

