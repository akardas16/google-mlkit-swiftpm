import SwiftUI
import MLKitCommon
import MLKitTranslate

/// Manages the on-device translation model catalog: lists every language ML Kit
/// supports, downloads a model on demand, and deletes it.
///
/// Note: ML Kit does not expose download progress or model size for translate
/// models, so rows show a simple "Downloading…" state rather than a percentage.
final class TranslationModelsViewModel: ObservableObject {
  struct LanguageItem: Identifiable {
    let language: TranslateLanguage
    let name: String
    var id: String { language.rawValue }
  }

  @Published var items: [LanguageItem] = []
  @Published var downloaded: Set<String> = []
  @Published var downloading: Set<String> = []
  @Published var errorMessage: String?

  private let modelManager = ModelManager.modelManager()

  init() {
    items = TranslateLanguage.allLanguages()
      .map { LanguageItem(language: $0, name: Self.displayName($0)) }
      .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
    refreshDownloaded()

    NotificationCenter.default.addObserver(
      forName: .mlkitModelDownloadDidSucceed, object: nil, queue: .main
    ) { [weak self] note in
      self?.finishDownload(note, success: true)
    }
    NotificationCenter.default.addObserver(
      forName: .mlkitModelDownloadDidFail, object: nil, queue: .main
    ) { [weak self] note in
      self?.finishDownload(note, success: false)
    }
  }

  static func displayName(_ language: TranslateLanguage) -> String {
    Locale.current.localizedString(forLanguageCode: language.rawValue)?.capitalized
      ?? language.rawValue.uppercased()
  }

  func refreshDownloaded() {
    // Reading downloaded models touches disk; do it off the main thread.
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      guard let self else { return }
      let codes = Set(self.modelManager.downloadedTranslateModels.map { $0.language.rawValue })
      DispatchQueue.main.async { self.downloaded = codes }
    }
  }

  func isDownloading(_ code: String) -> Bool { downloading.contains(code) }

  func download(_ language: TranslateLanguage) {
    let code = language.rawValue
    guard !downloading.contains(code), !downloaded.contains(code) else { return }

    let model = TranslateRemoteModel.translateRemoteModel(language: language)
    let conditions = ModelDownloadConditions(
      allowsCellularAccess: true,
      allowsBackgroundDownloading: true
    )

    downloading.insert(code)
    // ML Kit does synchronous setup when starting a download; keep it off the
    // main thread so the button tap doesn't freeze the UI. Completion is
    // reported via the download notifications below.
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      _ = self?.modelManager.download(model, conditions: conditions)
    }
  }

  func delete(_ language: TranslateLanguage) {
    let code = language.rawValue
    let model = TranslateRemoteModel.translateRemoteModel(language: language)
    modelManager.deleteDownloadedModel(model) { [weak self] error in
      DispatchQueue.main.async {
        if let error {
          self?.errorMessage = error.localizedDescription
        } else {
          self?.downloaded.remove(code)
        }
        self?.refreshDownloaded()
      }
    }
  }

  private func finishDownload(_ note: Notification, success: Bool) {
    let model = note.userInfo?[ModelDownloadUserInfoKey.remoteModel.rawValue] as? TranslateRemoteModel
    if let code = model?.language.rawValue {
      downloading.remove(code)
      if success { downloaded.insert(code) }
    }
    if !success {
      let error = note.userInfo?[ModelDownloadUserInfoKey.error.rawValue] as? Error
      errorMessage = "Download failed: \(error?.localizedDescription ?? "unknown error")"
    }
    refreshDownloaded()
  }
}

struct TranslationModelsView: View {
  @StateObject private var viewModel = TranslationModelsViewModel()

  private var downloadedItems: [TranslationModelsViewModel.LanguageItem] {
    viewModel.items.filter { viewModel.downloaded.contains($0.id) }
  }

  private var availableItems: [TranslationModelsViewModel.LanguageItem] {
    viewModel.items.filter { !viewModel.downloaded.contains($0.id) }
  }

  var body: some View {
    List {
      if !downloadedItems.isEmpty {
        Section("Downloaded (\(downloadedItems.count))") {
          ForEach(downloadedItems, content: row(for:))
        }
      }
      Section("All Languages") {
        ForEach(availableItems, content: row(for:))
      }
    }
    .navigationTitle("Translation Models")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          viewModel.refreshDownloaded()
        } label: {
          Image(systemName: "arrow.clockwise")
        }
      }
    }
    .alert(
      "Error",
      isPresented: Binding(
        get: { viewModel.errorMessage != nil },
        set: { if !$0 { viewModel.errorMessage = nil } }
      )
    ) {
      Button("OK", role: .cancel) {}
    } message: {
      Text(viewModel.errorMessage ?? "")
    }
  }

  @ViewBuilder
  private func row(for item: TranslationModelsViewModel.LanguageItem) -> some View {
    HStack(spacing: 12) {
      VStack(alignment: .leading, spacing: 4) {
        Text(item.name)
        Text(item.language.rawValue.uppercased())
          .font(.caption2)
          .foregroundStyle(.secondary)

        if viewModel.isDownloading(item.id) {
          Text("Downloading…")
            .font(.caption2)
            .foregroundStyle(.secondary)
        }
      }

      Spacer()

      control(for: item)
    }
    .padding(.vertical, 2)
  }

  @ViewBuilder
  private func control(for item: TranslationModelsViewModel.LanguageItem) -> some View {
    if viewModel.isDownloading(item.id) {
      ProgressView()
    } else if viewModel.downloaded.contains(item.id) {
      HStack(spacing: 16) {
        Image(systemName: "checkmark.circle.fill")
          .foregroundStyle(.green)
        Button(role: .destructive) {
          viewModel.delete(item.language)
        } label: {
          Image(systemName: "trash")
        }
        .buttonStyle(.borderless)
      }
    } else {
      Button {
        viewModel.download(item.language)
      } label: {
        Image(systemName: "arrow.down.circle")
          .font(.title3)
      }
      .buttonStyle(.borderless)
    }
  }
}

#Preview {
  NavigationStack {
    TranslationModelsView()
  }
}
