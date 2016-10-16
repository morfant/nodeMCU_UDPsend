local but_0 = 0
local but_1 = 0
local but_2 = 0
local but_3 = 0
local sensorInt = 1
local DEST_IP = "192.168.0.2"
local DEST_PORT = 9001
local msgSent_0 = false
-- local pushInt = 0
-- local PUSH_INTERVAL = 50

gpio.mode(but_0, gpio.INPUT)

gpio.mode(3, gpio.OUTPUT)
gpio.write(3, gpio.LOW)
tmr.delay(500000)
gpio.write(3, gpio.HIGH)


gpio.write(but_0, gpio.LOW)
gpio.write(but_0, gpio.HIGH)


print("Main.lua run!!")


-- print("dest: " .. dest)
-- dest:on("connection", function(sck, c)
--   -- Wait for connection before sending.
--     print("Connected to " .. DEST_IP)
-- 	tmr.alarm(0, (sensorInt * 100), 1, main)
-- end)

function main()
	if gpio.read(but_0) == gpio.LOW then
		gpio.write(3, gpio.LOW)
		print("But_0(gpio 5) is LOW")
		if msgSent_0 == false then
			dest = net.createConnection(net.UDP,0)
			dest:connect(DEST_PORT, DEST_IP)
			dest:send("im " .. but_0)
			dest:close()
			msgSent_0 = true
		end
		-- pushInt = pushInt + 1;
		-- if pushInt > PUSH_INTERVAL then gpio.write(but_0, gpio.HIGH) end
		-- print("pushInt: " .. pushInt)
	else
		-- pushInt = 0
		-- gpio.write(3, gpio.HIGH)
		msgSent_0 = false
		print("But_0(gpio 5) is HIGH")
	end
end



tmr.alarm(0, (sensorInt * 100), 1, main)

