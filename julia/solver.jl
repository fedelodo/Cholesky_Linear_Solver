using MatrixMarket
using LinearAlgebra
using CSV
using DataFrames
using Glob

function systemSolver(A, xe)
  b = A * xe
  dA = cholesky(A)
  x = dA \ b
end

cd("../matrices/")
files = sort(glob("*.mtx"), by=filesize)
for (index, file) in enumerate(files)
  println("Start working on $file")
  A = MatrixMarket.mmread(file)
  xe = ones(Int,size(A)[1])
  timing = @timed systemSolver(A,xe)
  t = timing[2]
  mem = timing[3] * (10^-6)
  err = norm(timing[1]-xe)/norm(xe)
  out = DataFrame(MatriName=file,Size=size(A)[1],MemoryUsage=mem,
        Time=t,RelativeError=err)
  CSV.write("../reports/Juliareport.csv", out,writeheader = (index==1), append=true)
end
