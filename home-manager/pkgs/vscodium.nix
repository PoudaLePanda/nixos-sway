{ pkgs, ... }:
# let
#   jonathanharty.gruvbox-material-icon-theme =
#     pkgs.vscode-utils.buildVscodeMarketplaceExtension
#       {
#         mktplcRef = {
#           name = "gruvbox-material-icon-theme";
#           publisher = "JonathanHarty";
#           version = "1.1.5";
#           hash = "sha256-86UWUuWKT6adx4hw4OJw3cSZxWZKLH4uLTO+Ssg75gY=";
#         };
#       };
# in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # nix language
        jnoortheen.nix-ide
        # nix-shell suport
        arrterian.nix-env-selector
        # python
        # ms-python.python
        # C/C++
        ms-vscode.cpptools
        # OCaml
        # ocamllabs.ocaml-platform
        # Zig
        ziglang.vscode-zig
        dbaeumer.vscode-eslint
        esbenp.prettier-vscode
        formulahendry.auto-close-tag
        kief.material-icon-theme
        # # Color theme
        # jdinhlife.gruvbox
        # # sainnhe.gruvbox-material
        # jonathanharty.gruvbox-material-icon-theme
      ];
      userSettings = {
        "[css]".editor.defaultFormatter = "esbenp.prettier-vscode";
        "[javascript]".editor.defaultFormatter = "esbenp.prettier-vscode";
        "[typescript]".editor.defaultFormatter = "esbenp.prettier-vscode";
        "[typescriptreact]".editor.defaultFormatter = "esbenp.prettier-vscode";
        editor = {
          fontFamily = "'Noto Nerd Font', 'Droid Sans Mono', 'monospace', monospace";
          fontLigatures = true;
          formatOnPaste = true;
          formatOnSave = true;
          formatOnType = true;
          minimap.enabled = false;
          renderWhitespace = "trailing";
          smoothScrolling = true;
          tabSize = 4;
          fontSize = 16;
        };
        evenBetterToml.formatter.alignComments = false;
        files = {
          associations."*.css" = "tailwindcss";
          autoSave = "onWindowChange";
          insertFinalNewline = true;
          trimFinalNewlines = true;
          trimTrailingWhitespace = true;
        };
        terminal.integrated = {
          cursorBlinking = true;
          cursorStyle = "line";
          smoothScrolling = true;
          fontFamily = "'Noto Nerd Font', 'SymbolsNerdFont'";
        };
        update.mode = "none";
        window = {
          menuBarVisibility = "toggle";
        };
        workbench = {
          colorTheme = "One Dark Pro Darker";
          iconTheme = "material-icon-theme";
          list.smoothScrolling = true;
          startupEditor = "none";
          tips.enabled = false;
        };
        "extensions.autoUpdate" = false;
        "window.titleBarStyle" = "custom";

        # "workbench.colorTheme" = "Gruvbox Dark Hard";
        # "workbench.iconTheme" = "gruvbox-material-icon-theme";
        #
        "material-icon-theme.folders.theme" = "classic";
        "vsicons.dontShowNewVersionMessage" = true;
        "explorer.confirmDragAndDrop" = false;

        "explorer.openEditors.visible" = 0;
        "breadcrumbs.enabled" = false;
        "editor.renderControlCharacters" = false;
        "editor.scrollbar.verticalScrollbarSize" = 2;
        "editor.scrollbar.horizontalScrollbarSize" = 2;
        "editor.scrollbar.vertical" = "hidden";
        "editor.scrollbar.horizontal" = "hidden";

        "editor.mouseWheelZoom" = true;

        "C_Cpp.autocompleteAddParentheses" = true;
        "C_Cpp.formatting" = "clangFormat";
        "C_Cpp.vcFormat.newLine.closeBraceSameLine.emptyFunction" = true;
        "C_Cpp.vcFormat.newLine.closeBraceSameLine.emptyType" = true;
        "C_Cpp.vcFormat.space.beforeEmptySquareBrackets" = true;
        "C_Cpp.vcFormat.newLine.beforeOpenBrace.block" = "sameLine";
        "C_Cpp.vcFormat.newLine.beforeOpenBrace.function" = "sameLine";
        "C_Cpp.vcFormat.newLine.beforeElse" = false;
        "C_Cpp.vcFormat.newLine.beforeCatch" = false;
        "C_Cpp.vcFormat.newLine.beforeOpenBrace.type" = "sameLine";
        "C_Cpp.vcFormat.space.betweenEmptyBraces" = true;
        "C_Cpp.vcFormat.space.betweenEmptyLambdaBrackets" = true;
        "C_Cpp.vcFormat.indent.caseLabels" = true;
        "C_Cpp.intelliSenseCacheSize" = 2048;
        "C_Cpp.intelliSenseMemoryLimit" = 2048;
        "C_Cpp.default.browse.path" = [ ''''${workspaceFolder}/**'' ];
        "C_Cpp.default.cStandard" = "gnu11";
        "C_Cpp.inlayHints.parameterNames.hideLeadingUnderscores" = false;
        "C_Cpp.intelliSenseUpdateDelay" = 500;
        "C_Cpp.workspaceParsingPriority" = "medium";
        "C_Cpp.clang_format_sortIncludes" = true;
        "C_Cpp.doxygen.generatedStyle" = "/**";

        "nix.serverPath" = "nixd";
        "nix.enableLanguageServer" = true;
        # "nix.serverSettings" = {
        #   "nixd" = {
        #     "formatting" = {
        #       "command" = [ "nixfmt" ];
        #     };
        #   };
        # };
      };
      # Keybindings
      keybindings = [
        {
          key = "ctrl+q";
          command = "editor.action.commentLine";
          when = "editorTextFocus && !editorReadonly";
        }
        {
          key = "ctrl+s";
          command = "workbench.action.files.saveFiles";
        }
      ];
    };
  };
}
