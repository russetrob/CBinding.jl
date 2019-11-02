

struct Cconst{T, S}
	mem::NTuple{S, UInt8}
	
	Cconst{T}(x) where {T} = new{T, sizeof(T)}(x)
end
Cconst{T, S}(args...; kwargs...) where {T, S} = Cconst{T}(args...; kwargs...)
Cconst{T}(; kwargs...) where {T} = Cconst(T(; kwargs...))
Cconst(::Type{T}) where {T} = Cconst{nonconst(T), sizeof(nonconst(T))}
Cconst(x) = x
Cconst(cc::Cconst) = cc
Cconst(ca::Caggregate) = Cconst{typeof(ca)}(getfield(ca, :mem))

nonconst(::Type{T}) where {T} = T
nonconst(::Type{CC}) where {T, CC<:Cconst{T}} = T

Base.convert(::Type{T}, cc::Cconst{T}) where {T} = reinterpret(T, getfield(cc, :mem)[1])
Base.convert(::Type{T}, cc::Cconst{T}) where {T<:Caggregate} = T(cc)
Base.sizeof(::Type{CC}) where {T, CC<:Cconst{T}} = sizeof(T)


_strategy(::Type{CC}) where {CA<:Caggregate, CC<:Cconst{CA}} = _strategy(nonconst(CC))
_typespec(::Type{CC}) where {CA<:Caggregate, CC<:Cconst{CA}} = _typespec(nonconst(CC))

