---@module "picker.colorscheme"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable: undefined-field
local wt_format = require("wezterm").format

local Utils = require "utils"
local Picker, Layout = Utils.class.picker, Utils.class.layout

return Picker.new {
  title = "Colorscheme picker",
  subdir = "colorschemes",
  fuzzy = true,

  build = function(__choices)
    local choices = {}
    for _, opts in pairs(__choices) do
      local id, label = opts.value.id, opts.value.label
      local colors = opts.module.scheme
      ---@cast label string

      local ChoiceLayout = Layout:new() ---@class Layout
      for i = 1, #colors.ansi do
        local bg = colors.ansi[i]
        ChoiceLayout:push("none", bg, " ")
      end

      ChoiceLayout:push("none", "none", "   ")
      for i = 1, #colors.brights do
        local bg = colors.brights[i]
        ChoiceLayout:push("none", bg, " ")
      end

      ChoiceLayout:push("none", "none", (" "):rep(5))
      ChoiceLayout:push("none", "white", label)
      choices[#choices + 1] = { label = wt_format(ChoiceLayout), id = id }
    end

    table.sort(choices, function(a, b)
      return a.id < b.id
    end)

    return choices
  end,
}
