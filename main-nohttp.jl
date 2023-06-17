using Dates

println("Pre-loop salute $(now())")
for it in 1:11
    mydata = zeros(UInt64, 1024, 16)

    # for n in 1:16
    #     mydata[:,n] .= rand(UInt64,1024)
    # end
    # println("Pre-thread salute $it $(minimum(mydata)) $(maximum(mydata)) $(now())")

    Threads.@threads for n in 1:16
        mydata[:,n] .= rand(UInt64,1024)
    end
    println("Hello $it $(minimum(mydata)) $(maximum(mydata)) $(now())")
end
