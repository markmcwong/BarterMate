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
        AppServiceManager.shared.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

func configureAmplify() {
    let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
    do {
        //Amplify.Logging.logLevel = .verbose
        try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
        try Amplify.add(plugin: dataStorePlugin)
        try Amplify.add(plugin: AWSCognitoAuthPlugin())
        try Amplify.add(plugin: AWSS3StoragePlugin())
        try Amplify.configure()
        print("Initialized Amplify");
    } catch {
        // simplified error handling for the tutorial
        print("Could not initialize Amplify: \(error)")
    }
}
