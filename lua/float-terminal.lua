-- float-terminal.lua
local api = vim.api
local buf, win

local function printHelloNvim()
		print(vim.api.nvim_win_get_width(0))
		print("hello nvim! aaa")
end

local function open_window()
		buf = api.nvim_create_buf(false,true)
		local width = api.nvim_get_option("columns")
		local height = api.nvim_get_option("lines")

		local win_height = math.ceil(height * 0.8 - 4)
		local win_width = math.ceil(width * 0.8)
		local row = math.ceil((height - win_height) / 2 - 1)
		local col = math.ceil((width - win_width) / 2)

		local opts = {
				style = "minimal",
				relative = "editor",
				width = win_width,
				height = win_height,
				row = row,
				col = col
		}

		win = api.nvim_open_win(buf, true, opts)
		api.nvim_win_set_option(win, 'cursorline', true) -- it highlight line with the cursor on it
end

local function update_view()
		vim.api.nvim_buf_set_option(buf, 'modifiable', true)
		local result = vim.api.nvim_call_function('systemlist', {
				'ls'
		})
		api.nvim_buf_set_lines(buf, 0, -1, false, result)
		vim.api.nvim_buf_set_option(buf, 'modifiable', false)
end

local function set_mappings()
		local mappings = {
				q = 'close_window()',
		}

		for k,v in pairs(mappings) do
				api.nvim_buf_set_keymap(buf, 'n', k, ':lua require"whid".'..v..'<cr>', {
						nowait = true, noremap = true, silent = true
				})
		end
		local other_chars = {
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'n', 'o', 'p', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
		}
		for k,v in ipairs(other_chars) do
				api.nvim_buf_set_keymap(buf, 'n', v, '', { nowait = true, noremap = true, silent = true })
				api.nvim_buf_set_keymap(buf, 'n', v:upper(), '', { nowait = true, noremap = true, silent = true })
				api.nvim_buf_set_keymap(buf, 'n',  '<c-'..v..'>', '', { nowait = true, noremap = true, silent = true })
		end
end

local function printFloatTerminal()
		open_window()
		set_mappings()
		update_view()
end

return {
		printHelloNvim = printHelloNvim,
		printFloatTerminal = printFloatTerminal,
		update_view = update_view
}

