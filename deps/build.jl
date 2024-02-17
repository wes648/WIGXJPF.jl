

using BinaryBuilder
using CodecZlib
using Pkg
using Tar

name = "wigxjpf"
version = v"1.11"


sources = [
    ArchiveSource("http://fy.chalmers.se/subatom/wigxjpf/wigxjpf-1.11.tar.gz", "5d078bbbf87c917d0df3c5e2204cbd8a51041517630ac84bdca728611ea2f12f"),
]


script = raw"""
cd $WORKSPACE/srcdir/wigxjpf-1.11/

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
