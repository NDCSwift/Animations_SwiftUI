//
        //
    //  Project: Animations_SwiftUI
    //  File: PhaseDemo.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

// MARK: - Phase Animations
//
// `PhaseAnimator` sequences a view through a series of discrete states (phases),
// animating between each one automatically. Think of it as a state machine where
// SwiftUI drives the transitions for you.
//
// Key differences vs withAnimation:
//   - withAnimation: you control WHEN the state changes
//   - PhaseAnimator: SwiftUI advances through ALL phases in order, then repeats
//     (or stops at the last phase when a trigger is used)
//
// With a `trigger:`, the animator runs through all phases once each time the
// trigger value changes, then rests at the final phase.
// Without a trigger, it loops continuously (great for idle/loading animations).

// NOTE: The enum is declared BEFORE the import so it's available at global scope.
// This is valid Swift — imports don't need to come first.

// CaseIterable automatically synthesizes `allCases` — an array of every case in order.
// PhaseAnimator uses `allCases` to know the sequence of phases to step through.
enum SyncPhase: CaseIterable {
    case idle       // resting state — small, faded circle
    case syncing    // activity state — full size, yellow
    case done       // success state — full size, green
}

import SwiftUI

struct PhaseDemo: View {

    // Incrementing tapCount advances the PhaseAnimator through its phases once.
    @State private var tapCount = 0

    var body: some View {

        // PhaseAnimator(phases, trigger:) { phase in ... } animation: { phase in ... }
        //
        //   phases:    the collection to cycle through (SyncPhase.allCases = [.idle, .syncing, .done])
        //   trigger:   re-starts the sequence from .idle whenever tapCount changes
        //   content:   the view to render for the current phase — `phase` tells you which one
        //   animation: the curve used to ARRIVE at each phase (the transition INTO that phase)
        PhaseAnimator(SyncPhase.allCases, trigger: tapCount) { phase in

            // The circle's appearance is determined entirely by which phase is active.
            // SwiftUI interpolates color, scale, and opacity between phases.
            Circle()
                .fill(phase == .idle ? .gray : phase == .syncing ? .yellow : .green)
                .frame(width: 100)
                .scaleEffect(phase == .idle ? 0.4 : 1)      // small when idle, full size otherwise
                .opacity(phase == .idle ? 0.4 : 1.0)        // faded when idle, opaque otherwise

        } animation: { phase in
            // Each phase can use a different animation curve for its entrance.
            // This closure returns the animation used to TRANSITION INTO `phase`.
            switch phase {
            case .idle:    .easeIn(duration: 0.5)    // slow fade back to resting state
            case .syncing: .spring(duration: 0.5)    // springy pop as activity begins
            case .done:    .easeOut(duration: 0.5)   // smooth deceleration on completion
            }
        }

        Button("Count") {
            tapCount += 1   // triggers one full pass through idle → syncing → done
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    PhaseDemo()
}
