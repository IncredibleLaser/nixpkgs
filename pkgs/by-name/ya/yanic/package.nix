{ lib
, buildGoModule
, fetchFromGitHub
, installShellFiles
}:

buildGoModule rec {
  pname = "yanic";
  version = "1.5.2";

  src = fetchFromGitHub {
    owner = "FreifunkBremen";
    repo = "yanic";
    rev = "v${version}";
    sha256 = "sha256-UxTlo8HkC5iTfcfTAlhSkRQo8QJhI03JDSSItuE7BCE=";
  };

  vendorHash = "sha256-D9V53/+C/+iv1U4kVrYWzJ8iD0MA1QcR8f5ifejFhLo=";

  ldflags = [ "-s" "-w" ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installShellCompletion --cmd yanic \
      --bash <($out/bin/yanic completion bash) \
      --fish <($out/bin/yanic completion fish) \
      --zsh <($out/bin/yanic completion zsh)
  '';

  meta = with lib; {
    description = "Tool to collect and aggregate respondd data";
    homepage = "https://github.com/FreifunkBremen/yanic";
    changelog = "https://github.com/FreifunkBremen/yanic/releases/tag/${src.rev}";
    license = licenses.agpl3Only;
    maintainers = with maintainers; [ herbetom ];
    mainProgram = "yanic";
  };
}
