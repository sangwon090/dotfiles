local data = vim.fn.stdpath("data")
local plugin_root = data .. "/lazy"
local function bootstrap(name, repo, revision)
  local path = plugin_root .. "/" .. name
  if vim.uv.fs_stat(path) then
    return
  end
  vim.fn.mkdir(plugin_root, "p")
  local staging = assert(vim.uv.fs_mkdtemp(data .. "/." .. name .. ".XXXXXX"))
  local result = vim.system({
    "@git@", "clone", "--filter=blob:none", "--no-checkout", repo, staging,
  }, { text = true }):wait()
  if result.code == 0 then
    result = vim.system({
      "@git@", "-C", staging, "checkout", "--detach", revision,
    }, { text = true }):wait()
  end
  if result.code ~= 0 then
    vim.fn.delete(staging, "rf")
    error("Failed to install " .. name .. ":\n" .. result.stderr)
  end
  local installed, err = vim.uv.fs_rename(staging, path)
  if not installed then
    vim.fn.delete(staging, "rf")
    if not vim.uv.fs_stat(path) then
      error(err)
    end
  end
end

bootstrap("lazy.nvim", "https://github.com/folke/lazy.nvim.git", "@lazyNvimRevision@")
-- Load the full plugin spec before lazy.nvim rewrites its lockfile.
bootstrap("LazyVim", "https://github.com/LazyVim/LazyVim.git", "@lazyVimRevision@")
vim.opt.rtp:prepend(plugin_root .. "/lazy.nvim")

require("lazy").setup({
  spec = { { "LazyVim/LazyVim", import = "lazyvim.plugins" } },
  defaults = { lazy = false, version = false },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})
