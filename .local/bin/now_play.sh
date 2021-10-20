#!/usr/bin/env sh

PLAYER="ncspot"

pgrep "$PLAYER" >/dev/null || exit 0

get_player_status() {
	case "$(playerctl -p "$PLAYER" status || true)" in
		Playing) printf "⏵" ;;
		Paused)  printf "⏸" ;;
		*)
			# Something went wrong
			true
	esac
}

printf " %s %s - %s" \
	"$(get_player_status)" \
	"$(playerctl -p "$PLAYER" metadata artist)" \
	"$(playerctl -p "$PLAYER" metadata title)"

# or
# playerctl -p ncspot metadata --format '{{emoji(status)}} {{artist}} - {{title}}'
