local M = {}

function M.setup()
  -- Create the New file command
  vim.api.nvim_create_user_command('New', function()
    -- Ask for a file path
    vim.ui.input({ prompt = "Enter file path: " }, function(file_path)
      if file_path then
        M.create_file_or_dir(file_path)
      else
        print("File creation cancelled.")
      end
    end)
  end, { nargs = 0 })
end

-- Function to create the file or directory
function M.create_file_or_dir(file_path)
  local dir = vim.fn.fnamemodify(file_path, ":p:h") -- Extract the directory part of the path

  -- Check if the directory exists, if not, create it
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
    print("Directory created: " .. dir)
  end

  -- Create the file if it doesn't already exist
  if vim.fn.filereadable(file_path) == 0 then
    vim.fn.execute("edit " .. file_path)
    print("File created: " .. file_path)
  else
    print("File already exists: " .. file_path)
  end
end

return M

