local o = vim.o

o.statusline = ""
o.statusline = o.statusline .. "%f "
                            .. "%y |"
                            .. "%="
                            .. "| [%l,%c]  "
                            .. "%p%% "
