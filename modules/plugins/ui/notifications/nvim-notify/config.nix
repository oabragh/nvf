{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.nvim.dag) entryAnywhere;
  inherit (lib.nvim.lua) toLuaObject;

  cfg = config.vim.notify.nvim-notify;
in {
  config = mkIf cfg.enable {
    vim = {
      startPlugins = ["nvim-notify"];

      pluginRC.nvim-notify = entryAnywhere ''
        local notify = require("notify")
        notify.setup(${toLuaObject cfg.setupOpts})
        vim.notify = notify.notify
      '';
    };
  };
}
