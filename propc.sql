-- 1. Создание базы данных
DROP DATABASE IF EXISTS pc_upgrade;
CREATE DATABASE pc_upgrade;
\c pc_upgrade;

-- 2. Таблица: Customers
CREATE TABLE Customers (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);

-- 3. Таблица: Employees
CREATE TABLE Employees (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    position VARCHAR(50)
);

-- 4. Таблица: IntakePoints
CREATE TABLE IntakePoints (
    id SERIAL PRIMARY KEY,
    address VARCHAR(200),
    employee_id INT REFERENCES Employees(id)
);

-- 5. Таблица: RepairOrders
CREATE TABLE RepairOrders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers(id),
    intake_point_id INT REFERENCES IntakePoints(id),
    device_description TEXT,
    status VARCHAR(50),
    created_at DATE DEFAULT CURRENT_DATE
);

-- 6. Таблица: WorkshopRepairs
CREATE TABLE WorkshopRepairs (
    id SERIAL PRIMARY KEY,
    repair_order_id INT REFERENCES RepairOrders(id),
    master_id INT REFERENCES Employees(id),
    start_date DATE,
    end_date DATE
);

-- 7. Таблица: UrgentRepairs
CREATE TABLE UrgentRepairs (
    id SERIAL PRIMARY KEY,
    repair_order_id INT REFERENCES RepairOrders(id),
    master_id INT REFERENCES Employees(id),
    repair_time TIMESTAMP
);

-- 8. Таблица: RepairTasks
CREATE TABLE RepairTasks (
    id SERIAL PRIMARY KEY,
    repair_order_id INT REFERENCES RepairOrders(id),
    description TEXT,
    cost NUMERIC(10,2)
);

-- 9. Таблица: Parts
CREATE TABLE Parts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10,2)
);

-- 10. Таблица: PartsUsed
CREATE TABLE PartsUsed (
    id SERIAL PRIMARY KEY,
    repair_task_id INT REFERENCES RepairTasks(id),
    part_id INT REFERENCES Parts(id),
    quantity INT
);

-- Вставка данных
-- Customers
INSERT INTO Customers (full_name, phone, email) VALUES
('Иван Иванов', '89161234567', 'ivanov@example.com'),
('Петр Петров', '89161234568', 'petrov@example.com'),
('Сидор Сидоров', '89161234569', 'sidorov@example.com'),
('Мария Смирнова', '89161234570', 'smirnova@example.com'),
('Анна Кузнецова', '89161234571', 'kuznetsova@example.com'),
('Олег Орлов', '89161234572', 'orlov@example.com'),
('Виктория Белова', '89161234573', 'belova@example.com'),
('Егор Васильев', '89161234574', 'vasiliev@example.com'),
('Наталья Морозова', '89161234575', 'morozova@example.com'),
('Дмитрий Соколов', '89161234576', 'sokolov@example.com');

-- Employees
INSERT INTO Employees (full_name, position) VALUES
('Алексей Мастер', 'Мастер'),
('Ольга Приемщик', 'Приемщик'),
('Сергей Мастер', 'Мастер'),
('Инна Приемщик', 'Приемщик'),
('Игорь Техник', 'Мастер'),
('Никита Мастер', 'Мастер'),
('Дарья Приемщик', 'Приемщик'),
('Максим Инженер', 'Мастер'),
('Елена Приемщик', 'Приемщик'),
('Артур Стажер', 'Стажер');

-- IntakePoints
INSERT INTO IntakePoints (address, employee_id) VALUES
('ул. Ленина, 1', 2),
('пр. Мира, 15', 4),
('ул. Гагарина, 7', 7),
('ул. Победы, 23', 9),
('ул. Космонавтов, 11', 2);

-- RepairOrders
INSERT INTO RepairOrders (customer_id, intake_point_id, device_description, status, created_at) VALUES
(1, 1, 'ПК не включается', 'в процессе', '2024-01-01'),
(2, 2, 'Апгрейд видеокарты', 'завершен', '2024-01-05'),
(3, 3, 'Замена кулера', 'в процессе', '2024-01-08'),
(4, 4, 'Чистка системы', 'завершен', '2024-01-10'),
(5, 5, 'Установка SSD', 'принят', '2024-01-15'),
(6, 1, 'Диагностика БП', 'в процессе', '2024-01-17'),
(7, 2, 'Синий экран', 'завершен', '2024-01-20'),
(8, 3, 'Замена оперативной памяти', 'в процессе', '2024-01-22'),
(9, 4, 'Установка Windows', 'завершен', '2024-01-25'),
(10, 5, 'Перестал работать USB', 'принят', '2024-01-27');

-- WorkshopRepairs
INSERT INTO WorkshopRepairs (repair_order_id, master_id, start_date, end_date) VALUES
(1, 1, '2024-01-02', '2024-01-04'),
(2, 3, '2024-01-06', '2024-01-07'),
(3, 5, '2024-01-09', NULL),
(4, 6, '2024-01-11', '2024-01-12'),
(6, 1, '2024-01-18', NULL),
(7, 3, '2024-01-21', '2024-01-22'),
(8, 5, '2024-01-23', NULL);

-- UrgentRepairs
INSERT INTO UrgentRepairs (repair_order_id, master_id, repair_time) VALUES
(5, 1, '2024-01-15 10:00'),
(9, 6, '2024-01-25 14:30'),
(10, 1, '2024-01-27 16:00');

-- RepairTasks
INSERT INTO RepairTasks (repair_order_id, description, cost) VALUES
(1, 'Замена блока питания', 2500.00),
(2, 'Установка видеокарты', 1500.00),
(3, 'Замена кулера', 800.00),
(4, 'Чистка пыли', 500.00),
(5, 'Установка SSD и настройка', 2000.00),
(6, 'Диагностика', 1000.00),
(7, 'Переустановка драйверов', 700.00),
(8, 'Установка RAM', 900.00),
(9, 'Установка Windows', 1200.00),
(10, 'Ремонт USB-портов', 1600.00);

-- Parts
INSERT INTO Parts (name, price) VALUES
('Блок питания 500W', 3500.00),
('Кулер DeepCool', 1200.00),
('Видеокарта GTX 1660', 22000.00),
('SSD 512GB', 4500.00),
('Оперативная память 8GB', 2000.00),
('Материнская плата', 7500.00),
('USB контроллер', 900.00),
('Термопаста', 300.00),
('Жесткий диск 1TB', 3500.00),
('Кабель питания', 200.00);

-- PartsUsed
INSERT INTO PartsUsed (repair_task_id, part_id, quantity) VALUES
(1, 1, 1),
(2, 3, 1),
(3, 2, 1),
(4, 8, 1),
(5, 4, 1),
(6, 8, 1),
(7, 10, 1),
(8, 5, 2),
(9, 8, 1),
(10, 7, 1);

