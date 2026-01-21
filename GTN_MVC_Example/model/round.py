from dataclasses import dataclass
from datetime import datetime

@dataclass
class Round:
    id: int
    game_id: int
    guess: str
    exact_match: int
    partial_match: int
    created_at: datetime | None = None
