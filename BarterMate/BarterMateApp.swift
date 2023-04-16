//
//  BarterMateApp.swift
//  BarterMate
//
//  Created by mark on 12/3/2023.
//

import SwiftUI
import Amplify
import AWSDataStorePlugin
import AWSCognitoAuthPlugin
import AWSAPIPlugin
import AWSS3StoragePlugin

@main
struct BarterMateApp: App {
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

func configureAmplify() {
//    Amplify.Logging.logLevel = .verbose
    let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
    do {
        try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
        try Amplify.add(plugin: dataStorePlugin)
        try Amplify.add(plugin: AWSCognitoAuthPlugin())
        try Amplify.add(plugin: AWSS3StoragePlugin())
        try Amplify.configure()
        
        Task {
            do {
                try await Amplify.DataStore.delete(Transaction.self, withId: "E190F3D1-3EFA-4CF8-97CE-3AD5760EF7E7")
                try await Amplify.DataStore.delete(Transaction.self, withId: "8EB44DAB-F6BF-4CE2-B85E-D5E5150A3106")
                try await Amplify.DataStore.delete(Transaction.self, withId: "7B00059A-F097-4C08-BE09-39A1321C36A6")
                try await Amplify.DataStore.delete(Transaction.self, withId: "8C48B208-3BE7-42E9-8D5C-3300B1AC99B1")
                try await Amplify.DataStore.delete(Transaction.self, withId: "2CCF0E47-B9A8-4E76-97F0-F18404779E2B")
                try await Amplify.DataStore.delete(Transaction.self, withId: "dfdec700-c550-4fdf-8127-14018d0b7eb1")
                try await Amplify.DataStore.delete(Transaction.self, withId: "6CDED78E-0CA2-40B0-A027-6B4003517EA7")
                try await Amplify.DataStore.delete(Transaction.self, withId: "76FD4BB7-AF83-4B18-9648-054CDBBA7704")
                try await Amplify.DataStore.delete(Transaction.self, withId: "1A287780-DAAC-4A45-AA86-DDB9856DB4A9")
                try await Amplify.DataStore.delete(Transaction.self, withId: "AA78AD07-8F21-4783-8B28-32668A72649A")
                try await Amplify.DataStore.delete(Transaction.self, withId: "76DFB7F7-2C84-435F-A96E-18F20CD19A7D")
                try await Amplify.DataStore.delete(Transaction.self, withId: "B66E8785-2743-443F-AAA1-A6B887458557")
                try await Amplify.DataStore.delete(Transaction.self, withId: "8ECE65E8-9009-4028-8EAE-9A220C24811C")

                
            } catch {
                print("cannot delete")
            }
        }

        print("Initialized Amplify");
    } catch {
        // simplified error handling for the tutorial
        print("Could not initialize Amplify: \(error)")
    }
}

