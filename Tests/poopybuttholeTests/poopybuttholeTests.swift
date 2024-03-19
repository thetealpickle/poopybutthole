import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
//#if canImport(poopybuttholeMacros)
import butt

let testMacros: [String: Macro.Type] = [
    "pla": PoopyMacro.self,
    "sta": StandMacro.self
]
//#endif

final class poopybuttholeTests: XCTestCase {
    func testPoopyMacro() {
        assertMacroExpansion(
"""
@pla
struct Test {}
"""
            , expandedSource:
"""
struct Test {

    // universable conformance
    var something: String {
        "pink"
    }

    // sans enum universable conformance
    var thing: String = "yellow"}

extension Test: Universable {
}

extension Test: SanEnumUniversable {
}
""", macros: testMacros)
    }
    
    func testStandMacro() {
        assertMacroExpansion(
        """
@sta
enum Test {}
""", 
        expandedSource:
"""
enum Test {}
""", 
        diagnostics: [.init(message: StandDia.enumDetected.message, line: 1, column: 1)],
        macros: testMacros)
    }
}
