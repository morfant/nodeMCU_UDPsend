local buttons = {0, 5, 6, 7} --16, 14, 12, 13
local statusLED = 3
local msgSent = {false, false, false, false} 
-- local but_0 = 0
-- local but_1 = 0
-- local but_2 = 0
-- local but_3 = 0
local sensorInt = 1
local DEST_IP = "192.168.0.2"
local DEST_PORT = 9001
local msgSent_0 = false
-- local pushInt = 0
-- local PUSH_INTERVAL = 50

for i = 1, 4 do
	gpio.mode(buttons[i], gpio.INPUT) 
	gpio.write(buttons[i], gpio.LOW)
	gpio.write(buttons[i], gpio.HIGH)
end


gpio.mode(statusLED, gpio.OUTPUT)
gpio.write(statusLED, gpio.LOW)
tmr.delay(500000)
gpio.write(statusLED, gpio.HIGH)


print("Main.lua run!!")
dest = net.createConnection(net.UDP,0)
dest:connect(DEST_PORT, DEST_IP)

-- print("dest: " .. dest)
function main()

	-- dest = net.createConnection(net.UDP,0)
	-- dest:connect(9001, "192.168.0.2")
	-- tmr.delay(10000)
	-- dest:send(but_0)
	-- dest:send("im " .. but_0, function () print("data sent!") end)
	-- print("im " .. but_0)
	-- dest:close()
	-- tmr.delay(1000000)

	for i = 1, 4 do
		if gpio.read(buttons[i]) == gpio.LOW then
			gpio.write(statusLED, gpio.LOW)
			-- print("Button " ..i.. " (pin " .. buttons[i] .. ") is get LOW(Pressed)!")
			if msgSent[i] == false then
				dest:send(buttons[i])
				msgSent[i] = true
			end
		else
			gpio.write(statusLED, gpio.HIGH)
			msgSent[i] = false
			-- print("Button " ..i.. " (pin " .. buttons[i] .. ") is get HIGH(Released)!")
		end
	end
end



tmr.alarm(0, (sensorInt * 100), 1, main)

