{
  description = "";

  outputs = {self}: {
    templates = {
      go = {
        description = "";
        path = ./golang;
      };
      basic = {
        description = "";
        path = ./basic;
      };
    };
  };
}
