module CBinding
	import Libdl
	using Todo: @todo_str
	
	
	export Clongdouble, Caggregate, Cstruct, Cunion, Carray, Cenum, Clibrary, Cglobal, Cglobalconst, Cfunction, Cconvention, Calignment, Cconst, Caccessor
	export STDCALL, CDECL, FASTCALL, THISCALL
	export @ctypedef, @cstruct, @cunion, @carray, @calign, @cenum, @cextern, @cbindings
	export propertytypes
	
	
	# provide a temporary placeholder for 128-bit floating point primitive
	primitive type Clongdouble <: AbstractFloat sizeof(Cdouble)*2*8 end
	
	
	abstract type Caggregate end
	abstract type Cstruct <: Caggregate end
	abstract type Cunion <: Caggregate end
	
	abstract type Cenum{T<:Integer} <: Integer end
	
	
	# alignment strategies
	struct Calignment{SymT}
	end
	
	const ALIGN_NATIVE = Calignment{:native}
	const ALIGN_PACKED = Calignment{:packed}
	
	
	# calling conventions
	struct Cconvention{SymT}
	end
	
	const STDCALL  = Cconvention{:stdcall}
	const CDECL    = Cconvention{:cdecl}
	const FASTCALL = Cconvention{:fastcall}
	const THISCALL = Cconvention{:thiscall}
	
	
	include("clibrary.jl")
	include("cbindings.jl")
	include("cenum.jl")
	include("cconst.jl")
	include("carray.jl")
	include("caggregate.jl")
	include("caccessor.jl")
	include("cglobal.jl")
	include("cfunction.jl")
end
