local Utils = {}

Utils.isWindows = vim.fn.has 'win32' == 1

return Utils
