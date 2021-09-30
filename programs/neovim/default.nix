{ pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
  cmp-buffer = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-buffer";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-buffer";
      rev = "5dde5430757696be4169ad409210cf5088554ed6";
      sha256 = "0fdywbv4b0z1kjnkx9vxzvc4cvjyp9mnyv4xi14zndwjgf1gmcwl";
    };
  };
  cmp-nvim-lsp = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-nvim-lsp";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp";
      rev = "f6f471898bc4b45eacd36eef9887847b73130e0e";
      sha256 = "1asr32w5q618pqggq9jwrbqs4kjp3ssbw5pca5wc7j2496vm2lhg";
    };
  };
  cmp-path = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-path";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-path";
      rev = "0016221b6143fd6bf308667c249e9dbdee835ae2";
      sha256 = "03k43xavw17bbjzmkknp9z4m8jv9hn6wyvjwaj1gpyz0n21kn5bb";
    };
  };
  crates-nvim = assert !(pkgs ? crates-nvim); pkgs.vimUtils.buildVimPlugin {
    name = "crates.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Saecki";
      repo = "crates.nvim";
      rev = "d15c2f28d10ed5f299933e812598a1206e4fc4ef";
      sha256 = "1y3qisxd85yfqrn9jdb4g1pf97p62lyp6253g9p127zcdkb3w4g0";
    };
  };
  nvim-cmp = pkgs.vimUtils.buildVimPluginFrom2Nix { # this just avoids running the makefile
    name = "nvim-cmp";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "nvim-cmp";
      rev = "620eea94d3259d744a8a2341fcae0f7bc966300a";
      sha256 = "0p63ia3x0f8dj1lzwip51jiz49s451mxcpjaicfbrlj41fc9cz3v";
    };
  };
  nvim-lint = assert !(pkgs ? nvim-lint); pkgs.vimUtils.buildVimPlugin {
    name = "nvim-lint";
    src = pkgs.fetchFromGitHub {
      owner = "mfussenegger";
      repo = "nvim-lint";
      rev = "cd3cef2fbdba36768736a3f927cfcab9873e8b85";
      sha256 = "15w4bdqzz62cq56idwf0y191avk6zp8c09lhq3dm1w4v15rqsxqs";
    };
  };
  rust-tools-nvim = assert builtins.compareVersions pkgs.vimPlugins.rust-tools-nvim.version "2021-09-16" == -1; pkgs.vimUtils.buildVimPlugin { # https://github.com/simrat39/rust-tools.nvim/issues/61
    name = "rust-tools-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "simrat39";
      repo = "rust-tools.nvim";
      rev = "83bf0cabe040a6e02b59296622c838831a2b5c4f";
      sha256 = "0d2gl768rgd5l1wh9sq2z24rdmg5g27ib6fjfdcvxdlc2s5g333l";
    };
  };
  vim-angry = pkgs.vimUtils.buildVimPlugin {
    name = "vim-angry";
    src = pkgs.fetchFromGitHub {
      owner = "b4winckler";
      repo = "vim-angry";
      rev = "08e9e9a50e6683ac7b0c1d6fddfb5f1235c75700";
      sha256 = "0cxfvzlka0pgqs2ij4vwfv97yqks2ncnzk86a5psv985i8qmba30";
    };
  };
  vim-buffet = pkgs.vimUtils.buildVimPlugin {
    name = "vim-buffet";
    src = pkgs.fetchFromGitHub {
      owner = "bagrat";
      repo = "vim-buffet";
      rev = "d4f90cc5b9ef613e6464990f204006d74f89978a";
      sha256 = "183yb722qh3pvsb3n7vvzqpw7jlv2kcixz34qn3k4bsqj41g8y5y";
    };
  };
  vim-crystalline = pkgs.vimUtils.buildVimPlugin {
    name = "vim-crystalline";
    src = pkgs.fetchFromGitHub {
      owner = "rbong";
      repo = "vim-crystalline";
      rev = "32698e3560ddb68bbb648fcfb677e9af45f70a79";
      sha256 = "0sssm39rlixd3hfqwa0x9y25jbdihdm9frmwrrfpvidipplafy0q";
    };
  };
  vim-one = pkgs.vimUtils.buildVimPlugin {
    name = "vim-one";
    src = pkgs.fetchFromGitHub {
      owner = "reedes";
      repo = "vim-one";
      rev = "366e33b1eb317b2ce2292e2869b31a7c1516c753";
      sha256 = "0kw63xc48cb4q291bmybmklybvr0hlfzdq010cr2xsi7xpqmg2z2";
    };
  };
  vim-pythonsense = pkgs.vimUtils.buildVimPlugin {
    name = "vim-pythonsense";
    src = pkgs.fetchFromGitHub {
      owner = "jeetsukumaran";
      repo = "vim-pythonsense";
      rev = "9200a57629c904ed2ab8c9b2e8c5649d311794ba";
      sha256 = "1m2qz3j05f3y99wjjcnkhbpj8j3hdsnwjc33skzldv5khspg011d";
    };
  };
  vim-textobj-entire = pkgs.vimUtils.buildVimPlugin {
    name = "vim-textobj-entire";
    src = pkgs.fetchFromGitHub {
      owner = "kana";
      repo = "vim-textobj-entire";
      rev = "64a856c9dff3425ed8a863b9ec0a21dbaee6fb3a";
      sha256 = "0kv0s85wbcxn9hrvml4hdzbpf49b1wwr3nk6gsz3p5rvfs6fbvmm";
    };
  };
  vim-textobj-line = pkgs.vimUtils.buildVimPlugin {
    name = "vim-textobj-line";
    src = pkgs.fetchFromGitHub {
      owner = "kana";
      repo = "vim-textobj-line";
      rev = "0a78169a33c7ea7718b9fa0fad63c11c04727291";
      sha256 = "0mppgcmb83wpvn33vadk0wq6w6pg9cq37818d1alk6ka0fdj7ack";
    };
  };
