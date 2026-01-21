
from __future__ import annotations
from typing import List, Tuple, Optional
import random
from repository.game_repository import GameRepository
from model.game import Game
from model.round import Round

class GameService:
    def __init__(self, repo: GameRepository | None = None) -> None:
        self.repo = repo or GameRepository()

    # ---- Rules / Helpers ----
    def _generate_answer(self) -> str:
        # 4 distinct digits (0-9), no repeats
        digits = [str(d) for d in range(10)]
        random.shuffle(digits)
        return "".join(digits[:4])

    def _validate_guess(self, guess: str) -> None:
        if not guess or len(guess) != 4 or not guess.isdigit():
            raise ValueError("Guess must be a 4-digit number.")
        if len(set(guess)) != 4:
            raise ValueError("Digits must be unique (no repeats).")

    def _calculate_matches(self, secret: str, guess: str) -> Tuple[int, int]:
        exact = sum(1 for i in range(4) if guess[i] == secret[i])
        partial = sum(1 for ch in guess if ch in secret) - exact
        return exact, partial

    def _mask_answer_if_needed(self, game: Game) -> Game:
        if not game.is_finished:
            return Game(id=game.id, answer="****", is_finished=game.is_finished, started_at=game.started_at)
        return game

    # ---- Use cases ----
    def start_game(self) -> Game:
        answer = self._generate_answer()
        return self.repo.create_game(answer)

    def get_game(self, game_id: int) -> Optional[Game]:
        game = self.repo.get_game(game_id)
        return self._mask_answer_if_needed(game) if game else None

    def list_games(self) -> List[Game]:
        games = self.repo.list_games()
        return [self._mask_answer_if_needed(g) for g in games]

    def list_rounds(self, game_id: int) -> List[Round]:
        return self.repo.list_rounds(game_id)

    def make_guess(self, game_id: int, guess: str) -> dict:
        # Fetch actual game first (unmasked)
        game = self.repo.get_game(game_id)
        if not game:
            raise LookupError("Game not found.")

        self._validate_guess(guess)
        exact, partial = self._calculate_matches(game.answer, guess)

        # Record the round
        _ = self.repo.add_round(game_id, guess, exact, partial)

        # If win condition
        if exact == 4:
            self.repo.mark_finished(game_id)
            status = "WIN"
        else:
            status = "CONTINUE"

        # Return updated game (masked if needed) and all rounds
        masked = self.get_game(game_id)
        rounds = self.list_rounds(game_id)
        return {
            "status": status,
            "game": masked,
            "rounds": rounds,
            "result": {"exactMatch": exact, "partialMatch": partial},
        }
