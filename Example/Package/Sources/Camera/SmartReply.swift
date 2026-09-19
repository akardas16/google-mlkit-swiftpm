import Foundation
@_exported import MLKitSmartReply

public struct SmartReplyClient {
  public var suggestReplies: ([TextMessage]) async throws -> (
    SmartReplyResultStatus, [SmartReplySuggestion]
  )
}

public extension SmartReplyClient {
  @MainActor static let live = Self(suggestReplies: { messages in
    let result = try await SmartReply.smartReply().suggestReplies(for: messages)
    return (result.status, result.suggestions)
  })
}
