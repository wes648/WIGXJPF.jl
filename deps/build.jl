

using BinaryBuilder
using CodecZlib
using Pkg
using Tar

name = "wigxjpf"
version = v"1.13"


sources = [
    ArchiveSource("http://fy.chalmers.se/subatom/wigxjpf/wigxjpf-latest.tar.gz", "758682aec89352723f10ed8d6133ebe88d75ea1aa4af940b1b6b60a3317b67da"),
]


script = raw"""
cd $WORKSPACE/srcdir/wigxjpf-1.12/

mkdir -p ../../destdir/lib/
mkdir -p ../../destdir/bin/

make
make shared

cp lib/libwigxjpf_shared.so ../../destdir/lib/libwigxjpf_shared.so
cp bin/wigxjpf ../../destdir/bin/wigxjpf
"""

platforms = [HostPlatform()]

products = [
    LibraryProduct("libwigxjpf_shared", :wigxjpf)
]

#dependencies = [Dependency(PackageSpec(name="CompilerSupportLibraries_jll", uuid="e66e0078-7015-5450-92f7-15fbd957f2ae"))]
dependencies = Dependency[
]

build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies, julia_compat="1.9")

target = readdir("products/")[.!(occursin.("logs",readdir("products/")))][1]
println("products/"*target)
open(GzipDecompressorStream, "products/"*target) do io
    Tar.extract(io, "products/output")
end
println("products/")
Base.Filesystem.mv("products/output/lib/libwigxjpf_shared.so", "libwigxjpf_shared.so",force=true)
#Base.Filesystem.rm("products",force=true,recursive=false)
#Base.Filesystem.rm("build",force=true,recursive=false)
#Base.Filesystem.rm("output",force=true,recursive=false)
