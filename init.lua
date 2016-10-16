-- wait 10000 msec then call yourfile.lua
tmr.alarm(0, 5000, 0, function() dofile("wc.lua") end )
-- tmr.alarm(0, 5000, 0, function() dofile("main.lua") end )