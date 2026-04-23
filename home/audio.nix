# home/audio.nix
{ pkgs, ... }:
let
  combineSinks = pkgs.writeShellApplication {
    name = "combine-sinks";
    runtimeInputs = [ pkgs.pulseaudio ];  # provides `pactl`
    text = ''
      set -euo pipefail

      SINK_NAME="combined_sink"

      # Already loaded? Toggle off.
      EXISTING=$(pactl list short modules \
        | awk -v name="sink_name=$SINK_NAME" \
            '$2 == "module-combine-sink" && $0 ~ name { print $1 }')

      if [ -n "$EXISTING" ]; then
        echo "Unloading combined sink (module $EXISTING)"
        pactl unload-module "$EXISTING"
        exit 0
      fi

      # Find real sinks to combine
      SINKS=$(pactl list short sinks)
      BT=$(printf  '%s\n' "$SINKS" | awk '/bluez_output/          { print $2; exit }')
      AUX=$(printf '%s\n' "$SINKS" | awk '/Audio_Expansion_Card/  { print $2; exit }')

      SLAVES=""
      [ -n "$BT" ]  && SLAVES="$BT"
      [ -n "$AUX" ] && SLAVES="''${SLAVES:+$SLAVES,}$AUX"

      if [ -z "$SLAVES" ]; then
        echo "No matching sinks (need BT connected and/or Audio Expansion Card present)" >&2
        exit 1
      fi

      echo "Creating combined sink with slaves: $SLAVES"
      pactl load-module module-combine-sink \
        sink_name="$SINK_NAME" \
        sink_properties="device.description='Combined BT + Aux'" \
        slaves="$SLAVES"
    '';
  };
in
{
  home.packages = [
    combineSinks
    pkgs.pavucontrol
  ];
}
