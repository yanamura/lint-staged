import XCTest

import LintStagedTests

var tests = [XCTestCaseEntry]()
tests += LintStagedTests.allTests()
XCTMain(tests)
