#!/usr/bin/env python3
"""Send a push notification via ntfy.sh. Stdlib only — no pip dependencies."""

import argparse
import os
import sys
import urllib.request
import urllib.error


NTFY_TOPIC = os.environ.get("NTFY_TOPIC", "agent-done-k9x3mq")
NTFY_URL = f"https://ntfy.sh/{NTFY_TOPIC}"


def send(message: str, title: str = "Agent Update", priority: str = "high",
         tags: str = "white_check_mark,robot") -> None:
    data = message.encode("utf-8")
    req = urllib.request.Request(NTFY_URL, data=data, method="POST")
    req.add_header("Title", title)
    req.add_header("Priority", priority)
    req.add_header("Tags", tags)

    try:
        with urllib.request.urlopen(req, timeout=10):
            pass
    except (urllib.error.URLError, OSError):
        pass  # fail silently — never block the agent

    print(f"[ntfy] Notification sent: {message}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Send an ntfy.sh notification")
    parser.add_argument("message", nargs="*", help="Notification body text")
    parser.add_argument("--title", default="Agent Update")
    parser.add_argument("--priority", default="high",
                        choices=["min", "low", "default", "high", "urgent"])
    parser.add_argument("--tags", default="white_check_mark,robot")

    args = parser.parse_args()
    body = " ".join(args.message) if args.message else "Agent task completed."
    send(body, title=args.title, priority=args.priority, tags=args.tags)


if __name__ == "__main__":
    main()
