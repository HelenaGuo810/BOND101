import SwiftUI

/// Community feed ("Community" / node 57:200):
/// "Shared Resonance" editorial header and three bento-style cards.
struct CommunityView: View {
    var body: some View {
        ZStack {
            Palette.bg.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    header
                        .padding(.horizontal, 24)
                        .padding(.top, 8)

                    editorialHeader
                        .padding(.horizontal, 24)
                        .padding(.top, 16)

                    VStack(spacing: 24) {
                        quoteCard
                        promptCard
                            .padding(.top, 16)
                        memoryCard
                            .padding(.top, 16)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 80)

                    ProgressView()
                        .tint(Palette.textSecondary)
                        .opacity(0.5)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 32)
                        .padding(.bottom, 120)
                }
            }
        }
    }

    private var header: some View {
        HStack {
            HStack(spacing: 12) {
                Image("PartnerProfile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Palette.border.opacity(0.3), lineWidth: 1))

                Text("BOND101")
                    .font(.bodoni(32, relativeTo: .largeTitle))
                    .tracking(-1.6)
                    .foregroundStyle(Palette.textPrimary)
            }

            Spacer()

            Button(action: { /* TODO: settings */ }) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(Palette.textPrimary)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(Palette.surface2.opacity(0.5)))
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 16)
    }

    private var editorialHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Shared")
                    .font(.bodoni(32, relativeTo: .largeTitle))
                    .foregroundStyle(Palette.textPrimary)
                Text("Resonance")
                    .font(.bodoni(32, italic: true, relativeTo: .largeTitle))
                    .foregroundStyle(Palette.blush)
            }

            Text("Discover moments of connection from couples exploring their inner landscapes.")
                .font(.jakarta(16, relativeTo: .body))
                .lineSpacing(6)
                .foregroundStyle(Palette.textSecondary)
                .frame(maxWidth: 274, alignment: .leading)
        }
    }

    // Card 1: quote with mood indicator
    private var quoteCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                HStack(spacing: -8) {
                    avatar("User1")
                    avatar("User2")
                }
                KickerText(text: "E & J")
            }

            Text("\u{201C}We realized our silence wasn't distance, but a shared sanctuary.\u{201D}")
                .font(.bodoni(20, italic: true, relativeTo: .title3))
                .lineSpacing(10)
                .foregroundStyle(Palette.textPrimary)
                .padding(.leading, 18)
                .padding(.vertical, 16)
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(Palette.green.opacity(0.3))
                        .frame(width: 2)
                }
                .padding(.vertical, 8)

            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "leaf")
                        .font(.system(size: 13))
                        .foregroundStyle(Palette.textSecondary)
                    Text("Calm Connection")
                        .font(.jakarta(12, weight: .bold, relativeTo: .caption))
                        .tracking(0.6)
                        .foregroundStyle(Palette.textSecondary)
                }
                Spacer()
                Button(action: { /* TODO: like */ }) {
                    HStack(spacing: 4) {
                        Image(systemName: "heart")
                            .font(.system(size: 15))
                        Text("24")
                            .font(.jakarta(12, weight: .bold, relativeTo: .caption))
                            .tracking(0.6)
                    }
                    .foregroundStyle(Palette.textSecondary)
                }
                .buttonStyle(.plain)
            }
            .padding(.top, 8)
        }
        .padding(25)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardBackground(borderColor: Color(hex: 0x9E8C8F, alpha: 0.1)))
        .overlay(alignment: .topTrailing) {
            moodDot(Palette.green)
        }
    }

    // Card 2: stacked prompt preview
    private var promptCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Palette.surface3)
                .rotationEffect(.degrees(3))
                .opacity(0.5)
            RoundedRectangle(cornerRadius: 24)
                .fill(Palette.surface2)
                .rotationEffect(.degrees(-2))
                .opacity(0.7)

            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    Image("Couple")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Palette.border.opacity(0.3), lineWidth: 1))

                    VStack(alignment: .leading, spacing: 2) {
                        KickerText(text: "M & S", color: Palette.textPrimary)
                        Text("Deck: Vulnerability")
                            .font(.jakarta(10, relativeTo: .caption2))
                            .foregroundStyle(Palette.textSecondary)
                    }
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Prompt: What is a fear you hold about our future that you haven't voiced?")
                        .font(.jakarta(16, relativeTo: .body))
                        .lineSpacing(6)
                        .foregroundStyle(Palette.textPrimary)

                    HStack(spacing: 8) {
                        tag("DEEP TALK")
                        tag("EVENING")
                    }
                    .padding(.top, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(alignment: .top) {
                        Rectangle().fill(Palette.border.opacity(0.2)).frame(height: 1)
                    }
                }
                .padding(21)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Palette.bgDeep.opacity(0.5))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Palette.border.opacity(0.1), lineWidth: 1))
                )
                .padding(.top, 16)
            }
            .padding(25)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(cardBackground(borderColor: Palette.blush.opacity(0.2)))
            .overlay(alignment: .topTrailing) {
                moodDot(Palette.blush)
            }
        }
    }

    // Card 3: image / memory focus
    private var memoryCard: some View {
        ZStack(alignment: .bottom) {
            Color.clear
                .frame(height: 192)
                .overlay(
                    Image("Memory")
                        .resizable()
                        .scaledToFill()
                        .grayscale(0.9)
                        .opacity(0.8)
                )
                .clipped()

            LinearGradient(
                colors: [Palette.bg.opacity(0.9), Palette.bg.opacity(0)],
                startPoint: .bottom, endPoint: .top
            )

            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    KickerText(text: "WEEKEND REFLECTION", color: Palette.blush)
                    Text("Reconnecting")
                        .font(.bodoni(20, relativeTo: .title3))
                        .foregroundStyle(Palette.textPrimary)
                }
                Spacer()
                Circle()
                    .fill(Palette.peach)
                    .frame(width: 12, height: 12)
                    .shadow(color: Palette.blushLight.opacity(0.4), radius: 6)
                    .padding(.bottom, 8)
            }
            .padding(16)
        }
        .frame(height: 192)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(9)
        .background(cardBackground(borderColor: Color(hex: 0x9E8C8F, alpha: 0.1)))
    }

    // MARK: helpers

    private func avatar(_ name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFill()
            .frame(width: 32, height: 32)
            .clipShape(Circle())
            .overlay(Circle().stroke(Palette.bg, lineWidth: 1))
    }

    private func tag(_ text: String) -> some View {
        Text(text)
            .font(.jakarta(10, relativeTo: .caption2))
            .tracking(0.5)
            .foregroundStyle(Palette.textSecondary)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(Capsule().fill(Palette.chip))
            .padding(.top, 17)
    }

    private func moodDot(_ color: Color) -> some View {
        Circle()
            .fill(color)
            .frame(width: 12, height: 12)
            .shadow(color: color.opacity(0.4), radius: 6)
            .padding(24)
    }

    private func cardBackground(borderColor: Color) -> some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(
                LinearGradient(
                    colors: [Palette.surface3.opacity(0.6), Palette.surface2.opacity(0.4)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            )
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24))
            .overlay(RoundedRectangle(cornerRadius: 24).stroke(borderColor, lineWidth: 1))
    }
}

#Preview {
    CommunityView()
}
