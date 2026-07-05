import SwiftUI

/// Connections screen ("Connections" / node 57:118):
/// Venn-diagram connection visual, "You and Alex" heading, and the
/// Shared Resonance card with vibe timeline and Sync Now button.
struct ConnectionsView: View {
    var body: some View {
        ZStack {
            Palette.bg.ignoresSafeArea()

            // Subtle ambient glows
            RadialGradient(colors: [Palette.blush.opacity(0.05), .clear], center: .init(x: 0.15, y: 0.5), startRadius: 0, endRadius: 300)
                .ignoresSafeArea()
            RadialGradient(colors: [Palette.amber.opacity(0.05), .clear], center: .init(x: 0.85, y: 0.3), startRadius: 0, endRadius: 340)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    header
                        .padding(.horizontal, 24)
                        .padding(.top, 8)

                    connectionVisual
                        .padding(.top, 32)

                    Text("You and Alex")
                        .font(.bodoni(32, relativeTo: .largeTitle))
                        .foregroundStyle(Palette.textPrimary)
                        .padding(.top, 24)

                    resonanceCard
                        .padding(.horizontal, 24)
                        .padding(.top, 40)
                        .padding(.bottom, 140)
                }
            }
        }
    }

    private var header: some View {
        HStack {
            Image("ConnectionsAvatar")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Palette.border.opacity(0.3), lineWidth: 1))

            Spacer()

            Text("BOND101")
                .font(.bodoni(24, relativeTo: .title))
                .tracking(-1.2)
                .foregroundStyle(Palette.textPrimary)

            Spacer()

            Button(action: { /* TODO: settings */ }) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(Palette.textPrimary)
                    .frame(width: 40, height: 40)
            }
            .buttonStyle(.plain)
        }
    }

    /// Two overlapping translucent circles labeled You / Alex.
    private var connectionVisual: some View {
        ZStack {
            circleBubble(label: "You", tint: Palette.blushLight)
                .offset(x: -24)
            circleBubble(label: "Alex", tint: Palette.amber)
                .offset(x: 24)
        }
        .frame(width: 192, height: 192)
    }

    private func circleBubble(label: String, tint: Color) -> some View {
        Circle()
            .fill(tint.opacity(0.2))
            .overlay(Circle().stroke(tint.opacity(0.4), lineWidth: 1))
            .frame(width: 128, height: 128)
            .blur(radius: 1)
            .overlay(
                Text(label)
                    .font(.jakarta(16, relativeTo: .body))
                    .foregroundStyle(tint)
                    .opacity(0.8)
            )
            .blendMode(.screen)
    }

    private var resonanceCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Palette.surface2.opacity(0.4))
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(hex: 0x9E8C8F, alpha: 0.05), lineWidth: 1))
                .rotationEffect(.degrees(-1.5))
                .opacity(0.7)
                .padding(.top, 13)

            VStack(alignment: .leading, spacing: 0) {
                Text("SHARED RESONANCE")
                    .font(.jakarta(16, relativeTo: .callout))
                    .tracking(1.6)
                    .foregroundStyle(Palette.textSecondary.opacity(0.7))
                    .frame(maxWidth: .infinity)
                    .padding(.top, 24)

                VStack(spacing: 16) {
                    vibeRow(icon: "bed.double.fill", title: "Restful Silence", subtitle: "Both feeling calm today.")
                    vibeRow(icon: "music.note", title: "Melancholic Focus", subtitle: "Aligned in deep work.")
                    vibeRow(icon: "drop", title: "Introspective", subtitle: "Shared journal themes.")
                }
                .padding(.top, 24)
                .padding(.horizontal, 24)
                .background(alignment: .leading) {
                    // Vertical timeline line through the icons
                    LinearGradient(
                        colors: [Palette.border.opacity(0), Palette.border.opacity(0.5), Palette.border.opacity(0)],
                        startPoint: .top, endPoint: .bottom
                    )
                    .frame(width: 1)
                    .padding(.leading, 48)
                    .padding(.vertical, 30)
                }

                Button(action: { /* TODO: sync */ }) {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.system(size: 12))
                        Text("Sync Now")
                            .font(.jakarta(16, relativeTo: .body))
                    }
                    .foregroundStyle(Palette.textPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background(
                        Capsule()
                            .fill(Palette.surface3)
                            .overlay(Capsule().stroke(Palette.border.opacity(0.2), lineWidth: 1))
                    )
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 24)
                .padding(.top, 32)
                .padding(.bottom, 24)
            }
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Palette.surface2.opacity(0.6))
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24))
                    .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color(hex: 0x9E8C8F, alpha: 0.1), lineWidth: 1))
                    .shadow(color: .black.opacity(0.5), radius: 32, y: 16)
            )
        }
    }

    private func vibeRow(icon: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 16) {
            Circle()
                .fill(Palette.surface2)
                .frame(width: 48, height: 48)
                .overlay(Circle().stroke(Palette.border.opacity(0.3), lineWidth: 1))
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundStyle(Palette.amber)
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.jakarta(16, relativeTo: .body))
                    .foregroundStyle(Palette.textPrimary)
                Text(subtitle)
                    .font(.jakarta(13, relativeTo: .footnote))
                    .foregroundStyle(Palette.textSecondary.opacity(0.8))
            }

            Spacer()
        }
    }
}

#Preview {
    ConnectionsView()
}
