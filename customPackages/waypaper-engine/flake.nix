{
	description = "waypaper-engine";

	outputs = {self, nixpkgs, }: {
		packages.x86_64-linux.waypaper-engine =
		let
		pkgs = import nixpkgs { system = "x86_64-linux"; };
		};
		appimageContents = appimageTools.extractType2 {
			inherit 
		in
		pkgs.appimageTools rec {
			pname = "waypaper-engine";
			version = "v2.0.3";
			buildInputs = [
				pkgs.nodejs
			];
			npmPackFlags = [ "--ignore-scripts" ];
			npmBuildFlags = [ "--log-level=verbose" ];	
			postPatch = 
				''
					npm install
				'';
			buildPhase = ''
				npm run build --log-level=verbose
			'';
			installPhase= ''
				  install -m 444 -D release/linux-unpacked/resources/icons/512x512.png $out/share/icons/hicolor/512x512/apps/waypaper-engine.png

				  install -m 444 -D release/linux-unpacked -rt $out/opt/waypaper-engine
				  install -m 744 cli/waypaper-engine $out/bin
				  install -m 444 -D waypaper-engine.desktop $out/share/applications

			'';

		};
	};
}
