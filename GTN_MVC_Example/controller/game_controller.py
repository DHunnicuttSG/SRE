
from flask import Blueprint, request, jsonify
from service.game_service import GameService
from view.json_view import game_to_dict, games_to_list, rounds_to_list

bp = Blueprint("game", __name__)
svc = GameService()

@bp.post("/start")
def start_game():
    game = svc.start_game()
    # Return new gameId as JSON (201 Created)
    return jsonify({"message": "Game started", "gameId": game.id}), 201

@bp.get("/game/<int:gameId>")
def get_game(gameId: int):
    game = svc.get_game(gameId)
    if not game:
        return jsonify({"error": "Not found"}), 404
    return jsonify(game_to_dict(game)), 200

@bp.get("/games")
def list_games():
    games = svc.list_games()
    return jsonify(games_to_list(games)), 200

@bp.get("/rounds/<int:gameId>")
def list_rounds(gameId: int):
    rounds = svc.list_rounds(gameId)
    return jsonify(rounds_to_list(rounds)), 200

@bp.post("/<int:gameId>/<guess>")
def make_guess(gameId: int, guess: str):
    try:
        result = svc.make_guess(gameId, guess)
        # Serialize nested objects
        payload = {
            "status": result["status"],
            "game": game_to_dict(result["game"]),
            "rounds": rounds_to_list(result["rounds"]),
            "result": result["result"],
        }
        return jsonify(payload), 200
    except LookupError:
        return jsonify({"error": "Game not found"}), 404
    except ValueError as ve:
        return jsonify({"error": str(ve)}), 400
