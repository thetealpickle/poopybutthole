import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct buttMacrosPlug: CompilerPlugin {
    let providingMacros: [Macro.Type] = [PoopyMacro.self, StandMacro.self]
}
