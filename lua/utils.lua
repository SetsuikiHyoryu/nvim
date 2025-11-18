local Utils = {}

Utils.is_windows = vim.fn.has 'win32' == 1

--- @class ArrayFromOption
--- @field start number|nil 开始的数字。
--- @field stop number 结束时的数字。

--- JavaScript like arrary from.
--- @param option ArrayFromOption
--- @param callback fun(index: number): any
Utils.array_from = function(option, callback)
  local result = {}

  for i = option.start or 0, option.stop do
    result[#result + 1] = callback(i)
  end

  return result
end

return Utils
