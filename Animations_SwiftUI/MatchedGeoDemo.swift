//
        //
    //  Project: Animations_SwiftUI
    //  File: MatchedGeoDemo.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

// MARK: - Matched Geometry Effect
//
// `.matchedGeometryEffect` makes two completely separate views in the hierarchy
// appear to be the SAME view morphing between states.
//
// How it works:
//   1. You create a shared coordinate namespace with @Namespace.
//   2. Tag two views with the SAME `id` and `in:` namespace.
//   3. Only one of those views should be visible at a time (use if/else).
//   4. When the visible view swaps (inside withAnimation), SwiftUI animates
//      the position, size, and shape from the old view's frame to the new one's.
//
// Classic use-cases: card expand/collapse, grid → detail, tab bar icons.
//
// Key rule: only ONE view with a given id should be in the hierarchy at once.
// Having both visible simultaneously causes a layout conflict and visual glitches.

import SwiftUI

struct MatchedGeoDemo: View {

    // @Namespace creates a named coordinate space shared across this view tree.
    // Views tagged with the same namespace + id are treated as geometric siblings.
    @Namespace private var ns

    @State private var isExpanded = false

    var body: some View {

        // ZStack is used here so both branches occupy the same layout space.
        // The `if/else` ensures only ONE view with id "shape" exists at a time.
        ZStack {
            if isExpanded {
                // MARK: Expanded state — full-screen card
                RoundedRectangle(cornerRadius: 24)
                    .fill(.blue.gradient)
                    // Tags this view as the "shape" participant in the `ns` namespace.
                    // SwiftUI will animate FROM the collapsed card's frame TO this frame.
                    .matchedGeometryEffect(id: "shape", in: ns)
                    .zIndex(1)                  // keeps the expanding card above other content
                    .ignoresSafeArea()           // stretches to screen edges when expanded
                    .onTapGesture {
                        // A slower spring with minimal bounce feels natural for collapsing —
                        // the card "deflates" gently back into the thumbnail.
                        withAnimation(.spring(duration: 0.5, bounce: 0.4)) {
                            isExpanded = false
                        }
                    }
            } else {
                // MARK: Collapsed state — thumbnail card
                RoundedRectangle(cornerRadius: 12)
                    .fill(.blue.gradient)
                    .frame(width: 160, height: 100)
                    // Same id + namespace as the expanded view above.
                    // SwiftUI uses this to know these two views are geometrically linked.
                    .matchedGeometryEffect(id: "shape", in: ns)
                    .onTapGesture {
                        // A longer spring with low bounce suits expansion —
                        // the card slides out smoothly without feeling rubbery.
                        withAnimation(.spring(duration: 1.0, bounce: 0.1)) {
                            isExpanded = true
                        }
                    }
            }
        }
    }
}

#Preview {
    MatchedGeoDemo()
}
