import Foundation

struct LogMessage: ExpressibleByStringLiteral {
    let message: String
    init(stringLiteral value: String) {
        self.message = value
    }
}

func logging(_ logInstance: Any, file: String = #file, funcName: String = #function, line: Int = #line) {
    #if DEBUG
        let logMessage = "\(funcName) \(line): \(logInstance)"
        print("\(Date()): \(logMessage)")
    #endif
}

func logging(_ logInstance: LogMessage, file: String = #file, funcName: String = #function, line: Int = #line) {
    #if DEBUG
        logging(logInstance.message, funcName: funcName, line: line)
    #endif
}
