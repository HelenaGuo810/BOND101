import SwiftUI

/// Warm entry detail ("Entry Detail" / node 57:344):
/// stacked card with blush emotion bar, mood/event metadata, feeling essay,
/// image attachment and shared-with-partner footer.
struct EntryDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isShared = true
    @State private var showingBlueEntry = false

    var body: some View {
        ZStack {
            Palette.bg.ignoresSafeArea()

            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 40)

                cardStack
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
            }
        }
        .fullScreenCover(isPresented: $showingBlueEntry) {
            BlueEntryDetailView()
        }
    }

    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Palette.textPrimary)
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(.plain)

            Spacer()

            KickerText(text: "OCT 14")

            Spacer()

            Button(action: { showingBlueEntry = true }) {
                Image(systemName: "ellipsis")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Palette.textPrimary)
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(.plain)
        }
    }

    private var cardStack: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Palette.surface2)
                .overlay(RoundedRectangle(cornerRadius: 24).stroke(Palette.border.opacity(0.3), lineWidth: 1))
                .rotationEffect(.degrees(1.95))
                .opacity(0.4)
            RoundedRectangle(cornerRadius: 24)
                .fill(Palette.surface2)
                .overlay(RoundedRectangle(cornerRadius: 24).stroke(Palette.border.opacity(0.4), lineWidth: 1))
                .rotationEffect(.degrees(-1))
                .opacity(0.6)

            mainCard
        }
    }

    private var mainCard: some View {
        VStack(spacing: 0) {
            // Emotion indicator top border
            Rectangle()
                .fill(Palette.blush)
                .frame(height: 8)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Palette.blush)
                            .frame(width: 24, height: 24)
                            .overlay(
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 11))
                                    .foregroundStyle(Palette.blushDark)
                            )
                            .shadow(color: Palette.blush.opacity(0.4), radius: 6)
                        KickerText(text: "WARM & POSITIVE", color: Palette.blush)
                    }
                    .padding(.bottom, 24)

                    VStack(alignment: .leading, spacing: 8) {
                        metadataRow(label: "MOOD:", value: "Warm & Positive")
                        metadataRow(label: "EVENT:", value: "Happy morning coffee")
                    }
                    .padding(.bottom, 32)

                    KickerText(text: "FEELING:", color: Palette.blush)
                        .opacity(0.6)
                        .padding(.bottom, 16)

                    Text("The morning coffee carries a quiet weight today, a gentle warmth that mirrors the soft humidity clinging to the windowpane. As the weather shifts outside, there is a profound sense of intimacy in these slow, humid hours\u{2014}a feeling of being perfectly held by the stillness of the house and the simple, rhythmic ritual of the pour-over.")
                        .font(.jakarta(16, relativeTo: .body))
                        .lineSpacing(6)
                        .foregroundStyle(Palette.textPrimary)
                        .padding(.bottom, 32)

                    Color.clear
                        .frame(height: 85)
                        .overlay(
                            Image("MorningCoffee")
                                .resizable()
                                .scaledToFill()
                                .opacity(0.8)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Palette.border.opacity(0.3), lineWidth: 1))
                }
                .padding(32)
            }

            footer
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Palette.surface2.opacity(0.6))
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24))
                .overlay(RoundedRectangle(cornerRadius: 24).stroke(Palette.border.opacity(0.5), lineWidth: 1))
                .shadow(color: .black.opacity(0.15), radius: 32, y: 16)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private func metadataRow(label: String, value: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Text(label)
                .font(.jakarta(12, weight: .bold, relativeTo: .caption))
                .tracking(1.2)
                .foregroundStyle(Palette.blush.opacity(0.6))
            Text(value)
                .font(.jakarta(16, relativeTo: .body))
                .foregroundStyle(Palette.textPrimary)
        }
    }

    private var footer: some View {
        HStack {
            Toggle(isOn: $isShared) {
                Text("Shared with Partner")
                    .font(.jakarta(14, relativeTo: .subheadline))
                    .foregroundStyle(Palette.textSecondary)
            }
            .toggleStyle(SwitchToggleStyle(tint: Palette.blush))

            Button(action: { /* TODO: visibility settings */ }) {
                Image(systemName: "eye")
                    .font(.system(size: 14))
                    .foregroundStyle(Palette.textSecondary)
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(Palette.surface2.opacity(0.5))
        .overlay(alignment: .top) {
            Rectangle().fill(Palette.border.opacity(0.2)).frame(height: 1)
        }
    }
}

#Preview {
    EntryDetailView()
}
