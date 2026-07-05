import Foundation

enum AIServiceError: LocalizedError {
    case missingAPIKey
    case badResponse(status: Int, message: String)
    case emptyCompletion

    var errorDescription: String? {
        switch self {
        case .missingAPIKey:
            "No API key set. Add your Anthropic API key to generate text."
        case .badResponse(let status, let message):
            "The AI request failed (\(status)): \(message)"
        case .emptyCompletion:
            "The AI returned an empty response. Try again."
        }
    }
}

/// Thin client for Anthropic's Messages API used by the composer's
/// "Refine with AI" button.
enum AIService {
    private static let endpoint = URL(string: "https://api.anthropic.com/v1/messages")!
    private static let model = "claude-sonnet-4-5"
    private static let apiKeyDefaultsKey = "anthropicAPIKey"

    static var apiKey: String? {
        get {
            let stored = UserDefaults.standard.string(forKey: apiKeyDefaultsKey)
            if let stored, !stored.isEmpty { return stored }
            // Fallback for development: launch environment or Info.plist.
            if let env = ProcessInfo.processInfo.environment["ANTHROPIC_API_KEY"], !env.isEmpty { return env }
            if let plist = Bundle.main.object(forInfoDictionaryKey: "AnthropicAPIKey") as? String, !plist.isEmpty { return plist }
            return nil
        }
        set {
            UserDefaults.standard.set(newValue, forKey: apiKeyDefaultsKey)
        }
    }

    /// Generates a reflective journal paragraph from the user's title, mood,
    /// and (optionally) whatever they've already typed.
    static func generateEntryParagraph(title: String, mood: String?, draft: String) async throws -> String {
        guard let apiKey else { throw AIServiceError.missingAPIKey }

        var context: [String] = []
        if !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            context.append("Entry title: \(title)")
        }
        if let mood {
            context.append("Mood: \(mood)")
        }
        let trimmedDraft = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedDraft.isEmpty {
            context.append("Draft written so far (expand and refine this, keep its voice):\n\(trimmedDraft)")
        }
        if context.isEmpty {
            context.append("No details were provided; write about a small, quiet everyday moment shared with a partner.")
        }

        let userPrompt = """
        Write a single journal-entry paragraph for a couples journaling app called BOND101.

        \(context.joined(separator: "\n"))

        Requirements:
        - First person, intimate and reflective, grounded in sensory detail.
        - 60 to 110 words, one paragraph only.
        - Return only the paragraph text with no preamble, quotes, or markdown.
        """

        let body: [String: Any] = [
            "model": model,
            "max_tokens": 400,
            "system": "You are a thoughtful writing companion inside a private couples journaling app. You write warm, honest, first-person journal entries.",
            "messages": [
                ["role": "user", "content": userPrompt]
            ]
        ]

        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        let status = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard (200..<300).contains(status) else {
            let message = Self.errorMessage(from: data) ?? String(data: data, encoding: .utf8) ?? "unknown error"
            throw AIServiceError.badResponse(status: status, message: message)
        }

        guard
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
            let content = json["content"] as? [[String: Any]],
            let text = content.first(where: { $0["type"] as? String == "text" })?["text"] as? String,
            !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            throw AIServiceError.emptyCompletion
        }

        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func errorMessage(from data: Data) -> String? {
        guard
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let error = json["error"] as? [String: Any]
        else { return nil }
        return error["message"] as? String
    }
}
