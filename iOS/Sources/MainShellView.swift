import SwiftUI

enum Bond101Tab: CaseIterable {
    case community, deck, account
}

struct MainShellView: View {
    @State private var selectedTab: Bond101Tab
    @State private var isComposing = false

    init(initialTab: Bond101Tab = .deck) {
        _selectedTab = State(initialValue: initialTab)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .community: CommunityView()
                case .deck: DeckView(onNewEntry: { isComposing = true })
                case .account: ConnectionsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Bond101TabBar(selection: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
        .background(Palette.bg)
        .fullScreenCover(isPresented: $isComposing) {
            NewEntryView()
        }
    }
}

/// Custom bottom bar from the design: floating dark card with a blush pill on the active tab.
struct Bond101TabBar: View {
    @Binding var selection: Bond101Tab

    var body: some View {
        HStack(spacing: 47) {
            tabButton(.community, icon: "person.2.fill")
            tabButton(.deck, icon: "rectangle.on.rectangle.angled")
            tabButton(.account, icon: "person.crop.circle")
        }
        .padding(.top, 16)
        .padding(.bottom, 40)
        .frame(maxWidth: .infinity)
        .background(
            UnevenRoundedRectangle(topLeadingRadius: 8, topTrailingRadius: 8)
                .fill(Palette.surface2.opacity(0.9))
                .background(.ultraThinMaterial, in: UnevenRoundedRectangle(topLeadingRadius: 8, topTrailingRadius: 8))
                .shadow(color: .black.opacity(0.15), radius: 16, y: -8)
        )
    }

    private func tabButton(_ tab: Bond101Tab, icon: String) -> some View {
        Button {
            selection = tab
        } label: {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(selection == tab ? Palette.blushDark : Palette.textSecondary)
                .frame(width: 70, height: 52)
                .background {
                    if selection == tab {
                        Capsule().fill(Palette.blush)
                    }
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MainShellView()
}
