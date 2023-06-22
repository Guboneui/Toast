//  MainThreadChecker.swift

import Foundation

struct ThreadChecker {
  @discardableResult
  static func check<T>(_ operation: () -> T) -> T {
    if !Thread.isMainThread {
      return DispatchQueue.main.sync {
        return operation()
      }
    } else {
      return operation()
    }
  }
}
