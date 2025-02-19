local utils = require("quicknote.utils")
local path = require("plenary.path")

local M = {}

local retrieveNotes = function(noteDirPath)
    local entries = {}
    local loop = vim.loop or vim.uv
    -- check if note dir exist
    local path_exists = loop.fs_stat(noteDirPath)
    if not path_exists then
        print("No notes for provided path found.")
        return
    end

    local noteFilePaths = vim.fn.glob(noteDirPath .. "/*.md", true, true)
    if noteFilePaths == nil or #noteFilePaths == 0 then
        print("No notes found.")
        return
    else
        for _, noteFilePath in ipairs(noteFilePaths) do
            local dirNameList = path._split(path:new(noteFilePath))
            local fileName = dirNameList[#dirNameList]
            table.insert(entries, { fileName, noteFilePath })
        end
        return entries
    end
end

local RetrieveNotesForCurrentBuffer = function()
    local noteDirPath = utils.path.getNoteDirPathForCurrentBuffer()
    return retrieveNotes(noteDirPath)
end
M.RetrieveNotesForCurrentBuffer = RetrieveNotesForCurrentBuffer

local RetrieveNotesForCWD = function()
    local noteDirPath = utils.path.getNoteDirPathForCWD()
    return retrieveNotes(noteDirPath)
end
M.RetrieveNotesForCWD = RetrieveNotesForCWD

local RetrieveNotesForGlobal = function()
    local noteDirPath = utils.path.getNoteDirPathForGlobal()
    return retrieveNotes(noteDirPath)
end
M.RetrieveNotesForGlobal = RetrieveNotesForGlobal

return M
