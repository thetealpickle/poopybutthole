import SwiftSyntax
import SwiftSyntaxMacros
import SwiftSyntaxBuilder

public struct PoopyMacro: ExtensionMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        var conformances = [ExtensionDeclSyntax]()
        conformances.append(try ExtensionDeclSyntax("extension \(type.trimmed): Universable {}"))
        
        guard !declaration.is(EnumDeclSyntax.self) else {
             return conformances
        }
        
        conformances.append(try ExtensionDeclSyntax("extension \(type.trimmed): SanEnumUniversable {}"))
        return conformances
    }
}


extension PoopyMacro: MemberMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        var members = [DeclSyntax]()
        members.append(
"""
// universable conformance
var something: String { "pink" }
"""
)
        
        guard !declaration.is(EnumDeclSyntax.self) else {
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
