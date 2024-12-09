local M = {}

function M.setup_venv()
  -- Create and activate a virtual environment
  local venv_path = ".venv"
  local cmd = string.format("python3 -m venv %s && source %s/bin/activate", venv_path, venv_path)

  -- Run the command in the terminal
  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          print(line)
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, line in ipairs(data) do
          print("Error: " .. line)
        end
      end
    end,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        print("Virtual environment setup completed and activated.")
      else
        print("Failed to set up virtual environment.")
      end
    end,
  })
end

return M
