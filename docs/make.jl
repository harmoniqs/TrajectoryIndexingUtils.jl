using TrajectoryIndexingUtils

pages=[
    "Home" => "index.md",
]

# Check if utils.jl exists and warn if not found
utils_path = joinpath(@__DIR__, "utils.jl")
if !isfile(utils_path)
    error("docs/utils.jl is required but not found. Please run get_docs_utils.sh")
end

include("utils.jl")

generate_docs(
    @__DIR__,
    "TrajectoryIndexingUtils",
    TrajectoryIndexingUtils,
    pages;
    make_assets = false,
    make_index = true,
    make_literate = false,
    format_kwargs = (canonical = "https://docs.harmoniqs.co/TrajectoryIndexingUtils.jl",),
)