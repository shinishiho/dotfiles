return {
	"nvim-telescope/telescope.nvim", tag = "0.1.4",
	{ "nvim-lua/plenary.nvim" },
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		opts = {},
	},
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "mbbill/undotree" },
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { {"nvim-lua/plenary.nvim"} }
	},
	{ "ThePrimeagen/vim-be-good" },
    { "VonHeikemen/lsp-zero.nvim" },
    {'williamboman/mason.nvim', priority = 51},
    {'williamboman/mason-lspconfig.nvim'},
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
	{ "tpope/vim-fugitive" }
}
