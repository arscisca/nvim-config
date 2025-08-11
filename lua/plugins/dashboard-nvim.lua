return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = {
    theme ='hyper',
    shortcut_type = 'number',
    change_to_vcs_root = true,
    config = {
      header = {
        [[                   ▜█▆▄▂                        ]],
        [[                    ▜████▆▂                     ]],
        [[                  ▁▂▟███████▆▄▂▂                ]],
        [[           ▂▂▄▄▆██████████████████▆▄▂           ]],
        [[        ▂▆████████████████████████████▆▂        ]],
        [[       ▟█████████████████████████████████▆▂     ]],
        [[      ▐█████████████████████████████████████▂   ]],
        [[     ▐████████▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜█████████████▆  ]],
        [[    ▐██████▀                      ▀████████████▂]],
        [[    █████▀                     ▐▆▄▄▄████████████]],
        [[   ▄████▌                       ▀▜███▀  ▀▜██████]],
        [[ ▄███████▙                                 ▜████]],
        [[▆█▛▀  ▜███                                  ▜█▛ ]],
        [[█▀      ▜█▌                                  ~~ ]],
        [[         ▜▎                                     ]],
      },
      project = { enable = false, limit = 0 },
      mru = { enable = true, limit = 9, cwd_only = true},
      packages = { enable = true },
      footer = {
        "Made with <3",
      },
      shortcut = {
        {desc = 'Open file tree', key = 'e', action = function() require('neo-tree.command').execute({}) end},
      },
    },
  },
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
