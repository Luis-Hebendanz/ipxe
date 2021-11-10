    {
        description = "my project description";
        nixConfig.bash-prompt = "\[nix-develop\]$ ";
        inputs.flake-utils.url = "github:numtide/flake-utils";
        # My fork of nixpkgs with custom packages
        inputs.luispkgs.url = "github:Luis-Hebendanz/nixpkgs/luispkgs";

        outputs = { self, nixpkgs, flake-utils, luispkgs }:
        flake-utils.lib.eachDefaultSystem
        (system:
        let 
            pkgs = import nixpkgs {
		          inherit system;
		          config = { allowUnfree = true; };
	          };

            luis = import luispkgs {
		          inherit system;
		          config = { allowUnfree = true; };
	          };
        in
            {
                devShell = import ./shell.nix { inherit pkgs; inherit luis; };
            }
        );
    }
