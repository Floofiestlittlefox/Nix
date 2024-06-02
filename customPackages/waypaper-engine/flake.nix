{
	description = "waypaper-engine";
	inputs.waypaper-engine = {
			type = "git";
			url = "https://github.com/0bCdian/Waypaper-Engine";
			rev = "a8f3a7e401ae211a27d014a7e8aeb06673036cfd";
		};

	outputs = {self, nixpkgs, fetchFromGithub, waypaper-engine}:
		stdenv.mkDerivation {
		name = "waypaper-engine";

		src = inputs.waypaper-engine

		buildInputs = [pkgs.nodejs];
		buildPhase = ''
		'';

	}
}
