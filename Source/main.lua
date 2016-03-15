
local director = require("director")
-- Sets status bar hidden
display.setStatusBar( display.HiddenStatusBar ) --Hide status bar from the beginning


local preference = require "preference"


local function main()

director:changeScene("scripts.interface","fade")


	
	return true
end




main()


