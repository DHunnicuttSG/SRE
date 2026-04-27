CREATE DATABASE IF NOT EXISTS gtn;

use gtn;

CREATE TABLE IF NOT EXISTS game (
            id INT AUTO_INCREMENT PRIMARY KEY,
            answer CHAR(4) NOT NULL,
            is_finished TINYINT(1) NOT NULL DEFAULT 0,
            started_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        );

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