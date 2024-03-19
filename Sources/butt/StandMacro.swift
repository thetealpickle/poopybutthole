import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxBuilder

public struct StandMacro: ExtensionMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        var conformances = [ExtensionDeclSyntax]()
        
        guard !declaration.is(EnumDeclSyntax.self) else {
            
            // update with dia
            let dia = Diagnostic(node:node, message: StandDia.enumDetected)
            context.diagnose(dia)
            return conformances
        }
        conformances.append(try ExtensionDeclSyntax("extension \(type.trimmed): SanEnumUniversable {}"))
        return conformances
    }
}

public enum StandDia: String, DiagnosticMessage {
    case enumDetected
    case blah
    
    public var message: String {
        switch self {
        case .enumDetected : "erm, enum detected. not allowed human 🛑"
        case .blah: ""
        }
    }
    
    public var severity: DiagnosticSeverity {
        switch self {
        case .enumDetected, .blah: .error
        }
    }
    
    public var diagnosticID: MessageID {
        .init(domain: "butt", id: self.rawValue)
    }
}


extension StandMacro: MemberMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        var members = [DeclSyntax]()
        guard !declaration.is(EnumDeclSyntax.self) else {
            
            // update dia
            return members
        }
        
        members.append(
"""
// sans enum universable conformance
var thing: String = "yellow"
"""
)
        return members
    }
}
