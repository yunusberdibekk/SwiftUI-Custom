//
//  UIApplication+Extensions.swift
//  CustomInAppNotifications
//
//  Created by Yunus Emre Berdibek on 12.11.2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    func inAppNotification<Content: View>(
        adaptForDynamicIsland: Bool = false,
        timeout: CGFloat = 5,
        swipeToClose: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        // Fetching active window via window scene.
        if let activeWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.tag == 0320 }) {
            // Frame and safe area values.
            let frame = activeWindow.frame
            let safeArea = activeWindow.safeAreaInsets

            var tag = 1009
            let checkForDynamicIsland = adaptForDynamicIsland && safeArea.top >= 51

            if let previousTag = UserDefaults.standard.value(forKey: "in_app_notification_tag") as? Int {
                tag = previousTag + 1
            }

            UserDefaults.standard.setValue(tag, forKey: "in_app_notification_tag")

            // Changing status into black to blend with dynamic island
            if checkForDynamicIsland {
                if let controller = activeWindow.rootViewController as? StatusBarBasedController {
                    controller.statusBarStyle = .darkContent
                    controller.setNeedsStatusBarAppearanceUpdate()
                }
            }

            // Creating ui view from swiftui view usig uihosting configuration.
            let config = UIHostingConfiguration {
                AnimatedNotificationView(content: content(),
                                         safeArea: safeArea,
                                         tag: tag,
                                         adaptForDynamicIsland: adaptForDynamicIsland,
                                         timeOut: timeout,
                                         swipeToClose: swipeToClose)
                    .frame(width: frame.width - (adaptForDynamicIsland ? 20 : 30),
                           height: 120, alignment: .topLeading)
                    .contentShape(.rect)
            }

            // Creating uiview
            let view = config.makeContentView()
            view.tag = tag
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear

            if let rootView = activeWindow.rootViewController?.view {
                // Adding view to the window
                rootView.addSubview(view)

                // Layout constraints
                view.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
                view.centerYAnchor.constraint(equalTo: rootView.centerYAnchor, constant: (-(frame.height - safeArea.top) / 2) + (checkForDynamicIsland ? 11 : safeArea.top)).isActive = true
            }
        }
    }
}

struct AnimatedNotificationView<Content: View>: View {
    var content: Content
    var safeArea: UIEdgeInsets
    var tag: Int
    var adaptForDynamicIsland: Bool
    var timeOut: CGFloat
    var swipeToClose: Bool

    @State private var animateNotification: Bool = false

    var body: some View {
        content
            .blur(radius: animateNotification ? 0 : 10)
            .disabled(!animateNotification)
            .mask {
                if adaptForDynamicIsland {
                    // Size based capsule
                    GeometryReader(content: {
                        let size = $0.size
                        let radius = size.height / 2

                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                    })
                } else {
                    Rectangle()
                }
            }
            // Scaling animation only for dynamic island notification
            .scaleEffect(adaptForDynamicIsland ? (animateNotification ? 1 : 0.01) : 1,
                         anchor: .init(x: 0.5, y: 0.01))
            // Offset animation for non dynamic island notification
            .offset(y: offsetY)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if -value.translation.height > 50 {
                            withAnimation(.smooth, completionCriteria: .logicallyComplete) {
                                animateNotification = false
                            } completion: {
                                removeNotificationViewFromWindow()
                            }
                        }
                    }
            )
            .onAppear(perform: {
                Task {
                    guard !animateNotification else { return }
                    withAnimation(.smooth) {
                        animateNotification = true
                    }

                    // Timeout for notification
                    try await Task.sleep(for: .seconds(timeOut < 1 ? 1 : timeOut))

                    guard animateNotification else { return }

                    withAnimation(.smooth, completionCriteria: .logicallyComplete) {
                        animateNotification = false
                    } completion: {
                        removeNotificationViewFromWindow()
                    }
                }
            })
    }

    var offsetY: CGFloat {
        if adaptForDynamicIsland {
            return 0
        }

        return animateNotification ? 10 : -(safeArea.top + 130)
    }

    func removeNotificationViewFromWindow() {
        if let activeWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.tag == 0320 }) {
            if let view = activeWindow.viewWithTag(tag) {
                //  print("Removed view with \(tag)")
                view.removeFromSuperview()

                // Resetting once all the notifications was removedi
                if let controller = activeWindow.rootViewController as? StatusBarBasedController, controller.view.subviews.isEmpty {
                    controller.statusBarStyle = .default
                    controller.setNeedsStatusBarAppearanceUpdate()
                }
            }
        }
    }
}

#Preview(body: {
    ContentView()
})
