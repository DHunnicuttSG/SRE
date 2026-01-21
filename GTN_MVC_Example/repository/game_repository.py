
from __future__ import annotations
from typing import Optional, List
import mysql.connector
from mysql.connector import pooling
from model.game import Game
from model.round import Round
from config import Config

class GameRepository:
    def __init__(self, pool_name: str = "gtn_pool", pool_size: int = 5) -> None:
        self._pool = pooling.MySQLConnectionPool(
            pool_name=pool_name,
            pool_size=pool_size,
            host=Config.DB_HOST,
            port=Config.DB_PORT,
            user=Config.DB_USER,
            password=Config.DB_PASS,
            database=Config.DB_NAME,
        )
        self._ensure_schema()

    def _conn(self):
        return self._pool.get_connection()

    def _ensure_schema(self) -> None:
        ddl_game = """
        CREATE TABLE IF NOT EXISTS game (
            id INT AUTO_INCREMENT PRIMARY KEY,
            answer CHAR(4) NOT NULL,
            is_finished TINYINT(1) NOT NULL DEFAULT 0,
            started_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        );
        """
        ddl_round = """
        CREATE TABLE IF NOT EXISTS round (
            id INT AUTO_INCREMENT PRIMARY KEY,
            game_id INT NOT NULL,
            guess CHAR(4) NOT NULL,
            exact_match INT NOT NULL,
            partial_match INT NOT NULL,
            created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            CONSTRAINT fk_round_game FOREIGN KEY (game_id) REFERENCES game(id) ON DELETE CASCADE,
            INDEX idx_round_game_created (game_id, created_at)
        );
        """
        conn = self._conn()
        try:
            with conn.cursor() as cur:
                cur.execute(ddl_game)
                cur.execute(ddl_round)
            conn.commit()
        finally:
            conn.close()

    # --- Game CRUD ---
    def create_game(self, answer: str) -> Game:
        conn = self._conn()
        try:
            with conn.cursor(dictionary=True) as cur:
                cur.execute(
                    "INSERT INTO game (answer, is_finished) VALUES (%s, %s)",
                    (answer, 0),
                )
                conn.commit()
                new_id = cur.lastrowid
                return Game(id=new_id, answer=answer, is_finished=False)
        finally:
            conn.close()

    def get_game(self, game_id: int) -> Optional[Game]:
        conn = self._conn()
        try:
            with conn.cursor(dictionary=True) as cur:
                cur.execute(
                    "SELECT id, answer, is_finished, started_at FROM game WHERE id=%s",
                    (game_id,),
                )
                row = cur.fetchone()
                if not row:
                    return None
                return Game(
                    id=row["id"],
                    answer=row["answer"],
                    is_finished=bool(row["is_finished"]),
                    started_at=row["started_at"],
                )
        finally:
            conn.close()

    def list_games(self) -> List[Game]:
        conn = self._conn()
        try:
            with conn.cursor(dictionary=True) as cur:
                cur.execute("SELECT id, answer, is_finished, started_at FROM game ORDER BY id DESC")
                rows = cur.fetchall()
                return [
                    Game(
                        id=r["id"],
                        answer=r["answer"],
                        is_finished=bool(r["is_finished"]),
                        started_at=r["started_at"],
                    )
                    for r in rows
                ]
        finally:
            conn.close()

    def mark_finished(self, game_id: int) -> None:
        conn = self._conn()
        try:
            with conn.cursor() as cur:
                cur.execute("UPDATE game SET is_finished=1 WHERE id=%s", (game_id,))
                conn.commit()
        finally:
            conn.close()

    # --- Round operations ---
    def add_round(self, game_id: int, guess: str, exact: int, partial: int) -> Round:
        conn = self._conn()
        try:
            with conn.cursor(dictionary=True) as cur:
                cur.execute(
                    "INSERT INTO round (game_id, guess, exact_match, partial_match) VALUES (%s, %s, %s, %s)",
                    (game_id, guess, exact, partial),
                )
                conn.commit()
                rid = cur.lastrowid
                return Round(id=rid, game_id=game_id, guess=guess, exact_match=exact, partial_match=partial)
        finally:
            conn.close()

    def list_rounds(self, game_id: int) -> List[Round]:
        conn = self._conn()
        try:
            with conn.cursor(dictionary=True) as cur:
                cur.execute(
                    "SELECT id, game_id, guess, exact_match, partial_match, created_at "
                    "FROM round WHERE game_id=%s ORDER BY created_at DESC",
                    (game_id,),
                )
                rows = cur.fetchall()
                return [
                    Round(
                        id=r["id"],
                        game_id=r["game_id"],
                        guess=r["guess"],
                        exact_match=r["exact_match"],
                        partial_match=r["partial_match"],
                        created_at=r["created_at"],
                    ) for r in rows
                ]
        finally:
            conn.close()
