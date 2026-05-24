USE movie_db;
-- 쿼리 1: 상영 시간이 130분 이상인 영화 목록 조회 (WHERE 활용)
SELECT id, title, duration FROM movies WHERE duration >= 130;

-- 쿼리 2: 회원 가입일이 가장 최근인 순서대로 사용자 정렬 조회 (ORDER BY 활용)
SELECT id, email, name, created_at FROM users ORDER BY created_at DESC;

-- 쿼리 3: 상영 시간이 가장 긴 영화 탑 3 조회 (ORDER BY + LIMIT 활용)
SELECT title, duration FROM movies ORDER BY duration DESC LIMIT 3;

-- 쿼리 4: 이메일 주소에 'gmail'이 포함된 사용자 목록을 이름순으로 조회 (LIKE + WHERE + ORDER BY)
SELECT id, email, name FROM users WHERE email LIKE '%gmail%' ORDER BY name ASC;

-- 쿼리 5: 영화 제목과 해당 영화의 장르명을 함께 조회 (INNER JOIN 1)
SELECT m.id, m.title, g.name AS genre_name 
FROM movies m
INNER JOIN genres g ON m.genre_id = g.id;

-- 쿼리 6: 작성된 리뷰의 내용과 작성한 사용자의 이름을 함께 조회 (INNER JOIN 2)
SELECT r.id, u.name AS user_name, r.content, r.rating 
FROM reviews r
INNER JOIN users u ON r.user_id = u.id;

-- 쿼리 7: 전체 영화 목록을 조회하되, 작성된 리뷰 평점이 있다면 함께 표시 (리뷰가 없는 영화도 출력되도록 LEFT JOIN 활용)
SELECT m.title, r.rating, r.content 
FROM movies m
LEFT JOIN reviews r ON m.id = r.movie_id;

-- 쿼리 8: 영화 제목, 장르명, 작성자 이름, 리뷰 내용을 한눈에 보기 위한 3개 테이블 조인 (다중 JOIN)
SELECT m.title AS movie_title, g.name AS genre_name, u.name AS user_name, r.content
FROM reviews r
INNER JOIN movies m ON r.movie_id = m.id
INNER JOIN genres g ON m.genre_id = g.id
INNER JOIN users u ON r.user_id = u.id;

-- 쿼리 9: 장르별로 등록된 영화의 개수 집계 (COUNT + GROUP BY 활용)
SELECT g.name AS genre_name, COUNT(m.id) AS movie_count
FROM genres g
LEFT JOIN movies m ON g.id = m.genre_id
GROUP BY g.id, g.name;

-- 쿼리 10: 영화별 평균 리뷰 평점 구하기 (AVG + GROUP BY 활용)
SELECT m.title, AVG(r.rating) AS average_rating
FROM movies m
INNER JOIN reviews r ON m.id = r.movie_id
GROUP BY m.id, m.title;

-- 쿼리 11: 사용자들이 부여한 총 평점 점수와 작성한 총 리뷰 수 집계 (SUM + COUNT + GROUP BY 활용)
SELECT u.name, SUM(r.rating) AS total_rating_points, COUNT(r.id) AS review_count
FROM users u
INNER JOIN reviews r ON u.id = r.user_id
GROUP BY u.id, u.name;

-- 쿼리 12: 전체 영화의 평균 상영 시간보다 플레이타임이 긴 영화 목록 조회 (스칼라 서브쿼리 활용)
SELECT title, duration 
FROM movies 
WHERE duration > (SELECT AVG(duration) FROM movies);

-- 쿼리 13: ID가 1번인 사용자의 이름을 '김대박'으로 개명 (UPDATE 활용)
UPDATE users SET name = '김대박' WHERE id = 1;

-- 쿼리 14: 작성된 리뷰 중 평점이 3점 이하인 비추천 리뷰 삭제 (DELETE 활용)
DELETE FROM reviews WHERE rating <= 3;

-- 쿼리 15: 영화 제목을 검색 조건(WHERE)으로 자주 사용할 것에 대비한 인덱스 생성
-- 적용 이유: 영화 제목(title) 컬럼을 활용한 검색 조건이나 정렬 작업 시, 풀 테이블 스캔을 피하고 조회 성능을 향상시키기 위함입니다.
CREATE INDEX idx_movie_title ON movies(title);