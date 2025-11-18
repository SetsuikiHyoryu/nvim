local Utils = {}

Utils.is_windows = vim.fn.has 'win32' == 1

return Utils
