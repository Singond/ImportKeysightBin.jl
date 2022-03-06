module ImportKeysightBin

export importkeysightbin

@enum WaveformType begin
	unknownwaveform = 0
	normal = 1
	peakdetect = 2
	average = 3
	logic = 6
end

@enum Unit begin
	unknownunit = 0
	volt = 1
	second = 2
	constant = 3
	ampere = 4
	decibel = 5
	hertz = 6
end

@enum BufferType begin
	unknowbuf = 0
	float32 = 1
	maxfloat = 2
	minfloat = 3
	char = 6
end

function importkeysightbin(f::IO)
	# File header
	cookie = String(read(f, 2))
	if cookie != "AG"
		error("Unsupported file format")
	end
	meta = Dict{Symbol,Any}()
	meta[:version] = String(read(f, 2))
	meta[:size] = read(f, Int32)
	meta[:nwaveforms] = read(f, Int32)
	meta[:waveforms] = Vector{Dict{Symbol,Any}}(undef, meta[:nwaveforms])
	xx = Vector()
	yy = Vector()

	# Waveforms
	for wf_n in 1:meta[:nwaveforms]
		wf = Dict{Symbol,Any}()
		meta[:waveforms][wf_n] = wf
		wf[:headersize] = read(f, Int32)
		wf[:type] = WaveformType(read(f, Int32))
		wf[:buffers] = read(f, Int32)
		wf[:points] = read(f, Int32)
		wf[:count] = read(f, Int32)
		wf[:xdisplayrange] = read(f, Float32)
		wf[:xdisplayorigin] = read(f, Float64)
		wf[:xincrement] = read(f, Float64)
		wf[:xorigin] = read(f, Float64)
		wf[:xunits] = Unit(read(f, Int32))
		wf[:yunits] = Unit(read(f, Int32))
		wf[:date] = rstrip(String(read(f, 16)), '\0')
		wf[:time] = rstrip(String(read(f, 16)), '\0')
		wf[:frame] = rstrip(String(read(f, 24)), '\0')
		wf[:label] = rstrip(String(read(f, 16)), '\0')
		wf[:timetags] = read(f, Float64)
		wf[:segmentindex] = read(f, UInt32)
		wf[:datasets] = Vector{Dict{Symbol,Any}}(undef, wf[:buffers])
		x = range(start=wf[:xorigin], step=wf[:xincrement], length=wf[:points])
		y = zeros(wf[:points], wf[:buffers])
		push!(xx, x)
		push!(yy, y)

		# Data sets
		for ds_n in 1:wf[:buffers]
			ds = Dict{Symbol,Any}()
			wf[:datasets][ds_n] = ds
			ds[:headersize] = read(f, Int32)
			ds[:buffertype] = BufferType(read(f, Int16))
			ds[:bytesperpoint] = read(f, Int16)
			ds[:buffersize] = read(f, Int32)
			y[:,ds_n] = reinterpret(Float32, read(f, ds[:buffersize]))
		end
	end
	(xx, yy, meta)
end

function importkeysightbin(filename::AbstractString)
	f = open(filename)
	data = importkeysightbin(f)
	close(f)
	return data
end

end
