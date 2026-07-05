import SwiftUI

/// Home / deck screen ("Deck View" / node 57:398):
/// header with avatar + wordmark, daily resonance tiles, fanned journal card
/// stack over a timeline line, and the NEW ENTRY pill.
struct DeckView: View {
    var onNewEntry: () -> Void
    @State private var showingDetail = false

    var body: some View {
        ZStack {
            Palette.bg.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    header
                        .padding(.horizontal, 24)
                        .padding(.top, 8)

                    dailyResonance
                        .padding(.horizontal, 24)
                        .padding(.top, 20)

                    cardStack
                        .padding(.top, 8)

                    Button(action: onNewEntry) {
                        HStack(spacing: 8) {
                            Image(systemName: "plus")
                                .font(.system(size: 12, weight: .bold))
                            Text("NEW ENTRY")
                                .font(.jakarta(12, weight: .bold, relativeTo: .caption))
                                .tracking(0.6)
                        }
                        .foregroundStyle(Palette.blushDark)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                        .background(
                            Capsule()
                                .fill(Palette.blushLight)
                                .shadow(color: .black.opacity(0.6), radius: 16, y: 8)
                        )
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 20)
                    .padding(.bottom, 140)
                }
            }
        }
        .fullScreenCover(isPresented: $showingDetail) {
            EntryDetailView()
        }
    }

    private var header: some View {
        HStack {
            Image("PartnerAvatar")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Palette.border.opacity(0.3), lineWidth: 1))
                .shadow(color: .black.opacity(0.3), radius: 6, y: 4)

            Spacer()

            Text("BOND101")
                .font(.bodoni(32, relativeTo: .largeTitle))
                .tracking(-1.6)
                .foregroundStyle(Palette.textPrimary)

            Spacer()

            Button(action: { /* TODO: settings */ }) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(Palette.textPrimary)
                    .frame(width: 40, height: 40)
            }
            .buttonStyle(.plain)
        }
    }

    private var dailyResonance: some View {
        VStack(alignment: .leading, spacing: 16) {
            KickerText(text: "DAILY RESONANCE", color: Palette.blushLight)
                .padding(.horizontal, 8)

            HStack(alignment: .top, spacing: 12) {
                resonanceTile(
                    icon: "sparkles",
                    iconColor: Palette.blushLight,
                    kicker: "TODAY'S ACTIVITY",
                    body: "A quiet walk in the park"
                )
                resonanceTile(
                    icon: "tshirt",
                    iconColor: Palette.amber,
                    kicker: "OUTFIT SUGGESTION",
                    body: "Soft linens and a warm knit"
                )
            }
        }
    }

    private func resonanceTile(icon: String, iconColor: Color, kicker: String, body text: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundStyle(iconColor)
                .frame(height: 18)

            Text(kicker)
                .font(.jakarta(12, weight: .bold, relativeTo: .caption))
                .tracking(0.6)
                .foregroundStyle(Palette.textSecondary.opacity(0.5))

            Text(text)
                .font(.jakarta(16, relativeTo: .body))
                .foregroundStyle(Palette.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(17)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Palette.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Palette.border.opacity(0.2), lineWidth: 1)
                )
        )
    }

    private var cardStack: some View {
        ZStack {
            // Vertical timeline line behind the deck
            LinearGradient(
                colors: [Palette.border.opacity(0), Palette.border.opacity(0.5), Palette.border.opacity(0)],
                startPoint: .top, endPoint: .bottom
            )
            .frame(width: 1)
            .frame(maxHeight: .infinity)

            // Card level 3 (deepest)
            RoundedRectangle(cornerRadius: 12)
                .fill(Palette.surface2)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Palette.border.opacity(0.1), lineWidth: 1))
                .frame(width: 313, height: 417)
                .rotationEffect(.degrees(1))
                .opacity(0.4)
                .shadow(color: .black.opacity(0.8), radius: 48, y: 24)

            // Card level 2 (middle)
            RoundedRectangle(cornerRadius: 12)
                .fill(Palette.surface3)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Palette.border.opacity(0.2), lineWidth: 1))
                .frame(width: 326, height: 435)
                .rotationEffect(.degrees(-2))
                .opacity(0.7)
                .shadow(color: .black.opacity(0.6), radius: 32, y: 16)

            topCard
        }
        .frame(height: 470)
    }

    private var topCard: some View {
        Button(action: { showingDetail = true }) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    KickerText(text: "JUNE 24, 2024", color: Palette.blushLight)
                    Spacer()
                    Circle()
                        .fill(Palette.amberDeep)
                        .frame(width: 32, height: 32)
                        .overlay(
                            Image(systemName: "flame.fill")
                                .font(.system(size: 12))
                                .foregroundStyle(Palette.amber)
                        )
                        .overlay(Circle().stroke(Palette.amber.opacity(0.2), lineWidth: 1))
                }
                .padding(.bottom, 24)

                Text("The silence in the kitchen")
                    .font(.jakarta(20, weight: .semibold, relativeTo: .title3))
                    .foregroundStyle(Palette.textPrimary)
                    .padding(.bottom, 16)

                Text("Sunlight was hitting the table differently today. We just sat there, drinking our coffee, not needing to fill the air with words. It felt completely safe. I noticed how your hand rested on the mug.")
                    .font(.jakarta(16, relativeTo: .body))
                    .lineSpacing(7)
                    .foregroundStyle(Palette.textSecondary.opacity(0.8))

                Spacer(minLength: 16)

                HStack(spacing: 12) {
                    Image("AttachmentAvatar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                        .grayscale(1)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Palette.border.opacity(0.5), lineWidth: 1))
                        .opacity(0.7)

                    Text("1 ATTACHMENT")
                        .font(.jakarta(12, weight: .bold, relativeTo: .caption))
                        .tracking(0.6)
                        .foregroundStyle(Palette.textSecondary.opacity(0.5))
                }
                .padding(.top, 17)
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(alignment: .top) {
                    Rectangle()
                        .fill(Palette.border.opacity(0.2))
                        .frame(height: 1)
                }
            }
            .padding(33)
            .frame(width: 340, height: 453)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Palette.cardTop)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(
                                LinearGradient(
                                    colors: [.white.opacity(0.05), .white.opacity(0)],
                                    startPoint: .topLeading, endPoint: .bottomTrailing
                                )
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Palette.border.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: Palette.bg.opacity(0.9), radius: 32, y: 8)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    DeckView(onNewEntry: {})
}
