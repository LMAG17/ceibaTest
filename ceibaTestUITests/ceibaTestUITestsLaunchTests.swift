//
//  ceibaTestUITestsLaunchTests.swift
//  ceibaTestUITests
//
//  Created by Luis Miguel Alvarez Gil on 28/01/23.
//

import XCTest

class ceibaTestUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
