//
//  NoEntryView.swift
//  FitnessBuddy
//
//  Created by cecily li on 8/5/22.
//
import SwiftUI

struct NoEntryView: View {
    @State var animate: Bool = false
    let AccentColor = Color("AccentColor")
    
    @Binding var showingPopup: Bool

    var body: some View {
        ZStack {
            if showingPopup {
                AddWorkoutSplitView(listViewModel: WorkoutListViewModel(), showingPopup: $showingPopup)
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        Text("You haven't created any workouts yet. Add your favorite workouts!")
                            .padding(.bottom, 20)

                        Button {
                            showingPopup = true
                        }
                            label: {
                                Text("Add")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .background(animate ? AccentColor : .green)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, animate ? 30 : 50)
                            .shadow(
                                color: animate ? AccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                                radius: animate ? 30 : 10,
                                x: 0,
                                y: animate ? 50 : 30)
                            .scaleEffect(animate ? 1.1 : 1.0)
                            .offset(y: animate ? -7 : 0)
                    }
                    .frame(maxWidth: 300)
                    .multilineTextAlignment(.center)
                    .padding(40)
                }
                .onAppear {
                    addAnimation()
                }
            }
        }
    }
            

    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}
