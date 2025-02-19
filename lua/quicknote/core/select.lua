local list = require("quicknote.core.list")
local open = require("quicknote.core.open")

local SelectNotes = function(notes, scope)
  if not notes or #notes == 0 then
    return
  else
    vim.ui.select(notes, {
            prompt = 'Select Note for ' .. scope,
    }, function(selected)
      print("Selected: ", selected)
      open.checkAndOpenNoteFile(selected)
    end)
  end

end

local M = {}

local SelectNotesForCurrentBuffer = function()

  local notes = list.ListNotesForCurrentBuffer()
  SelectNotes(notes)

end
M.SelectNotesForCurrentBuffer = SelectNotesForCurrentBuffer

local SelectNotesForCWD = function()

  local notes = list.ListNotesForCWD()
  SelectNotes(notes, "CWD")

end
M.SelectNotesForCWD = SelectNotesForCurrentBuffer

local SelectNotesForAFileOrWDInCWD = function()

  local notes = list.ListNotesForAFileOrWDInCWD()
  SelectNotes(notes, "AFileOrWDInCWD")

end
M.SelectNotesForAFileOrWDInCWD = SelectNotesForCurrentBuffer

local SelectNotesForGlobal = function()

  local notes = list.ListNotesForGlobal()
  SelectNotes(notes, "Global")

end
M.SelectNotesForGlobal = SelectNotesForCurrentBuffer

return M



