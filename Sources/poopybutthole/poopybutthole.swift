public protocol Universable {
    
    var something: String { get }
}

public protocol SanEnumUniversable {
    
    var thing: String { get set }
}


@attached(extension, conformances: Universable, SanEnumUniversable)
@attached(member, names: named(something), named(thing))
public macro Plant() = #externalMacro(module: "butt", type: "PoopyMacro")

@attached(extension, conformances: SanEnumUniversable)
@attached(member, names: named(thing))
public macro Stand() = #externalMacro(module: "butt", type: "StandMacro")
