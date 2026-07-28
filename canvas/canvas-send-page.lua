#!/usr/local/bin/lua

local lms  = require("canvas-lms")
local dump = require "pl.pretty".dump

local canvas = lms:new("canvas-config.lua")

canvas:get_pages()

local htmlfile = arg[1]

print("Lua send page: "..htmlfile)

for title,page in pairs(canvas.pages) do
  if page.url..".html" == htmlfile then
    print(title)
    local content
    local file = io.open("pages/"..htmlfile, "r")  -- open in read mode
    if file then
      content = file:read("*a")    -- read entire file
      file:close()
    else
      print("Failed to open file: ", filename)
    end
    xx = canvas:update_page(title,{body=content})
    print("Done.")
  end
end
