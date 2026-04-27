from dataclasses import dataclass
from datetime import datetime

@dataclass
class Game:
    id: int
    answer: str
    is_finished: bool
    started_at: datetime | None = None
