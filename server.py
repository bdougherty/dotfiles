#!/usr/bin/env python
import os
import tornado.web
from tornado.ioloop import IOLoop
from tornado.options import define, options
from tornado.escape import xhtml_escape

# config options
define('port', default=8080, type=int, help='port to run web server on')
define('debug', default=True, help='start app in debug mode')
options.parse_command_line(final=True)

PORT = options.port
DEBUG = options.debug

class DirectoryHandler(tornado.web.StaticFileHandler):
    def validate_absolute_path(self, root, absolute_path):
        if os.path.isdir(absolute_path):
            index = os.path.join(absolute_path, 'index.html')
            if os.path.isfile(index):
                return index

            return absolute_path

        return super(DirectoryHandler, self).validate_absolute_path(root, absolute_path)

    def get_content_type(self):
        content_types = {
            '.vtt': 'text/vtt',
            '.m3u8': 'application/vnd.apple.mpegurl',
            '.gitignore': 'text/plain'
        }

        extension = os.path.splitext(self.absolute_path)[1]
        print extension
        if extension in content_types:
            return content_types[extension]

        return super(DirectoryHandler, self).get_content_type()

    @classmethod
    def get_content(cls, abspath, start=None, end=None):
        relative_path = abspath.replace(os.getcwd(), '') + '/'
        if os.path.isdir(abspath):
            html = '<html><title>Directory listing for %s</title><body><h2>Directory listing for %s</h2><hr><ul>' % (relative_path, relative_path)
            for file in os.listdir(abspath):
                filename = file

                if os.path.isdir(file):
                    filename += '/'

                html += '<li><a href="%s">%s</a>' % (xhtml_escape(filename), xhtml_escape(filename))

            return html + '</ul><hr>'

        if os.path.splitext(abspath)[1] == '.md':
            try:
                import codecs
                import markdown
                input_file = codecs.open(abspath, mode='r', encoding='utf-8')
                text = input_file.read()
                return markdown.markdown(text)
            except:
                pass

        return super(DirectoryHandler, cls).get_content(abspath, start=start, end=end)

settings = {
    'debug': DEBUG,
    'gzip': True,
    'static_handler_class': DirectoryHandler
}

application = tornado.web.Application([
    (r'/(.*)', DirectoryHandler, {'path': './'})
], **settings)

if __name__ == "__main__":
    print("Listening on port %d..." % PORT)
    application.listen(PORT)
    IOLoop.instance().start()
