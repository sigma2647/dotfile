{
  description = "A cross-platform Nix-based development environment for Python 3.12 projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        python = pkgs.python312;
        pythonPackages = python.pkgs;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pythonPackages; [
            numpy
            pandas
            requests
            #streamlit
            # 在此处添加其他所需的 Python 包
          ];
          shellHook = ''
            echo "Welcome to the Python 3.12 development environment on ${system}!"
            if [ ! -d ".venv" ]; then
              echo "Creating virtual environment in .venv directory..."
              python3 -m venv .venv
            fi
            source .venv/bin/activate
            echo "Virtual environment activated."
          '';
        };
      });
}

