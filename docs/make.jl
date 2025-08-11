using TrajectoryIndexingUtils
using PiccoloDocsTemplate

pages=[
    "Home" => "index.md",
    "Library" => "lib.md",
]

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