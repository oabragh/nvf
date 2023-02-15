{inputs, ...}: {
  perSystem = {
    system,
    config,
    pkgs,
    lib,
    ...
  }: {
    packages = let
      docs = import ../docs {
        inherit pkgs;
        nmdSrc = inputs.nmd;
      };
    in
      {
        # Documentation
        docs = docs.manual.html;
        docs-html = docs.manual.html;
        docs-manpages = docs.manPages;
        docs-json = docs.options.json;

        # nvim configs
        nix = config.legacyPackages.neovim-nix;
        maximal = config.legacyPackages.neovim-maximal;
      }
      // (
        if !(builtins.elem system ["aarch64-darwin" "x86_64-darwin"])
        then {tidal = config.legacyPackages.neovim-tidal;}
        else {}
      );
  };
}
