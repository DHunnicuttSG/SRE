
from flask import Flask
from config import Config
from controller.game_controller import bp as game_bp

def create_app() -> Flask:
    app = Flask(__name__)
    app.config.from_object(Config)
    app.json.sort_keys = False  # preserve insertion order in responses
    app.register_blueprint(game_bp)
    return app

if __name__ == "__main__":
    app = create_app()
    app.run(debug=True)
