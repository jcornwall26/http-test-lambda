"""Main module, with the lambda handler"""

import sys
import requests
from aws_lambda_powertools import Logger
from aws_lambda_powertools.utilities.typing import LambdaContext
from util.eventmanager import EventManager
from util.contextmanager import ContextManager

logger = Logger()

@logger.inject_lambda_context
def handler(event, context: LambdaContext):
    try:
        logger.info(f"Event payload {event}")

        context_manager = ContextManager(context)
        event_manager = EventManager(event)
        response = requests.get(event_manager.get_test_url(), timeout=10)
        response.raise_for_status()

        return 'Hello from HTTP Test Lambda using Python ' \
            + sys.version \
            + ' - Context: ' + context_manager.build_formatted_context_message() \
            + ' - Response content: ' + str(response.content)
    except requests.RequestException as e:
        return f"HTTP request failed: {e}"

if __name__ == "__main__":
    handler(None, None)
