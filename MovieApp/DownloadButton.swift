import SwiftUI
import SwiftData

struct DownloadButton: View {
    @Environment(\.modelContext) private var modelContext

    var title: Title
    var displayName: String?
    var onComplete: (() -> Void)?

    var body: some View {
        Button {
            let saveTitle = title
            if let displayName {
                saveTitle.title = displayName
            }
            modelContext.insert(saveTitle)
            try? modelContext.save()
            onComplete?()
        } label: {
            Label {
                Text(Constants.downloadButtonString)
            } icon: {
                Image(systemName: Constants.downloadButtonIconString)
                    .foregroundStyle(.buttonBorder)
                    .opacity(0.9)
            }
        }
        .ghostButton()
    }
}
