-- 1. 데이터베이스 생성 및 선택
CREATE DATABASE IF NOT EXISTS movie_db;
USE movie_db;

-- 2. 장르 테이블 (부모 테이블 1)
CREATE TABLE genres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE       -- UNIQUE 제약조건 적용
);

-- 3. 사용자 테이블 (부모 테이블 2)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,    -- UNIQUE 및 NOT NULL 제약조건 적용
    name VARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 4. 영화 테이블 (genres 테이블을 참조하는 자식 테이블 / 1:N 관계)
CREATE TABLE movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    genre_id INT NOT NULL,
    release_date DATE NOT NULL,
    duration INT NOT NULL,                 -- 상영 시간 (분 단위)
    FOREIGN KEY (genre_id) REFERENCES genres(id) -- FK 제약조건 설정
);

-- 5. 리뷰 테이블 (movies와 users를 참조하는 자식 테이블 / 1:N 관계 2개 포함)
CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL,                   -- 평점 (1~5점)
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE, -- FK 제약조건
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE    -- FK 제약조건
);