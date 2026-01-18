import SwiftUI

enum CalcButton: String, CaseIterable {
    case zero = "0", one = "1", two = "2", three = "3", four = "4"
    case five = "5", six = "6", seven = "7", eight = "8", nine = "9"
    case add = "+", subtract = "-", multiply = "×", divide = "÷"
    case equal = "=", clear = "C"

    var type: ButtonType {
        switch self {
        case .add, .subtract, .multiply, .divide:
            return .operation
        case .equal:
            return .equal
        case .clear:
            return .clear
        default:
            return .number
        }
    }
}

enum ButtonType {
    case number, operation, equal, clear
}

struct CalculatorView: View {
    @State private var display = "0"
    @State private var currentValue: Double = 0
    @State private var pendingOperation: CalcButton? = nil
    @State private var isNewInput = true

    let layout: [[CalcButton]] = [
        [.seven, .eight, .nine, .divide],
        [.four, .five, .six, .multiply],
        [.one, .two, .three, .subtract],
        [.clear, .zero, .equal, .add]
    ]

    var body: some View {
        VStack(spacing: 16) {
            Text(display)
                .font(.system(size: 48, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)

            ForEach(layout, id: \.self) { row in
                HStack(spacing: 16) {
                    ForEach(row, id: \.self) { button in
                        Button {
                            handle(button)
                        } label: {
                            Text(button.rawValue)
                                .font(.title2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .buttonStyle(CalcButtonStyle(type: button.type))
                    }
                }
            }
        }
        .padding()
    }

    func handle(_ button: CalcButton) {
        switch button.type {
        case .number:
            if isNewInput {
                display = button.rawValue
                isNewInput = false
            } else {
                display += button.rawValue
            }

        case .operation:
            currentValue = Double(display) ?? 0
            pendingOperation = button
            isNewInput = true

        case .equal:
            guard let op = pendingOperation else { return }
            let secondValue = Double(display) ?? 0
            let result = calculate(currentValue, secondValue, op)
            display = String(result)
            pendingOperation = nil
            isNewInput = true

        case .clear:
            display = "0"
            currentValue = 0
            pendingOperation = nil
            isNewInput = true
        }
    }

    func calculate(_ a: Double, _ b: Double, _ op: CalcButton) -> Double {
        switch op {
        case .add: return a + b
        case .subtract: return a - b
        case .multiply: return a * b
        case .divide: return b != 0 ? a / b : 0
        default: return 0
        }
    }
}

struct CalcButtonStyle: ButtonStyle {
    let type: ButtonType

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .background(background)
            .cornerRadius(14)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }

    var background: Color {
        switch type {
        case .number: return .gray.opacity(0.7)
        case .operation: return .orange
        case .equal: return .blue
        case .clear: return .red
        }
    }
}

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView()
        }
    }
}
