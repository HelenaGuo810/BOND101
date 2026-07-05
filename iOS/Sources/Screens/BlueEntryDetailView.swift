import SwiftUI

/// Blue-themed entry detail ("Entry Detail - Blue (Jealousy)" / node 57:494):
/// hero image with floating date tag, editorial title, essay, shared toggle
/// row and contextual tags — all in the cold blue palette.
struct BlueEntryDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isShared = true

    var body: some View {
        ZStack {
            Palette.blueBg.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    header
                        .padding(.top, 8)

                    heroImage

                    titleBlock
                        .padding(.top, 16)

                    essay

                    sharedToggleRow
                        .padding(.top, 8)

                    tagsRow
                        .padding(.bottom, 120)
                }
                .padding(.horizontal, 24)
            }
        }
    }

    private var header: some View {
        HStack {
            Button(action: { dismiss() }) {
                circleIcon("xmark", size: 14)
            }
            .buttonStyle(.plain)

            Spacer()

            Button(action: { /* TODO: edit */ }) {
                circleIcon("pencil", size: 16)
            }
            .buttonStyle(.plain)
        }
    }

    private func circleIcon(_ systemName: String, size: CGFloat) -> some View {
        Image(systemName: systemName)
            .font(.system(size: size, weight: .medium))
            .foregroundStyle(Palette.blueText)
            .frame(width: 40, height: 40)
            .background(
                Circle()
                    .fill(Palette.blueSurface)
                    .overlay(Circle().stroke(Palette.blueBorder, lineWidth: 1))
            )
    }

    private var heroImage: some View {
        ZStack(alignment: .bottomLeading) {
            // Overlay pattern keeps scaledToFill from expanding the layout width.
            Color.clear
                .frame(height: 428)
                .overlay(
                    Image("EntryBlueHero")
                        .resizable()
                        .scaledToFill()
                )
                .clipped()

            LinearGradient(
                colors: [Palette.blueBg, Palette.blueBg.opacity(0)],
                startPoint: .bottom, endPoint: .center
            )
            .opacity(0.8)

            Text("OCT 14 \u{2022} 9:42 PM")
                .font(.jakarta(12, weight: .bold, relativeTo: .caption))
                .tracking(1.2)
                .foregroundStyle(Palette.blueText.opacity(0.8))
                .padding(.horizontal, 13)
                .padding(.vertical, 13)
                .background(
                    Capsule()
                        .fill(Palette.blueSurface.opacity(0.8))
                        .background(.ultraThinMaterial, in: Capsule())
                        .overlay(Capsule().stroke(Palette.blueBorder, lineWidth: 1))
                )
                .padding(16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.25), radius: 50, y: 25)
    }

    private var titleBlock: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Circle()
                    .fill(Palette.blueAccent)
                    .frame(width: 8, height: 8)
                KickerText(text: "COLD & DISTANT", color: Palette.blueAccent)
            }

            Text("Unexpected Silence")
                .font(.bodoni(32, relativeTo: .largeTitle))
                .foregroundStyle(Palette.blueText)
        }
    }

    private var essay: some View {
        Text("The silence between us feels heavier than the air today, a cold mist that settled in after the mention of a name. It's a strange distance, sitting in the same room but drifting leagues apart, anchored only by the quiet hum of the refrigerator and the unspoken tension in the way you look away. I miss the warmth, but for now, we are two islands in a blue sea of misunderstanding.")
            .font(.jakarta(18, relativeTo: .body))
            .lineSpacing(9)
            .foregroundStyle(Palette.blueText)
            .opacity(0.9)
            .padding(.top, 25)
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .top) {
                Rectangle().fill(Palette.blueBorder).frame(height: 1)
            }
    }

    private var sharedToggleRow: some View {
        HStack {
            HStack(spacing: 12) {
                Circle()
                    .fill(Palette.blueBorder)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "heart.fill")
                            .font(.system(size: 16))
                            .foregroundStyle(Palette.blueText)
                    )

                VStack(alignment: .leading, spacing: 1) {
                    Text("Shared with Partner")
                        .font(.jakarta(16, relativeTo: .body))
                        .foregroundStyle(Palette.blueText)
                    Text("They can see this entry")
                        .font(.jakarta(14, relativeTo: .subheadline))
                        .foregroundStyle(Palette.blueAccent.opacity(0.7))
                }
            }

            Spacer()

            Toggle("", isOn: $isShared)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: Palette.blueAccent))
        }
        .padding(17)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Palette.blueSurface)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Palette.blueBorder, lineWidth: 1))
        )
    }

    private var tagsRow: some View {
        HStack(spacing: 8) {
            ForEach(["JEALOUSY", "APARTMENT", "RAINY"], id: \.self) { tag in
                Text(tag)
                    .font(.jakarta(12, weight: .bold, relativeTo: .caption))
                    .tracking(0.6)
                    .foregroundStyle(Palette.blueText)
                    .padding(.horizontal, 13)
                    .padding(.vertical, 7)
                    .background(
                        Capsule()
                            .fill(Palette.blueSurface)
                            .overlay(Capsule().stroke(Palette.blueBorder, lineWidth: 1))
                    )
                    .opacity(0.8)
            }
        }
    }
}

#Preview {
    BlueEntryDetailView()
}
