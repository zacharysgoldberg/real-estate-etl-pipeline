from api import create_app
import os


app = create_app()

if __name__ == "__main__":
    host = os.getenv('HOST', '0.0.0.0')
    port = os.getenv('PORT', 5000)
    app.run(threaded=True, host=host, port=port)
