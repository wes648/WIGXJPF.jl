
using HTTP, Tar, Base.Filesystem
using CodecZlib, BufferedStreams

extract_tgz_from_url(link, dest_dir) = HTTP.open("GET", link) do io
  Tar.extract(GzipDecompressorStream(BufferedInputStream(io)), dest_dir)
end

str = @__DIR__

rm(str*"/lib", force=true, recursive=true)
mkdir(str*"/lib")
extract_tgz_from_url("http://fy.chalmers.se/subatom/wigxjpf/wigxjpf-1.11.tar.gz", str*"/lib")
cd(str*"/lib/wigxjpf-1.11")
run(`make shared`)
mv(str*"/lib/wigxjpf-1.11/lib/libwigxjpf_shared.so", str*"/libwigxjpf_shared.so")
cd(str)
rm(str*"/lib", force=true, recursive=true)

