import MapKit
import SwiftUI

struct MapScreen: View {
    @EnvironmentObject private var model: AppModel
    @Environment(\.scenePhase) private var scenePhase
    @State private var position: MapCameraPosition = .automatic

    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $position) {
                ForEach(model.members) { member in
                    if let coordinate = member.coordinate {
                        Annotation(member.displayName, coordinate: coordinate) {
                            AvatarDot(member: member)
                        }
                    }
                }
            }
            .mapStyle(.standard(pointsOfInterest: .excludingAll))
            .ignoresSafeArea()

            controls
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active {
                model.location.refresh()
            }
        }
    }

    private var controls: some View {
        VStack(spacing: 8) {
            if let message = model.statusMessage {
                Text(message)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(.regularMaterial, in: Capsule())
            }
            HStack {
                Text(friendCountText)
                    .font(.footnote.weight(.medium))
                Spacer()
                Button("Test ping") {
                    model.sendTestPing()
                }
                .font(.footnote.weight(.semibold))
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
            .background(.regularMaterial, in: Capsule())
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }

    private var friendCountText: String {
        let count = model.members.count
        return count == 1 ? "Just you so far" : "\(count) on the map"
    }
}

/// A friend as a calm avatar dot: initials on a muted, per-person color.
struct AvatarDot: View {
    let member: GroupMember

    var body: some View {
        ZStack {
            Circle()
                .fill(fillColor)
            Text(member.initials)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white)
        }
        .frame(width: 40, height: 40)
        .overlay(Circle().stroke(.white, lineWidth: 2.5))
        .shadow(color: .black.opacity(0.18), radius: 5, y: 2)
    }

    private var fillColor: Color {
        if member.isMe { return Color.blue }
        // Deterministic muted hue per member id.
        let seed = member.id.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        return Color(hue: Double(seed % 360) / 360.0, saturation: 0.45, brightness: 0.68)
    }
}
