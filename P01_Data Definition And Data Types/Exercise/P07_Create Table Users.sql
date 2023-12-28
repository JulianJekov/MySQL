CREATE TABLE `users` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(30) NOT NULL,
    `password` VARCHAR(26) NOT NULL,
    `profile_picture` BLOB,
    `last_login_time` TIME,
    `is_deleted` BOOLEAN
);

INSERT INTO `users` (`username`, `password`)
VALUES 
('Ivan', '1234'),
('Pesho', 'pesho1234'),
('Gosho', 'gosho88981'),
('Toshko', 'todor123'),
('Dragan', 'drago123131');

