""" Management class over the event lambda dictionary """
import os
from typing import Dict, Any

DEFAULT_URL = "https://httpbin.org/get"
URL = os.getenv("URL", DEFAULT_URL)

class EventManager:
    """Class to manage event data and provide utility methods."""

    def __init__(self, event: Dict[str, Any]):
        """
        Initialize the EventManager with an event dictionary.

        :param event: Dictionary containing event data.
        """
        self.event = event

    def get_test_url(self) -> str:
        """
        Get the test URL from the event data, environment variable, or default value.

        :return: The test URL.
        """
        # Order of priority: event payload, env var, and finally default value
        return self.event.get("test_url", URL)
