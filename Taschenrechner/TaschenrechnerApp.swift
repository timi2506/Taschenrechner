import SwiftUI
import Foundation

enum CalcButton: Hashable {
    case number(String)
    case operation(Operation)
    case function(Function)
    case constant(Constant)
    case leftParen
    case rightParen
    case decimal
    case equal
    case clear
    case history
}

enum Operation: String {
    case add = "+", subtract = "-", multiply = "×", divide = "÷"
}

enum Function: String {
    case sin, cos, tan
}

enum Constant: String {
    case pi = "π"
}

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView()
        }
    }
}

struct CalculatorView: View {
    @State private var expression = ""
    @State private var display = "0"
    @State private var history: [String] = []
    @State private var errorMessage: String?
    @State private var isNewInput = true
    @State private var showHistory = false

    let layout: [[CalcButton]] = [
        [.history, .function(.sin), .function(.cos), .function(.tan)],
        [.constant(.pi), .leftParen, .rightParen, .decimal],
        [.number("7"), .number("8"), .number("9"), .operation(.divide)],
        [.number("4"), .number("5"), .number("6"), .operation(.multiply)],
        [.number("1"), .number("2"), .number("3"), .operation(.subtract)],
        [.clear, .number("0"), .equal, .operation(.add)]
    ]

    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .trailing, spacing: 4) {
                Text(expression)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(errorMessage ?? display)
                    .font(.system(size: 44, weight: .medium))
                    .foregroundColor(errorMessage == nil ? .primary : .red)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)

            ForEach(layout, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        Button {
                            handle(button)
                        } label: {
                            Text(title(for: button))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .font(.title3)
                        }
                        .buttonStyle(CalcButtonStyle(button: button))
                    }
                }
            }
        }
        .padding()
        .sheet(isPresented: $showHistory) {
            HistoryView(history: history)
        }
    }

    func handle(_ button: CalcButton) {
        errorMessage = nil

        switch button {
        case .history:
            showHistory = true

        case .number(let value):
            if isNewInput {
                display = value
                isNewInput = false
            } else {
                display += value
            }
            expression += value

        case .decimal:
            if !display.contains(",") {
                display += ","
                expression += ","
            }

        case .operation(let op):
            guard !expression.isEmpty,
                  !expression.hasSuffix("+"),
                  !expression.hasSuffix("-"),
                  !expression.hasSuffix("×"),
                  !expression.hasSuffix("÷"),
                  !expression.hasSuffix("(")
            else { return }
            expression += " \(op.rawValue) "
            isNewInput = true

        case .function(let fn):
            expression += "\(fn.rawValue)("
            isNewInput = true

        case .leftParen:
            expression += "("

        case .rightParen:
            guard balancedParentheses(afterAppending: ")") else { return }
            expression += ")"

        case .constant(.pi):
            expression += "π"
            display = format(.pi)
            isNewInput = true

        case .equal:
            let trimmed = trimInvalidEnd(expression)
            guard !trimmed.isEmpty else {
                errorMessage = "Ungültiger Ausdruck"
                return
            }

            guard let result = evaluateExpression(trimmed) else {
                errorMessage = "Mathematischer Fehler"
                return
            }

            history.append("\(trimmed) = \(format(result))")
            expression = format(result)
            display = format(result)
            isNewInput = true

        case .clear:
            expression = ""
            display = "0"
            errorMessage = nil
            isNewInput = true
        }
    }

    func trimInvalidEnd(_ expr: String) -> String {
        var result = expr.trimmingCharacters(in: .whitespaces)
        while result.hasSuffix("+")
            || result.hasSuffix("-")
            || result.hasSuffix("×")
            || result.hasSuffix("÷")
            || result.hasSuffix("(") {
            result.removeLast()
            result = result.trimmingCharacters(in: .whitespaces)
        }
        return result
    }

    func balancedParentheses(afterAppending char: String) -> Bool {
        let test = expression + char
        let open = test.filter { $0 == "(" }.count
        let close = test.filter { $0 == ")" }.count
        return close <= open
    }

    func evaluateExpression(_ expr: String) -> Double? {
        var sanitized = expr
            .replacingOccurrences(of: "π", with: "\(Double.pi)")
            .replacingOccurrences(of: ",", with: ".")
            .replacingOccurrences(of: "×", with: "*")
            .replacingOccurrences(of: "÷", with: "/")

        sanitized = resolveFunctions(in: sanitized)
        guard isValidMathExpression(sanitized) else { return nil }

        let nsExpr = NSExpression(format: sanitized)
        return nsExpr.expressionValue(with: nil, context: nil) as? Double
    }

    func isValidMathExpression(_ expr: String) -> Bool {
        let invalidPatterns = ["++", "--", "**", "//", "+*", "*/", "/+", "-*", "*+"]
        for pattern in invalidPatterns {
            if expr.contains(pattern) { return false }
        }
        return true
    }

    func resolveFunctions(in expr: String) -> String {
        var result = expr

        for fn in [Function.sin, .cos, .tan] {
            while let range = result.range(of: "\(fn.rawValue)(") {
                guard let end = matchingParen(in: result, from: range.upperBound) else { return "" }
                let inner = String(result[range.upperBound..<end])
                guard let value = Double(inner) else { return "" }

                let computed: Double
                switch fn {
                case .sin: computed = sin(value)
                case .cos: computed = cos(value)
                case .tan: computed = tan(value)
                }

                result.replaceSubrange(range.lowerBound...end, with: "\(computed)")
            }
        }
        return result
    }

    func matchingParen(in text: String, from index: String.Index) -> String.Index? {
        var depth = 1
        var i = index
        while i < text.endIndex {
            if text[i] == "(" { depth += 1 }
            if text[i] == ")" { depth -= 1 }
            if depth == 0 { return i }
            i = text.index(after: i)
        }
        return nil
    }

    func format(_ value: Double) -> String {
        let str = value.truncatingRemainder(dividingBy: 1) == 0
            ? String(Int(value))
            : String(value)
        return str.replacingOccurrences(of: ".", with: ",")
    }

    func title(for button: CalcButton) -> String {
        switch button {
        case .number(let v): return v
        case .operation(let o): return o.rawValue
        case .function(let f): return f.rawValue
        case .constant(let c): return c.rawValue
        case .leftParen: return "("
        case .rightParen: return ")"
        case .decimal: return ","
        case .equal: return "="
        case .clear: return "C"
        case .history: return "≡"
        }
    }
}

struct HistoryView: View {
    let history: [String]

    var body: some View {
        NavigationStack {
            List(history.reversed(), id: \.self) {
                Text($0)
            }
            .navigationTitle("Verlauf")
        }
    }
}

struct CalcButtonStyle: ButtonStyle {
    let button: CalcButton

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(14)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }

    var color: Color {
        switch button {
        case .number, .decimal: return .gray.opacity(0.7)
        case .operation: return .orange
        case .function, .constant, .leftParen, .rightParen: return .purple
        case .equal: return .blue
        case .clear: return .red
        case .history: return .black.opacity(0.7)
        }
    }
}
