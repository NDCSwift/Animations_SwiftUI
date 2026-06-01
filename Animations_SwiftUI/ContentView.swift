//
        //
    //  Project: Animations_SwiftUI
    //  File: ContentView.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

// MARK: - withAnimation — The Core Concept
//
// SwiftUI animates by comparing a view's state BEFORE and AFTER a change.
// When you wrap a state mutation in `withAnimation { }`, SwiftUI:
//   1. Records the current rendered state (the "from" snapshot)
//   2. Applies the state change
//   3. Computes the new rendered state (the "to" snapshot)
//   4. Interpolates every animatable property between them over time
//
// You don't animate properties directly — you animate STATE CHANGES.
// Every modifier that reads `isActive` will animate simultaneously.

import SwiftUI

struct ContentView: View {

    // @State makes `isActive` a source of truth owned by this view.
    // Toggling it causes SwiftUI to re-render the body and — when wrapped
    // in withAnimation — smoothly interpolate all animatable properties.
    @State private var isActive = false

    var body: some View {

        RoundedRectangle(cornerRadius: 20)
            .opacity(isActive ? 1.0 : 0.2)                    // ✓ 0.2 → 1.0  (animatable: CGFloat)
            .scaleEffect(isActive ? 1.2 : 1.0)                // ✓ 1.0 → 1.2  (animatable: CGFloat)
            .offset(x: isActive ? 0 : -20)                    // ✓ -20 → 0    (animatable: CGFloat)
            .rotationEffect(isActive ? .zero : .degrees(45))  // ✓ 0° → 45°   (animatable: Angle)
            .frame(width: isActive ? 200 : 100)               // ✓ 100 → 200  (animatable: CGFloat)
            .foregroundStyle(isActive ? .blue : .gray)        // ✓ color interpolation (animatable: Color)

            // NOTE: `.font` is NOT animatable — there is no interpolated state
            // between .body and .title. SwiftUI will still swap the font, but
            // it will do so as an instant cross-fade, not a smooth scale.
            .font(isActive ? .title : .body)

            .onTapGesture {
                // withAnimation wraps the state mutation.
                // The default animation is a spring — you can pass a custom one:
                //   withAnimation(.easeInOut(duration: 0.4)) { ... }
                //   withAnimation(.spring(duration: 0.5, bounce: 0.3)) { ... }
                withAnimation {
                    isActive.toggle()
                }
            }
    }
}

#Preview {
    ContentView()
}