in
{
  home.sessionVariables.EDITOR = "nvim";
  xdg.configFile."nvim/after/syntax/nix.vim".text = ''
    syntax match nixFunctionCall /\v((lib|pkgs|builtins)\.)+/ conceal cchar=.
  '';
  programs.neovim = {
    enable = true;
    package = assert builtins.compareVersions pkgs.neovim-unwrapped.version "0.5" == -1; unstable.neovim-unwrapped; # need neovim 0.5 for LSP support
    extraConfig = builtins.readFile ./init.vim;
    plugins = with pkgs.vimPlugins; [
      # Tim Pope
      vim-commentary
      vim-eunuch
      vim-fugitive
      vim-repeat
      vim-scriptease
      vim-sensible
      vim-speeddating
      vim-surround
      # Appearance
      {
        plugin = gruvbox-community;
        config = ''
          set termguicolors
          let g:gruvbox_italic = 1
          let g:gruvbox_undercurl = 0
          let g:gruvbox_guisp_fallback = 'bg'
          let g:gruvbox_contrast_light = 'hard'
          colorscheme gruvbox
        '';
      }
      {
        plugin = vim-buffet;
        config = ''
          " Set up custom colours for vim-buffet.
          function! s:gruvbox(x)
            return synIDattr(hlID(a:x), 'fg')
          endfunction
          function! g:BuffetSetCustomColors()
            exec 'hi! BuffetCurrentBuffer guifg='.s:gruvbox('GruvboxBg0').' guibg='.s:gruvbox('GruvboxFg4')
            exec 'hi! BuffetActiveBuffer guifg='.s:gruvbox('GruvboxFg4').' guibg='.s:gruvbox('GruvboxBg2')
            exec 'hi! BuffetBuffer guifg='.s:gruvbox('GruvboxFg4').' guibg='.s:gruvbox('GruvboxBg2')
            hi! link BuffetModCurrentBuffer BuffetCurrentBuffer
            hi! link BuffetModActiveBuffer BuffetActiveBuffer
            hi! link BuffetModBuffer BuffetBuffer
            exec 'hi! BuffetTrunc guifg='.s:gruvbox('GruvboxBg4').' guibg='.s:gruvbox('GruvboxBg1')
            exec 'hi! BuffetTab guifg='.s:gruvbox('GruvboxBg2').' guibg='.s:gruvbox('GruvboxBlue')
          endfunction
        '';
      }
      {
        plugin = vim-crystalline;
        config = ''
          function! StatusLine(current, width)
            let l:s = ""
            if a:current
              let l:s .= crystalline#mode() . crystalline#right_mode_sep("")
            else
              let l:s .= '%#CrystallineInactive#'
            endif
            let l:s .= ' %f%h%w%m%r '
            if a:current
              let l:s .= crystalline#right_sep("", 'Fill') . ' %{fugitive#head()}'
            endif
            let l:s .= '%='
            if a:current
              let l:s .= crystalline#left_sep("", 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
              let l:s .= crystalline#left_mode_sep("")
            endif
            if a:width > 80
              let l:s .= ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
            else
              let l:s .= ' '
            endif
            return l:s
          endfunction
          function! TabLine()
            let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
            return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
          endfunction
          let g:crystalline_enable_sep = 1
          let g:crystalline_statusline_fn = 'StatusLine'
          let g:crystalline_tabline_fn = 'TabLine'
          let g:crystalline_theme = 'gruvbox'
          set showtabline=2
          set guioptions-=e
          set laststatus=2
          set noshowmode
        '';
      }
      {
        plugin = vim-polyglot;
        config = ''
          " Enable LaTeX math support in Markdown.
          let g:vim_markdown_math = 1
          " Highlight YAML and TOML frontmatter.
          let g:vim_markdown_frontmatter = 1
          let g:vim_markdown_toml_frontmatter = 1
          " Don't automatically insert bulletpoints (it doesn't always behave properly).
          let g:vim_markdown_auto_insert_bullets = 0
          let g:vim_markdown_new_list_item_indent = 0
          " Disable automatic folding.
          let g:vim_markdown_folding_disabled = 1
          " Don't conceal code blocks.
          let g:vim_markdown_conceal_code_blocks = 0
          " Render strikethrough as strikethrough.
          let g:vim_markdown_strikethrough = 1
        '';
      }
      # Text objects
      vim-angry
      {
        plugin = vim-pythonsense;
        config = ''
          " Disable the vim-pythonsense keymaps, so we can enable just the docstring text object.
          let g:is_pythonsense_suppress_keymaps = 1
        '';
      }
      vim-textobj-comment
      vim-textobj-entire
      vim-textobj-line
      vim-textobj-user
      # Keybinds
      conflict-marker-vim
      {
        plugin = ctrlp;
        config = ''
          " Make CtrlP ignore files that Git ignores, when in a Git repository.
          let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
          " When not in a Git repository, don't show uninteresting stuff.
          let g:ctrlp_custom_ignore = '\v\.(aux|fdb_latexmk|fls|mypy_cache)$'
          " Do show hidden files (when ctrlp_user_command doesn't apply).
          let g:ctrlp_show_hidden = 1
        '';
      }
      {
        plugin = splitjoin-vim;
        config = ''
          let g:splitjoin_trailing_comma = 1
          let g:splitjoin_python_brackets_on_separate_lines = 1
        '';
      }
      vim-table-mode
      # Behaviour
      editorconfig-vim
      {
        plugin = pear-tree;
        config = ''
          " Stop pear-tree unpredictably erasing brackets, we don't care about repeating that much.
          let g:pear_tree_repeatable_expand = 0
          " Do be clever about maintaining balance.
          let g:pear_tree_smart_openers = 1
          let g:pear_tree_smart_closers = 1
          let g:pear_tree_smart_backspace = 1
        '';
      }
      {
        plugin = vim-gitgutter;
        config = ''
          " Disable the vim-gitgutter keymaps, we will enable the interesting ones ourselves.
          let g:gitgutter_map_keys = 0
          " Slimmed-down and modified mappings from vim-gitgutter.
          nmap ]h <plug>(GitGutterNextHunk)
          nmap [h <plug>(GitGutterPrevHunk)
          nmap <leader>hs <plug>(GitGutterStageHunk)
          nmap <leader>hu <plug>(GitGutterUndoHunk)
          omap ih <Plug>(GitGutterTextObjectInnerPending)
          omap ah <Plug>(GitGutterTextObjectOuterPending)
          xmap ih <Plug>(GitGutterTextObjectInnerVisual)
          xmap ah <Plug>(GitGutterTextObjectOuterVisual)
        '';
      }
      vim-one
      {
        plugin = vim-rooter;
        config = ''
          " Stop vim-rooter echoing the working directory it's changing to.
          let g:rooter_silent_chdir = 1
        '';
      }
      # LSP support
      {
        # using unstable.vimPlugins.nvim-lspconfig silently fails
        # https://github.com/NixOS/nixpkgs/pull/136429
        # https://github.com/NixOS/nixpkgs/issues/138084
        plugin = nvim-lspconfig;
        config = ''
          lua <<EOF
          require'lspconfig'.rnix.setup{}
          EOF
        '';
      }
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      {
        plugin = crates-nvim;
        config = ''
          lua require'crates'.setup{popup={autofocus=true}}
        '';
      }
      nvim-cmp
      plenary-nvim
      rust-tools-nvim
      # Linting
      {
        plugin = nvim-lint;
        config = ''
          lua <<EOF
          require'lint'.linters_by_ft = {
            sh = {'shellcheck',},
            bash = {'shellcheck',},
          }
          EOF
          au BufWritePost,CursorHold,CursorHoldI <buffer> lua require'lint'.try_lint()
        '';
      }
    ];
    extraPackages = with pkgs; [
      shellcheck
    ];
  };
  home.packages = with pkgs; [
    rnix-lsp
    (assert builtins.compareVersions rust-analyzer.version "2021-07-19" == -1; unstable.rust-analyzer) # https://github.com/rust-analyzer/rust-analyzer/issues/8925
  ];
}
