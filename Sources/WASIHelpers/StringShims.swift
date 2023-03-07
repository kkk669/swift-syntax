//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2019 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation

#if os(WASI)
public enum WASIStringError: Error {
  case encoding
}

extension String {
  public func write(
    to url: URL,
    atomically useAuxiliaryFile: Bool,
    encoding enc: String.Encoding
  ) throws {
    guard let data = data(using: enc) else {
      throw WASIStringError.encoding
    }
    try data.write(to: url, options: useAuxiliaryFile ? .atomic : [])
  }
}
#endif
