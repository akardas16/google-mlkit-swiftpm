import SwiftUI
import MLImage
import MLKitTextRecognition
import MLKitVision

struct TextRecognitionView: View {
  @State private var recognizedText: String = ""

  var body: some View {
    BaseDetectionView(
      title: "Text Recognition",
      sampleImages: ["image_has_text"],
      detectionHandler: recognizeText,
      resultView: {
        ScrollView {
          VStack(alignment: .leading) {
            Text("Recognized Text:")
              .font(.headline)

            Text(recognizedText.isEmpty ? "No text detected" : recognizedText)
              .font(.body)
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding()
              .background(Color.gray.opacity(0.1))
              .clipShape(.rect(cornerRadius: 8))
          }
        }
      }
    )
  }

  private func recognizeText(image: UIImage) async throws {
    let visionImage = VisionImage(image: image)
    visionImage.orientation = image.imageOrientation

    let options = TextRecognizerOptions()
    let textRecognizer = TextRecognizer.textRecognizer(options: options)
    let result = try await textRecognizer.process(visionImage)

    recognizedText = result.text
  }
}

#Preview {
  NavigationStack {
    TextRecognitionView()
  }
}
