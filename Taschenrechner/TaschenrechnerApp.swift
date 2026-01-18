import SwiftUI

enum CalcButton: Hashable {
    case number(String)
    case operation(Operation)
    case function(Function)
    case constant(Constant)
    case leftParen
    case rightParen
    case equal
    case clear
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
    @State private var display = "0"
    @State private var expression = ""
    @State private var history: [String] = []
    @State private var isNewInput = true

    let layout: [[CalcButton]] = [
        [.function(.sin), .function(.cos), .function(.tan), .constant(.pi)],
        [.leftParen, .rightParen, .clear, .operation(.divide)],
        [.number("7"), .number("8"), .number("9"), .operation(.multiply)],
        [.number("4"), .number("5"), .number("6"), .operation(.subtract)],
        [.number("1"), .number("2"), .number("3"), .operation(.add)],
        [.number("0"), .equal]
    ]

    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .trailing, spacing: 4) {
                Text(expression)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(display)
                    .font(.system(size: 44, weight: .medium))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)

            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(history.reversed(), id: \.self) { item in
                        Text(item)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(height: 80)

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
    }

    func handle(_ button: CalcButton) {
        switch button {
        case .number(let value):
            if isNewInput {
                display = value
                isNewInput = false
            } else {
                display += value
            }
            expression += value

        case .operation(let op):
            expression += " \(op.rawValue) "
            isNewInput = true

        case .function(let fn):
            expression += "\(fn.rawValue)("

        case .leftParen:
            expression += "("

        case .rightParen:
            expression += ")"

        case .constant(let constant):
            if constant == .pi {
                expression += "π"
                display = format(.pi)
            }

        case .equal:
            let sanitized = expression
                .replacingOccurrences(of: "×", with: "*")
                .replacingOccurrences(of: "÷", with: "/")
                .replacingOccurrences(of: "π", with: "\(Double.pi)")
                .replacingOccurrences(of: "sin", with: "sin")
                .replacingOccurrences(of: "cos", with: "cos")
                .replacingOccurrences(of: "tan", with: "tan")

            if let result = evaluate(sanitized) {
                history.append("\(expression) = \(format(result))")
                display = format(result)
                expression = format(result)
                isNewInput = true
            }

        case .clear:
            display = "0"
            expression = ""
            isNewInput = true
        }
    }

    func evaluate(_ expr: String) -> Double? {
        let expression = NSExpression(format: expr)
        return expression.expressionValue(with: nil, context: nil) as? Double
    }

    func format(_ value: Double) -> String {
        value.truncatingRemainder(dividingBy: 1) == 0
        ? String(Int(value))
        : String(value)
    }

    func title(for button: CalcButton) -> String {
        switch button {
        case .number(let v): return v
        case .operation(let o): return o.rawValue
        case .function(let f): return f.rawValue
        case .constant(let c): return c.rawValue
        case .leftParen: return "("
        case .rightParen: return ")"
        case .equal: return "="
        case .clear: return "C"
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
        case .number: return .gray.opacity(0.7)
        case .operation: return .orange
        case .function, .constant, .leftParen, .rightParen: return .purple
        case .equal: return .blue
        case .clear: return .red
        }
    }
}
