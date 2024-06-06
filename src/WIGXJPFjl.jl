module WIGXJPFjl

using Wigxjpf_jll

export wig3j, wig6j, wig9j, wig3jj, wig6jj, wig9jj


function __init__()
    max_two_j = 1000
    ccall((:wig_table_init, wigxjpf),
          Cvoid,
          (Cint, Cint),
          max_two_j, 9)
    Threads.@threads :static for i in 1:Threads.nthreads()
    ccall((:wig_thread_temp_init, wigxjpf),
          Cvoid,
          (Cint,),
          max_two_j)
    end
end

doubled(i::Integer)::Int = 2i
doubled(r::Rational)::Int = Int(2r)
doubled(f::Float64)::Int = Int(2.0*f)


function wig3jj(j12::Integer, j22::Integer, j32::Integer,
                m12::Integer, m22::Integer, m32::Integer)
    ccall((:wig3jj, wigxjpf),
          Cdouble,
          (Cint, Cint, Cint,
           Cint, Cint, Cint),
          j12, j22, j32,
          m12, m22, m32)
end

wig3j(j1, j2, j3,
      m1, m2, m3) = wig3jj(doubled(j1), doubled(j2), doubled(j3),
                           doubled(m1), doubled(m2), doubled(m3))

function wig6jj(j12::Integer, j22::Integer, j32::Integer,
                j42::Integer, j52::Integer, j62::Integer)
    ccall((:wig6jj, wigxjpf),
          Cdouble,
          (Cint, Cint, Cint,
           Cint, Cint, Cint),
          j12, j22, j32,
          j42, j52, j62)
end

wig6j(j1, j2, j3,
      j4, j5, j6) = wig6jj(doubled(j1), doubled(j2), doubled(j3),
                           doubled(j4), doubled(j5), doubled(j6))

function wig9jj(j12::Integer, j22::Integer, j32::Integer,
               j42::Integer, j52::Integer, j62::Integer,
               j72::Integer, j82::Integer, j92::Integer)
    ccall((:wig9jj, wigxjpf),
          Cdouble,
          (Cint, Cint, Cint,
           Cint, Cint, Cint,
           Cint, Cint, Cint),
          j12, j22, j32,
          j42, j52, j62,
          j72, j82, j92)
end

wig9j(j1, j2, j3,
      j4, j5, j6,
      j7, j8, j9) = wig9jj(doubled(j1), doubled(j2), doubled(j3),
                           doubled(j4), doubled(j5), doubled(j6),
                           doubled(j7), doubled(j8), doubled(j9))


end # module
