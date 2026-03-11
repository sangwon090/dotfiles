{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Sangwon Ryu";
      user.email = "me@sryu.dev";
      init.defaultBranch = "main";
    };
  };

  imports = [
    ./shell
  ];
}
