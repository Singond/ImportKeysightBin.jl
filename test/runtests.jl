using Test
using ImportKeysightBin

data = importkeysightbin("test/perioda00001.bin")

@test length(data) == 5

channels = data[1:4]
for ch in channels
	@test length(ch) == 2
	local x, y = ch
	@test length(x) == length(y)
end

x, y = channels[1]
@test x ≈ 3.75875e-8:6.25e-12:5.758125e-8 atol=0.01

x, y = channels[2]
@test maximum(y) ≈ 0.21887 atol=0.00001

metadata = data[5]
@test metadata[:version] == "10"
@test metadata[:size] == 51820
@test metadata[:nwaveforms] == 4
