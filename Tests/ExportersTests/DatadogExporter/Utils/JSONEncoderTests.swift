/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

@testable import DatadogExporter
import XCTest

class JSONEncoderTests: XCTestCase {
    private let jsonEncoder = JSONEncoder.default()

    func testDateEncoding() throws {
        let encodedDate = try jsonEncoder.encode(
            EncodingContainer(Date.mockDecember15th2019At10AMUTC(addingTimeInterval: 0.123))
        )

        XCTAssertEqual(encodedDate.utf8String, #"{"value":"2019-12-15T10:00:00.123Z"}"#)
    }

    func testURLEncoding() throws {
        let encodedURL = try jsonEncoder.encode(
            EncodingContainer(URL(string: "https://example.com/foo")!)
        )

        if #available(iOS 13.0, OSX 10.15, *) {
            XCTAssertEqual(encodedURL.utf8String, #"{"value":"https://example.com/foo"}"#)
        } else {
            XCTAssertEqual(encodedURL.utf8String, #"{"value":"https:\/\/example.com\/foo"}"#)
        }
    }
}
