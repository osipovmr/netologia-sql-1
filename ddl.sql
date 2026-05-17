-- =========================================
-- Таблица типов подразделений
-- =========================================
CREATE TABLE department_types (
    department_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL UNIQUE
);

-- =========================================
-- Таблица подразделений
-- =========================================
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL,
    department_type_id INTEGER NOT NULL,

    CONSTRAINT fk_department_type
        FOREIGN KEY (department_type_id)
        REFERENCES department_types(department_type_id)
);

-- =========================================
-- Таблица должностей
-- =========================================
CREATE TABLE positions (
    position_id SERIAL PRIMARY KEY,
    position_name VARCHAR(255) NOT NULL,
    salary NUMERIC(12,2) NOT NULL CHECK (salary >= 0)
);

-- =========================================
-- Таблица адресов
-- =========================================
CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    region VARCHAR(255),
    city VARCHAR(255),
    street VARCHAR(255),
    building VARCHAR(50),
    full_address TEXT NOT NULL
);

-- =========================================
-- Таблица филиалов
-- =========================================
CREATE TABLE branches (
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(255),
    address_id INTEGER NOT NULL UNIQUE,

    CONSTRAINT fk_branch_address
        FOREIGN KEY (address_id)
        REFERENCES addresses(address_id)
);

-- =========================================
-- Таблица сотрудников
-- =========================================
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    hire_date DATE NOT NULL,
    position_id INTEGER NOT NULL,
    department_id INTEGER NOT NULL,
    branch_id INTEGER NOT NULL,

    CONSTRAINT fk_employee_position
        FOREIGN KEY (position_id)
        REFERENCES positions(position_id),

    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id),

    CONSTRAINT fk_employee_branch
        FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

-- =========================================
-- Таблица проектов
-- =========================================
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL UNIQUE
);

-- =========================================
-- Таблица назначения сотрудников на проекты
-- =========================================
CREATE TABLE employee_projects (
    employee_id INTEGER NOT NULL,
    project_id INTEGER NOT NULL,
    assigned_at DATE DEFAULT CURRENT_DATE,

    PRIMARY KEY (employee_id, project_id),

    CONSTRAINT fk_ep_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_ep_project
        FOREIGN KEY (project_id)
        REFERENCES projects(project_id)
        ON DELETE CASCADE
);