"""Build nicely formatted diagnostic message."""
from aws_lambda_powertools.utilities.typing import LambdaContext

class ContextManager:
    """Class to manage AWS Lambda context and provide utility methods."""

    def __init__(self, context: LambdaContext):
        """
        Initialize the ContextManager with a Lambda context.

        :param context: AWS Lambda context object.
        """
        self.context = context

    def build_formatted_context_message(self) -> str:
        """
        Build a nicely formatted diagnostic message using the Lambda context.

        :return: Formatted context message.
        """
        return f"{self.context.function_name} {self.context.aws_request_id}"
