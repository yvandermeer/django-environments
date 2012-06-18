from os import path
import logging

from .generic import PROJECT_ROOT, PROJECT


LOGGING_FILENAME = path.join(PROJECT_ROOT, 'log/%s.log' % PROJECT)

logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(name)-30s - %(levelname)-8s: %(message)s',
    #format='%(name)s: %(message)s',
    #datefmt='%a, %d %b %Y %H:%M:%S',
    filename=LOGGING_FILENAME,
)
