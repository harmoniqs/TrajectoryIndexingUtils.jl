## TrajectoryIndexingUtils methods

This module contains helper functions for indexing and taking slices of the full problem variable vector
definitions:

* problem vector: 
    Z = [z₁, z₂, ..., zₜ]

* knot point:
    zₜ = [xₜ, uₜ]

* augmented state vector:
    xₜ = [ψ̃ₜ, ψ̃²ₜ, ..., ψ̃ⁿₜ, ∫aₜ, aₜ, daₜ, ..., dᶜ⁻¹aₜ]

where c = control_order

also, below, we use `dim(zₜ) = dim`
examples:
```julia
Z[index(t, pos, dim)]               = zₜ[pos]
Z[index(t, dim)]                    = zₜ[dim]
Z[slice(t, pos1, pos2, dim)]        = zₜ[pos1:pos2]
Z[slice(t, pos, dim)]               = zₜ[1:pos]
Z[slice(t, dim)]                    = zₜ[1:dim] := zₜ
Z[slice(t, dim; stretch=stretch)]   = zₜ[1:(dim + stretch)]
Z[slice(t, indices, dim)]           = zₜ[indices]
Z[slice(t1:t2, dim)]                = [zₜ₁;...;zₜ₂]
```

The functions are also used to access the zₜ vectors, e.g.
```julia
zₜ[slice(i, isodim)]                             = ψ̃ⁱₜ
zₜ[n_wfn_states .+ slice(1, ncontrols)]          = ∫aₜ
zₜ[n_wfn_states .+ slice(2, ncontrols)]          = aₜ
zₜ[n_wfn_states .+ slice(augdim + 1, ncontrols)] = uₜ = ddaₜ
```

Examples below are run with:
```julia
using TrajectoryIndexingUtils
Z = collect(1.5:12.5)  # Example vector as Float64
dim = 3  # Example dimension
```

## API 

```@autodocs
Modules = [TrajectoryIndexingUtils]
```