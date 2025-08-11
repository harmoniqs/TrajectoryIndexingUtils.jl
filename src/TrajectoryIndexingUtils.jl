module TrajectoryIndexingUtils

@doc raw"""
```
TrajectoryIndexingUtils

this module contains helper functions for indexing and taking slices of the full problem variable vector
definitions:
the problem vector: Z = [z₁, z₂, ..., zT]
    knot point:
        zₜ = [xₜ, uₜ]
    augmented state vector:
        xₜ = [ψ̃ₜ, ψ̃²ₜ, ..., ψ̃ⁿₜ, ∫aₜ, aₜ, daₜ, ..., dᶜ⁻¹aₜ]
    where:
        c = control_order
also, below, we use dim(zₜ) = dim
examples:
Z[index(t, pos, dim)] = zₜ[pos]
Z[index(t, dim)]      = zₜ[dim]
Z[slice(t, pos1, pos2, dim)]      = zₜ[pos1:pos2]
Z[slice(t, pos, dim)]             = zₜ[1:pos]
Z[slice(t, dim)]                  = zₜ[1:dim] := zₜ
Z[slice(t, dim; stretch=stretch)] = zₜ[1:(dim + stretch)]
Z[slice(t, indices, dim)]         = zₜ[indices]
Z[slice(t1:t2, dim)]              = [zₜ₁;...;zₜ₂]
the functions are also used to access the zₜ vectors, e.g.
zₜ[slice(i, isodim)]                             = ψ̃ⁱₜ
zₜ[n_wfn_states .+ slice(1, ncontrols)]          = ∫aₜ
zₜ[n_wfn_states .+ slice(2, ncontrols)]          = aₜ
zₜ[n_wfn_states .+ slice(augdim + 1, ncontrols)] = uₜ = ddaₜ
"""

Examples below are run with:
```jldoctest
using TrajectoryIndexingUtils
Z = collect(1:12)  # Example vector
dim = 3  # Example dimension
```
"""

export index
export slice

"""
    index(t::Int, pos::Int, dim::Int)
Calculate the index in the full problem vector for a given time step `t`, position `pos`, and dimension `dim`.

```jldoctest
julia> Z[index(1, 1, 3)]
1
```
"""
index(t::Int, pos::Int, dim::Int) = dim * (t - 1) + pos

"""
    index(t::Int, dim::Int)
Calculate the index in the full problem vector for a given time step `t` and dimension `dim`. Assumes `pos` is equal to `dim`.

```jldoctest
julia> Z[index(t, dim)]
3
```
"""
index(t, dim) = index(t, dim, dim)

"""
    slice(t::Int, pos1::Int, pos2::Int, dim::Int)
Calculate slice of the full problem vector for a given time step `t`, starting position `pos1`, and ending position `pos2`.

```jldoctest
julia> Z[slice(2, 1, 3, 3)]
4:6
```
"""
slice(t::Int, pos1::Int, pos2::Int, dim::Int) =
    index(t, pos1, dim):index(t, pos2, dim)

"""
    slice(t::Int, pos::Int, dim::Int)
Calculate slice of the problem vector for a given time step `t`, up to position `pos`.
equivalent to `slice(t, 1, pos, dim)`.
```jldoctest
julia> Z[slice(2, 2, 3)]
4:5
```
"""
slice(t::Int, pos::Int, dim::Int) = slice(t, 1, pos, dim)

"""
    slice(t::Int, dim::Int; stretch=0)
    Calculate slice of the problem vector for a given time step `t`, with an optional stretch parameter
```jldoctest
julia> Z[slice(2, 3; stretch=1)]
4:7
```
"""
slice(t::Int, dim::Int; stretch=0) = slice(t, 1, dim + stretch, dim)

"""
    slice(t::Int, indices::AbstractVector{Int}, dim::Int)
    Calculate slice of the problem vector for a given time step `t` and a vector of indices `indices`.
```jldoctest
julia> Z[slice(2, [1, 3], 3)]
4-element Vector{Int64}:
4
6
```
"""
slice(t::Int, indices::AbstractVector{Int}, dim::Int) =
    dim * (t - 1) .+ indices

"""
    slice(ts::UnitRange{Int}, dim::Int)
Calculate slice of the problem vector for a range of time steps `ts` that covers each of the knot-points in those steps.
```jldoctest
Z[slice(1:2, 3)]
4-element Vector{Int64}:
1
2
3
4
```
"""
slice(ts::UnitRange{Int}, dim::Int) = slice(ts[1], length(ts) * dim, dim)

end
