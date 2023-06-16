# gcloud run deploy helloworld --source . --allow-unauthenticated

using HTTP

using Dates

myport = parse(Int, get(ENV, "PORT", "8080"))

# myaddr = HTTP.Sockets.localhost
myaddr = "0.0.0.0"

HTTP.serve(myaddr, myport) do request::HTTP.Request
    @show request
    @show request.method
    @show HTTP.header(request, "Content-Type")
    @show HTTP.payload(request)
    try

        mydata = zeros(UInt64, 1024, 16)
        Threads.@threads for n in 1:16
            mydata[:,n] .= rand(UInt64,1024)
        end

        return HTTP.Response("Hello $(minimum(mydata)) $(maximum(mydata)) $(now())")
    catch e
        return HTTP.Response(404, "Error: $e")
    end
end
