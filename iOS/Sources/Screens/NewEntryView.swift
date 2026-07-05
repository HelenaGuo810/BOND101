import SwiftUI

enum Mood: String, CaseIterable, Identifiable {
    case happy = "Happy"
    case calm = "Calm"
    case excited = "Excited"
    case tired = "Tired"

    var id: String { rawValue }

    var dotColor: Color {
        switch self {
        case .happy: Color(hex: 0xFFD93D)
        case .calm: Color(hex: 0x6FCFEB)
        case .excited: Color(hex: 0xFF6B35)
        case .tired: Color(hex: 0x95A5A6)
        }
    }
}

/// Composer ("New Entry" / node 57:296):
/// light editor canvas with dark action bar, mood chips, title and body
/// inputs, and the blush AI-refine floating action button.
struct NewEntryView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var bodyText = ""
    @State private var selectedMood: Mood?
    @State private var isGenerating = false
    @State private var showError = false
    @State private var errorMessage = ""

    // The composer frame is light even though the app is dark.
    private let canvasBackground = Color.white

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            canvasBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                actionBar

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        HStack(spacing: 8) {
                            Image(systemName: "calendar")
                                .font(.system(size: 13))
                                .foregroundStyle(Palette.textSecondary)
                            KickerText(text: "OCTOBER 24, 2023")
                        }
                        .padding(.top, 32)

                        TextField("Title", text: $title, axis: .vertical)
                            .font(.bodoni(32, relativeTo: .largeTitle))
                            .foregroundStyle(Color(hex: 0x171213))
                            .tint(Palette.blush)

                        moodSection
                            .padding(.top, 16)

                        TextField("A few words about the event...", text: $bodyText, axis: .vertical)
                            .font(.jakarta(18, relativeTo: .body))
                            .foregroundStyle(Color(hex: 0x171213))
                            .tint(Palette.blush)
                            .lineSpacing(9)
                            .padding(.top, 32)
                            .frame(minHeight: 200, alignment: .top)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 140)
                }
                .scrollDismissesKeyboard(.interactively)
            }

            // AI refine FAB
            Button(action: refineWithAI) {
                Group {
                    if isGenerating {
                        ProgressView()
                            .tint(Palette.blushDark)
                    } else {
                        Image(systemName: "lightbulb")
                            .font(.system(size: 22))
                            .foregroundStyle(Palette.blushDark)
                    }
                }
                .frame(width: 64, height: 64)
                .background(
                    Circle()
                        .fill(Palette.blush)
                        .shadow(color: Palette.blush.opacity(0.15), radius: 16, y: 8)
                )
            }
            .buttonStyle(.plain)
            .disabled(isGenerating)
            .opacity(isGenerating ? 0.85 : 1)
            .padding(.trailing, 24)
            .padding(.bottom, 40)
        }
        .preferredColorScheme(.light)
        .alert("Couldn’t generate text", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }

    private func refineWithAI() {
        guard !isGenerating else { return }
        isGenerating = true
        Task {
            defer { isGenerating = false }
            do {
                let paragraph = try await AIService.generateEntryParagraph(
                    title: title,
                    mood: selectedMood?.rawValue,
                    draft: bodyText
                )
                bodyText = paragraph
            } catch {
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }

    private var actionBar: some View {
        HStack {
            Button(action: { dismiss() }) {
                Text("CANCEL")
                    .font(.jakarta(12, weight: .bold, relativeTo: .caption))
                    .tracking(1.2)
                    .foregroundStyle(Palette.textSecondary)
            }
            .buttonStyle(.plain)

            Spacer()

            Button(action: { dismiss() }) {
                Text("POST")
                    .font(.jakarta(12, weight: .bold, relativeTo: .caption))
                    .tracking(1.2)
                    .foregroundStyle(Palette.blush)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 24)
        .padding(.top, 12)
        .padding(.bottom, 16)
        .background(
            Palette.bg.opacity(0.8)
                .background(.ultraThinMaterial)
                .ignoresSafeArea(edges: .top)
        )
    }

    private var moodSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            KickerText(text: "HOW ARE YOU FEELING?")

            FlowLayout(spacing: 12) {
                ForEach(Mood.allCases) { mood in
                    moodChip(mood)
                }
            }
        }
    }

    private func moodChip(_ mood: Mood) -> some View {
        let isSelected = selectedMood == mood
        return Button {
            selectedMood = isSelected ? nil : mood
        } label: {
            HStack(spacing: 8) {
                Circle()
                    .fill(mood.dotColor)
                    .frame(width: 12, height: 12)
                Text(mood.rawValue)
                    .font(.jakarta(14, relativeTo: .subheadline))
                    .foregroundStyle(.black)
            }
            .padding(.horizontal, 17)
            .padding(.vertical, 9)
            .background(
                Capsule()
                    .fill(isSelected ? Palette.blush.opacity(0.2) : .clear)
                    .overlay(
                        Capsule().stroke(
                            isSelected ? Palette.blush : Palette.border.opacity(0.5),
                            lineWidth: 1
                        )
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

/// Simple wrapping layout for the mood chips.
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        let width = proposal.width ?? rows.map(\.width).max() ?? 0
        let height = rows.reduce(0) { $0 + $1.height } + spacing * CGFloat(max(rows.count - 1, 0))
        return CGSize(width: width, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        var y = bounds.minY
        for row in rows {
            var x = bounds.minX
            for index in row.indices {
                let size = subviews[index].sizeThatFits(.unspecified)
                subviews[index].place(at: CGPoint(x: x, y: y), proposal: .unspecified)
                x += size.width + spacing
            }
            y += row.height + spacing
        }
    }

    private struct Row {
        var indices: [Int] = []
        var width: CGFloat = 0
        var height: CGFloat = 0
    }

    private func computeRows(proposal: ProposedViewSize, subviews: Subviews) -> [Row] {
        let maxWidth = proposal.width ?? .infinity
        var rows: [Row] = []
        var current = Row()
        for (index, subview) in subviews.enumerated() {
            let size = subview.sizeThatFits(.unspecified)
            let needed = current.indices.isEmpty ? size.width : current.width + spacing + size.width
            if needed > maxWidth, !current.indices.isEmpty {
                rows.append(current)
                current = Row()
            }
            current.indices.append(index)
            current.width = current.indices.count == 1 ? size.width : current.width + spacing + size.width
            current.height = max(current.height, size.height)
        }
        if !current.indices.isEmpty { rows.append(current) }
        return rows
    }
}

#Preview {
    NewEntryView()
}
