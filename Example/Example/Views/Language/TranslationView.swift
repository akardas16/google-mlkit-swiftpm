import SwiftUI
import MLKitTranslate

struct TranslationView: View {
  @State private var inputText: String = "Hello, how are you?"
  @State private var translatedText: String = ""
  @State private var sourceLanguage: TranslateLanguage = .english
  @State private var targetLanguage: TranslateLanguage = .turkish
  @State private var isTranslating = false
  @State private var isDownloadingModel = false
  @State private var errorMessage: String?

  // Every language ML Kit on-device translation supports (~59), sorted by name.
  private var sortedLanguages: [TranslateLanguage] {
    TranslateLanguage.allLanguages().sorted {
      localizedName($0).localizedCaseInsensitiveCompare(localizedName($1)) == .orderedAscending
    }
  }

  private func localizedName(_ language: TranslateLanguage) -> String {
    Locale.current.localizedString(forLanguageCode: language.rawValue)?.capitalized
      ?? language.rawValue.uppercased()
  }

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(alignment: .leading) {
          Text("Source Language")
            .font(.headline)

          Picker("Source", selection: $sourceLanguage) {
            ForEach(sortedLanguages, id: \.rawValue) { language in
              Text(localizedName(language)).tag(language)
            }
          }
          .pickerStyle(.menu)

          Text("Target Language")
            .font(.headline)

          Picker("Target", selection: $targetLanguage) {
            ForEach(sortedLanguages, id: \.rawValue) { language in
              Text(localizedName(language)).tag(language)
            }
          }
          .pickerStyle(.menu)

          Text("Input Text")
            .font(.headline)

          TextEditor(text: $inputText)
            .frame(height: 100)
            .padding()
            .background(Color.gray.opacity(0.1))
            .clipShape(.rect(cornerRadius: 8))

          Button {
            Task {
              await translate()
            }
          } label: {
            if isTranslating {
              ProgressView()
            } else if isDownloadingModel {
              HStack {
                ProgressView()
                Text("Downloading model...")
              }
            } else {
              Text("Translate")
            }
          }
          .buttonStyle(.borderedProminent)
          .disabled(inputText.isEmpty || isTranslating || isDownloadingModel)

          if let error = errorMessage {
            Text(error)
              .foregroundStyle(.red)
              .font(.caption)
          }

          if !translatedText.isEmpty {
            VStack(alignment: .leading) {
              Text("Translation")
                .font(.headline)

              Text(translatedText)
                .font(.body)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.1))
            .clipShape(.rect(cornerRadius: 8))
          }

          Spacer()
        }
      }
      .navigationTitle("Translation")
      .navigationBarTitleDisplayMode(.inline)
    }
  }

  private func translate() async {
    errorMessage = nil
    isTranslating = true

    let options = TranslatorOptions(sourceLanguage: sourceLanguage, targetLanguage: targetLanguage)
    let translator = Translator.translator(options: options)

    // Allow cellular so the first-run model download isn't silently blocked
    // when the device is off Wi-Fi.
    let conditions = ModelDownloadConditions(
      allowsCellularAccess: true,
      allowsBackgroundDownloading: true
    )

    do {
      isDownloadingModel = true
      try await translator.downloadModelIfNeeded(with: conditions)
      isDownloadingModel = false

      translatedText = try await translator.translate(inputText)
    } catch {
      // Surface the real failure (model download vs. translate) in the UI and console.
      print("[Translation] failed: \(error)")
      errorMessage = "Translation failed: \(error.localizedDescription)"
      translatedText = ""
      isDownloadingModel = false
    }

    isTranslating = false
  }
}

#Preview {
  TranslationView()
}
