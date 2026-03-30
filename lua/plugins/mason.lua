return {
   "mason-org/mason.nvim",
   cmd = { "Mason", "MasonUpdate" },
   opts = {
     -- Keep Mason available as a fallback without shadowing an active project venv.
     PATH = "append",
   }
}
