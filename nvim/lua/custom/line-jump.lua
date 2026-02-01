local mark_ids = {}
local ns_id = vim.api.nvim_create_namespace("my_namespace")

local function chars(str)
  local result = {}
  for i = 1, #str do
    result[i] = string.sub(str, i, i)
  end
  return result
end

local top_chars = chars("gfdsartbewqvcxzGFDSARTEWQVCXZ123`")
local bottom_chars = chars("hjkl;'yuiop[nm,./HJKL:\"UIOP{NM<>?")
local line_index = {}

vim.keymap.set(
  {"n", "v", "o", "x"},
  "<leader>l",
  function()
    local match_id = vim.fn.matchadd('Comment', '.')

    local top_line = vim.fn.line('w0')   -- top visible line in window
    local bottom_line = vim.fn.line('w$') -- bottom visible line in window
    local middle_line = math.floor(top_line + vim.api.nvim_win_get_height(0) / 2)

    if #mark_ids > 0 then
      for _, mark_id in ipairs(mark_ids) do
        vim.api.nvim_buf_del_extmark(0, ns_id, mark_id)
      end
      mark_ids = {}
      vim.fn.matchdelete(match_id)
      return
    end

    local total_lines = vim.api.nvim_buf_line_count(0)

    for i = 1, #bottom_chars do
      local mark_line_no = middle_line + i - 2
      local mark_char = bottom_chars[i]

      if mark_line_no >= 1 and mark_line_no <= total_lines then
        local mark_id = vim.api.nvim_buf_set_extmark(
          0,  -- current buffer id
          ns_id,
          mark_line_no,  -- line
          0,  -- col
          { virt_text = {{mark_char, "WarningMsg"}}, virt_text_pos = "overlay", }
        )
        table.insert(mark_ids, mark_id)
        line_index[mark_char] = mark_line_no + 1
      end

    end

    for i = 1, #top_chars do
      local mark_line_no = middle_line - i - 1
      local mark_char = top_chars[i]

      if mark_line_no >= 1 and mark_line_no <= total_lines then
        local mark_id = vim.api.nvim_buf_set_extmark(
          0,  -- current buffer id
          ns_id,
          mark_line_no,  -- line
          0,  -- col
          { virt_text = {{mark_char, "WarningMsg"}}, virt_text_pos = "overlay", }
        )
        table.insert(mark_ids, mark_id)
        line_index[mark_char] = mark_line_no + 1
      end

    end

    vim.cmd("redraw")  -- Force UI to update immediately
    local key = vim.fn.getchar()
    local char = vim.fn.nr2char(key)


    local char_in_top_chars = false
    for i = 1, #top_chars do
      if char == top_chars[i] then
        char_in_top_chars = true
        break
      end
    end

    local char_in_bottom_chars = false
    for i = 1, #bottom_chars do
      if char == bottom_chars[i] then
        char_in_bottom_chars = true
        break
      end
    end


    if not (char_in_top_chars or char_in_bottom_chars) then
      for _, mark_id in ipairs(mark_ids) do
        vim.api.nvim_buf_del_extmark(0, ns_id, mark_id)
      end
      mark_ids = {}
      return
      vim.fn.matchdelete(match_id)
    end


    local line_to_jump = line_index[char]

    vim.api.nvim_win_set_cursor(0, {line_to_jump, 0})

    if #mark_ids > 0 then
      for _, mark_id in ipairs(mark_ids) do
        vim.api.nvim_buf_del_extmark(0, ns_id, mark_id)
      end
      mark_ids = {}
      vim.fn.matchdelete(match_id)
      return
    end
  end,
  { desc = "Jump to line" }
)


