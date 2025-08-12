module TrajectoryIndexingUtils


export index
export slice

"""
    index(t::Int, pos::Int, dim::Int)
Calculate the index in the full problem vector for a given time step `t`, position `pos`, and dimension `dim`.

```jldoctest
julia> Z[index(1, 1, 3)]
1.5
```
"""
index(t::Int, pos::Int, dim::Int)::Int = dim * (t - 1) + pos

"""
    index(t::Int, dim::Int)
Calculate the index in the full problem vector for a given time step `t` and dimension `dim`. Assumes `pos` is equal to `dim`.

```jldoctest
julia> Z[index(1, dim)]
3.5
```
"""
index(t, dim)::Int = index(t, dim, dim)


"""
    slice(t::Int, pos1::Int, pos2::Int, dim::Int)
Calculate slice of the full problem vector for a given time step `t`, starting position `pos1`, and ending position `pos2`.

```jldoctest
julia> Z[slice(2, 1, 3, 3)]
3-element Vector{Float64}:
 4.5
 5.5
 6.5
```
"""
slice(t::Int, pos1::Int, pos2::Int, dim::Int)::AbstractVector =
    index(t, pos1, dim):index(t, pos2, dim)

"""
    slice(t::Int, pos::Int, dim::Int)
Calculate slice of the problem vector for a given time step `t`, up to position `pos`. Equivalent to `slice(t, 1, pos, dim)`.'

```jldoctest
julia> Z[slice(2, 2, 3)]
2-element Vector{Float64}:
 4.5
 5.5
```
"""
slice(t::Int, pos::Int, dim::Int)::AbstractVector = slice(t, 1, pos, dim)

"""
    slice(t::Int, dim::Int; stretch=0)
Calculate slice of the problem vector for a given time step `t`, with an optional stretch parameter

```jldoctest
julia> Z[slice(2, 3; stretch=1)]
4-element Vector{Float64}:
 4.5
 5.5
 6.5
 7.5
```
"""
slice(t::Int, dim::Int; stretch=0)::AbstractVector = slice(t, 1, dim + stretch, dim)

"""
    slice(t::Int, indices::AbstractVector{Int}, dim::Int)
Calculate slice of the problem vector for a given time step `t` and a vector of indices `indices`.

```jldoctest
julia> Z[slice(2, [1, 3], 3)]
2-element Vector{Float64}:
 4.5
 6.5
```
"""
slice(t::Int, indices::AbstractVector{Int}, dim::Int)::AbstractVector =
    dim * (t - 1) .+ indices

"""
    slice(ts::UnitRange{Int}, dim::Int)
Calculate slice of the problem vector for a range of time steps `ts` that covers each of the knot-points in those steps.

```jldoctest
julia> Z[slice(1:2, 3)]
6-element Vector{Float64}:
 1.5
 2.5
 3.5
 4.5
 5.5
 6.5
```
"""
slice(ts::UnitRange{Int}, dim::Int)::AbstractVector = slice(ts[1], length(ts) * dim, dim)

end
