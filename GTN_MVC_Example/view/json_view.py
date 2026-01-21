from model.game import Game
from model.round import Round

def game_to_dict(g: Game) -> dict:
    # Keep your original response key style (camelCase)
    return {
        "gameId": g.id,
        "answer": g.answer,
        "isFinished": g.is_finished,
        "startedAt": g.started_at.isoformat() if g.started_at else None,
    }

def round_to_dict(r: Round) -> dict:
    return {
        "roundId": r.id,
        "gameId": r.game_id,
        "guess": r.guess,
        "exactMatch": r.exact_match,
        "partialMatch": r.partial_match,
        "createdAt": r.created_at.isoformat() if r.created_at else None,
    }

def games_to_list(rows: list[Game]) -> list[dict]:
    return [game_to_dict(g) for g in rows]

def rounds_to_list(rows: list[Round]) -> list[dict]:
    return [round_to_dict(r) for r in rows]
