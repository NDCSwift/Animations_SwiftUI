//
        //
    //  Project: Animations_SwiftUI
    //  File: NavigationZoomDemo.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

// MARK: - Navigation Zoom Transition (iOS 18+)
//
// The zoom navigation transition creates a hero animation where a source element
// in the list/grid appears to "expand" into the destination screen.
// This is the same transition used throughout Apple's own apps (Photos, App Store).
//
// Two APIs work together:
//   - `.matchedTransitionSource(id:in:)` — marks the SOURCE view (the card in the list)
//   - `.navigationTransition(.zoom(sourceID:in:))` — applied to the DESTINATION view
//
// The shared @Namespace links them so SwiftUI knows which source maps to which destination.
// The zoom transition is handled entirely by NavigationStack — no withAnimation needed.

import SwiftUI

struct NavigationZoomDemo: View {

    // Namespace links the source card to its destination screen.
    // Must be the same namespace used in both matchedTransitionSource and navigationTransition.
    @Namespace private var ns

    var body: some View {

        // NavigationStack manages the push/pop stack. Always prefer it over NavigationView.
        NavigationStack {

            // NavigationLink pushes the destination onto the stack when tapped.
            NavigationLink {
                // MARK: Destination view
                // The zoom transition is declared HERE, on the destination, not the source.
                // `.navigationTransition(.zoom(sourceID:in:))` tells SwiftUI:
                //   "animate this screen entering/exiting by zooming from/to the source element
                //    with id 'card' in the `ns` namespace."
                Color.indigo
                    .ignoresSafeArea()
                    .navigationTransition(.zoom(sourceID: "card", in: ns))

            } label: {
                // MARK: Source view (the tappable card)
                // `.matchedTransitionSource(id:in:)` registers this view as the origin point
                // of the zoom. SwiftUI captures its frame and uses it as the start of the animation.
                RoundedRectangle(cornerRadius: 16)
                    .fill(.indigo.gradient)
                    .frame(width: 180, height: 100)
                    .matchedTransitionSource(id: "card", in: ns)
            }
        }
    }
}

#Preview {
    NavigationZoomDemo()
}
