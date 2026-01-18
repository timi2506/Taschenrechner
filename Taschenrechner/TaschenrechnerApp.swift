import SwiftUI

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
    @State private var firstNumber: Double? = nil
    @State private var operation: String? = nil
    @State private var isNewEntry = true

    let buttons: [[String]] = [
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        ["0", "C", "=", "+"]
    ]

    var body: some View {
        VStack(spacing: 12) {
            Text(display)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()

            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { item in
                        Button(item) {
                            handleInput(item)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
        .padding()
    }

    func handleInput(_ input: String) {
        if let number = Double(input) {
            if isNewEntry {
                display = input
                isNewEntry = false
            } else {
                display += input
            }
        } else if input == "C" {
            display = "0"
            firstNumber = nil
            operation = nil
            isNewEntry = true
        } else if input == "=" {
            if let first = firstNumber,
               let op = operation,
               let second = Double(display) {
                let result: Double
                switch op {
                case "+": result = first + second
                case "-": result = first - second
                case "*": result = first * second
                case "/": result = second != 0 ? first / second : 0
                default: result = 0
                }
                display = String(result)
                firstNumber = nil
                operation = nil
                isNewEntry = true
            }
        } else {
            firstNumber = Double(display)
            operation = input
            isNewEntry = true
        }
    }
}
