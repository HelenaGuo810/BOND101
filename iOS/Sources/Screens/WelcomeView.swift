import SwiftUI

/// Entry screen ("iPhone 16 - 1" / node 59:46): dark ambient background,
/// stacked card with app glyph, title, and START BONDING call to action.
struct WelcomeView: View {
    var onStart: () -> Void

    var body: some View {
        ZStack {
            Palette.bg.ignoresSafeArea()

            // Ambient cosmic glow behind the card stack
            RadialGradient(
                colors: [Palette.blush.opacity(0.10), Palette.bg.opacity(0)],
                center: .center,
                startRadius: 0,
                endRadius: 320
            )
            .ignoresSafeArea()
            .opacity(0.6)

            ZStack {
                // Abstract stacked background cards for depth
                RoundedRectangle(cornerRadius: 24)
                    .fill(Palette.surface3)
                    .frame(width: 282, height: 363)
                    .rotationEffect(.degrees(3))
                    .opacity(0.4)
                    .shadow(color: Palette.bg.opacity(0.4), radius: 32, y: 16)

                RoundedRectangle(cornerRadius: 24)
                    .fill(Palette.surface2)
                    .frame(width: 282, height: 363)
                    .rotationEffect(.degrees(-1.5))
                    .opacity(0.6)
                    .shadow(color: Palette.bg.opacity(0.4), radius: 32, y: 16)

                // Central card
                VStack(spacing: 0) {
                    Image("BOND101Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 129, height: 129)
                        .opacity(0.9)
                        .shadow(color: Palette.blush.opacity(0.3), radius: 15)
                        .padding(.top, 49)

                    Text("BOND101")
                        .font(.bodoni(32, relativeTo: .largeTitle))
                        .tracking(-1.6)
                        .foregroundStyle(Palette.textPrimary)
                        .padding(.top, 56)

                    Spacer()

                    Button(action: onStart) {
                        HStack(spacing: 10) {
                            Text("START BONDING")
                                .font(.jakarta(12, weight: .bold, relativeTo: .caption))
                                .tracking(1.2)
                            Image(systemName: "arrowtriangle.right.fill")
                                .font(.system(size: 9))
                        }
                        .foregroundStyle(Palette.blush)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(
                            Capsule()
                                .fill(Palette.surface)
                                .overlay(Capsule().stroke(Palette.blush.opacity(0.4), lineWidth: 1))
                        )
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 34)
                }
                .frame(width: 302, height: 403)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Palette.bgDeep.opacity(0.9))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Palette.border.opacity(0.3), lineWidth: 1)
                        )
                        .shadow(color: Palette.bg.opacity(0.4), radius: 32, y: 16)
                )
            }
        }
    }
}

#Preview {
    WelcomeView(onStart: {})
}
