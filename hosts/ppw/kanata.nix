{ ... }: {
  services.kanata = {
    enable = true;
    keyboards = {
      laptop = {
        # if you want to ignore other keyboards (from other laptops) you can set them here. kanata will ignore any kbd's not found. Nice.
        devices = [ "/dev/input/by-id/usb-Framework_Laptop_16_Keyboard_Module_-_ANSI_FRAKDKEN0100000000-event-kbd"];
        configFile = ./kanata.kbd;
    	};
	  };
  };
}
