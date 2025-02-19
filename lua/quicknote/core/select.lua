local utils = require("quicknote.utils")
local retrieve = require("quicknote.core.retrieve")
local open = require("quicknote.core.open")

local M = {}

local SelectNotes = function(notes, scope)
  if not notes or #notes == 0 then
    print("No notes to select from.")
    return
  else
    vim.ui.select(notes, {
            prompt = 'Select Note for ' .. scope,
            format_item = function(item)
                return item[1]
            end
    }, function(selected)
      open.checkAndOpenNoteFile(selected[2])
    end)
  end
end

local SelectNotesForCurrentBuffer = function()
  local notes = retrieve.RetrieveNotesForCurrentBuffer()
  SelectNotes(notes, "Current Buffer")
end
M.SelectNotesForCurrentBuffer = SelectNotesForCurrentBuffer

local SelectNotesForCWD = function()
  local notes = retrieve.RetrieveNotesForCWD()
  SelectNotes(notes, "CWD")
end
M.SelectNotesForCWD = SelectNotesForCWD

local SelectNotesForGlobal = function()
  if utils.config.GetMode() ~= "resident" then
      error("Global scope is only available in resident mode")
  end
  local notes = retrieve.RetrieveNotesForGlobal()
  SelectNotes(notes, "Global")
end
M.SelectNotesForGlobal = SelectNotesForGlobal

return M



