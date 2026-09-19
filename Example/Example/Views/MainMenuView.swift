import SwiftUI

struct MainMenuView: View {
  var body: some View {
    NavigationStack {
      List {
        Section("Vision Features") {
          NavigationLink("Text Recognition", destination: TextRecognitionView())
        }

        Section("Language Features") {
          NavigationLink("Language Identification", destination: LanguageIDView())
          NavigationLink("Translation", destination: TranslationView())
          NavigationLink("Translation Models", destination: TranslationModelsView())
          NavigationLink("Smart Reply", destination: SmartReplyView())
        }
      }
      .navigationTitle("ML Kit Demo")
    }
  }
}

#Preview {
  MainMenuView()
}
