{
	description = "waypaper-engine";
	inputs.waypaper-engine = {
			flake=false;
			type = "git";
			url = "https://github.com/0bCdian/Waypaper-Engine";
			rev = "a8f3a7e401ae211a27d014a7e8aeb06673036cfd";
		};

	outputs = {self, nixpkgs, waypaper-engine }: {
		packages.x86_64-linux.waypaper-engine =
		let
		pkgs = import nixpkgs { system = "x86_64-linux"; };
		in
		pkgs.stdenv.mkDerivation {
			name = "waypaper-engine";

			src = waypaper-engine;

			buildInputs = [pkgs.nodejs];
			buildPhase = ''
				  npm run build
				  install -m 444 -D release/linux-unpacked/resources/icons/512x512.png $out/share/icons/hicolor/512x512/apps/waypaper-engine.png

				  install -m 444 -D release/linux-unpacked -rt $out/opt/waypaper-engine
				  install -m 744 cli/waypaper-engine $out/bin
				  install -m 444 -D waypaper-engine.desktop $out/share/applications

			'';

		};
	};
}
