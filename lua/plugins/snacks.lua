---@type LazySpec
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      layout = {
        preset = "ivy",
        layout = {
          backdrop = 60,
        },
      },
    },

    image = {},

    gh = {},

    scratch = {},
    dashboard = {
      config = function()
        local f = function(args)
          vim.b[args.buf].minianimate_disable = true
        end
        vim.api.nvim_create_autocmd(
          "User",
          { pattern = "SnacksDashboardOpened", callback = f }
        )
      end,
      preset = {
        header = table.concat({
          " ██████╗ ███████╗██╗   ██╗██╗     ██╗██╗  ██╗",
          " ██╔══██╗██╔════╝╚██╗ ██╔╝██║     ██║╚██╗██╔╝",
          " ██████╔╝█████╗   ╚████╔╝ ██║     ██║ ╚███╔╝ ",
          " ██╔═══╝ ██╔══╝    ╚██╔╝  ██║     ██║ ██╔██╗ ",
          " ██║     ███████╗   ██║   ███████╗██║██╔╝ ██╗",
          " ╚═╝     ╚══════╝   ╚═╝   ╚══════╝╚═╝╚═╝  ╚═╝",
          "                                             ",
          " ███╗   ██╗██╗   ██╗██╗███╗   ███╗           ",
          " ████╗  ██║██║   ██║██║████╗ ████║           ",
          " ██╔██╗ ██║██║   ██║██║██╔████╔██║           ",
          " ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║           ",
          " ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║           ",
          " ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝           ",
        }, "\n"),
      },
      -- sections = {
      --   { section = "header" },
      --   { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
      --   { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      --   { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      --   { section = "startup" },
      -- },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 2 },
        {
          icon = " ",
          title = "Recent Files",
          section = "recent_files",
          indent = 2,
          padding = 2,
        },
        {
          icon = " ",
          title = "Projects",
          section = "projects",
          indent = 2,
          padding = 2,
        },
        { section = "startup" },
      },
    },
    styles = {
      blame_line = {
        width = 0.6,
        height = 0.6,
        border = "rounded",
        title = " Git Blame ",
        title_pos = "center",
        ft = "git",
      },
    },
  },
  keys = {
    {
      "<leader>bt",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>bT",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },

    {
      "<leader>bS",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    {
      "<leader>gi",
      function()
        Snacks.picker.gh_issue()
      end,
      desc = "GitHub Issues (open)",
    },
    {
      "<leader>gI",
      function()
        Snacks.picker.gh_issue({ state = "all" })
      end,
      desc = "GitHub Issues (all)",
    },
    {
      "<leader>gq",
      function()
        Snacks.picker.gh_pr()
      end,
      desc = "GitHub Pull Requests (open)",
    },
    {
      "<leader>gQ",
      function()
        Snacks.picker.gh_pr({ state = "all" })
      end,
      desc = "GitHub Pull Requests (all)",
    },
  },
}
