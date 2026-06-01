//
        //
    //  Project: Animations_SwiftUI
    //  File: Animations_SwiftUIApp.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

// MARK: - App Entry Point
// Every SwiftUI app needs exactly one struct marked @main.
// This is the application's launch point — the equivalent of main() in C/UIKit apps.

import SwiftUI

// @main tells the compiler "this is where the program starts."
// The struct must conform to the App protocol, which requires a `body` property
// that returns one or more Scenes.
@main
struct Animations_SwiftUIApp: App {

    // `body` describes the top-level structure of the app using Scenes.
    // A Scene manages a portion of the UI — on iPhone there's typically one,
    // but on iPad/Mac you can have multiple windows.
    var body: some Scene {

        // WindowGroup is the standard scene for document-style or single-window apps.
        // On iPhone it shows one window; on iPad/Mac it can create multiple windows.
        // The view passed here (ContentView) becomes the root of the entire view hierarchy.
        WindowGroup {
            ContentView()
        }
    }
}
