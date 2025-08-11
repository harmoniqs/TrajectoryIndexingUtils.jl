# TrajectoryIndexingUtils.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://harmoniqs.github.io/TrajectoryIndexingUtils.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://harmoniqs.github.io/TrajectoryIndexingUtils.jl/dev/)
[![Build Status](https://github.com/harmoniqs/TrajectoryIndexingUtils.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/harmoniqs/TrajectoryIndexingUtils.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/harmoniqs/TrajectoryIndexingUtils.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/harmoniqs/TrajectoryIndexingUtils.jl)

This is a super lightweight package that exports two functions: `index` and `slice`.  These functions have helped to ease the burden of handling messy indexing into trajectory data vectors of the form 

```math
\vec Z = \text{vec}\left(z_1, z_2, \ldots, z_T\right) \in \mathbf{R}^{T \cdot d}
```

where each element $z_t$ is referred to as a *knot point* and normally contains *state* variables and *control* variables. In a simple situation we might have $z_t = \text{vec} (x_t, u_t) \in \mathbf{R}^{d = n+m}$, for the state $x_t \in \mathbf{R}^n$ and control $u_t \in \mathbf{R}^m$.  In this case, with  `dim = n + m`, we can use `slice` and `index`, to extract what we want from $\vec Z$ in the following way:

* extract $z_t$:
    ```julia
    zₜ = Z⃗[slice(t, dim)]
    ```
* extract $x_t$:
    ```julia
    xₜ = Z⃗[slice(t, 1:n, dim)]
    ```
* extract $u_t$:
    ```julia
    uₜ = Z⃗[slice(t, (1:m) .+ n, dim)]
    ```
* extract $i$-th component of $x_t$:
    ```julia
    xₜⁱ = Z⃗[index(t, i, dim)]
    ```
* extract $j$-th component of $u_t$:
    ```julia
    uₜʲ = Z⃗[index(t, j + n, dim)]
    ```

With this, the user is still responsible for keeping track of the component indices for $x$ and $u$, and possibly other variables. To alleviate this nuisance, the package [NamedTrajectories.jl](https://github.com/harmoniqs/NamedTrajectories.jl) provides a richer alternative for handling trajectory data with arbitrarily named components, please check it out!


## Installation

TrajectoryIndexingUtils.jl is registered! Install in the REPL by entering pkg mode with `]` and then running 

```julia
pkg> add TrajectoryIndexingUtils
```

## Methods 

### The `index` function

```julia
index(t::Int, dim::Int) -> zₜ[dim]
index(t::Int, pos::Int, dim::Int) -> zₜ[pos]
``` 

### The `slice` function

```julia
slice(t::Int, dim::Int; stretch=0) -> zₜ[1:dim + stretch] # can be used to extract, e.g., [xₜ; xₜ₊₁], with stretch = dim
slice(t::Int, pos::Int, dim::Int) -> zₜ[1:pos]
slice(t::Int, pos1::Int, pos2::Int, dim::Int) -> zₜ[pos1:pos2]
slice(t::Int, indices::AbstractVector{Int}, dim::Int) -> zₜ[indices]
slice(ts::UnitRange{Int}, dim::Int) -> vec(zₜ for t ∈ ts)
```