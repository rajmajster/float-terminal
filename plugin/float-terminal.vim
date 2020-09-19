fun! FloatTerminal()
		lua for k in pairs(package.loaded) do if k:match("^float%-terminal") then package.loaded[k] = nil end end
		lua require("float-terminal").printFloatTerminal()
endfun

augroup FloatTerminal
		autocmd!
augroup END
