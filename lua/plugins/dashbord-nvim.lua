return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = {
    theme ='hyper',
    shortcut_type = 'number',
    change_to_vcs_root = true,
    config = {
      header = {
        [[                   YAao,                        ]],
        [[                    Y8888b,                     ]],
        [[                  ,oA8888888b,                  ]],
        [[            ,aaad8888888888888888bo,            ]],
        [[         ,d888888888888888888888888888b,        ]],
        [[       ,888888888888888888888888888888888b,     ]],
        [[      d8888888888888888888888888888888888888,   ]],
        [[     d888888888888888888888888888888888888888b  ]],
        [[    d888888P'                    `Y888888888888,]],
        [[    88888P'                    Ybaaaa8888888888l]],
        [[   a8888'                      `Y8888P' `V888888]],
        [[ d8888888a                                `Y8888]],
        [[AY/'' \Y8b                                 `Y8b ]],
        [[Y'      `YP                                  ~~ ]],
        [[         `'                                     ]],
      },
      project = { enable = false, limit = 0 },
      mru = { enable = true, limit = 9 },
      packages = { enable = true },
      footer = {
        "Made with <3",
      }
    },
  },
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
