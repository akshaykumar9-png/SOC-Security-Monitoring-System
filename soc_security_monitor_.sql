IF DB_ID(N'soc_security_monitor') IS NULL
    CREATE DATABASE soc_security_monitor;
GO
USE soc_security_monitor;
GO

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    department_code VARCHAR(30) UNIQUE,
    location VARCHAR(100),
    building VARCHAR(100),
    floor_number INT,
    manager_name VARCHAR(100),
    manager_email VARCHAR(100),
    manager_phone VARCHAR(20),
    budget DECIMAL(12,2),
    employee_count INT,
    department_type VARCHAR(50),
    cost_center VARCHAR(50),
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    working_hours VARCHAR(50),
    status VARCHAR(30),
    created_date DATE,
    updated_date DATE,
    description VARCHAR(300)
);


CREATE TABLE roles (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    role_code VARCHAR(30) UNIQUE,
    description VARCHAR(200),
    access_level VARCHAR(30),
    permission_level INT,
    department_name VARCHAR(100),
    job_category VARCHAR(50),
    employment_type VARCHAR(30),
    shift_type VARCHAR(30),
    certification_required VARCHAR(100),
    experience_required INT,
    salary_grade VARCHAR(30),
    reporting_level VARCHAR(30),
    remote_allowed BIT,
    privileged_access BIT,
    active_status VARCHAR(30),
    created_date DATE,
    updated_date DATE,
    notes VARCHAR(300)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_code VARCHAR(30) UNIQUE,
    employee_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    alternate_email VARCHAR(100),
    phone VARCHAR(20),
    alternate_phone VARCHAR(20),
    date_of_birth DATE,
    gender VARCHAR(20),
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    department_id INT,
    role_id INT,
    joining_date DATE,
    employment_type VARCHAR(30),
    status VARCHAR(30),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    employee_id INT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_status VARCHAR(30),
    account_status VARCHAR(30),
    last_login DATETIME,
    last_logout DATETIME,
    password_changed_date DATE,
    failed_login_count INT,
    account_locked BIT,
    lock_reason VARCHAR(200),
    mfa_enabled BIT,
    mfa_method VARCHAR(50),
    recovery_email VARCHAR(100),
    recovery_phone VARCHAR(20),
    privilege_level VARCHAR(30),
    created_date DATE,
    expiry_date DATE,
    login_attempt_limit INT,
    notes VARCHAR(300),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE soc_analysts (
    analyst_id INT PRIMARY KEY,
    employee_id INT NOT NULL UNIQUE,
    analyst_code VARCHAR(30) UNIQUE,
    analyst_level VARCHAR(30),
    shift_name VARCHAR(30),
    experience_years INT,
    certification VARCHAR(100),
    specialization VARCHAR(100),
    clearance_level VARCHAR(30),
    assigned_team VARCHAR(100),
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    availability_status VARCHAR(30),
    current_incidents INT,
    alerts_handled INT,
    incidents_resolved INT,
    last_training_date DATE,
    next_training_date DATE,
    joining_date DATE,
    performance_status VARCHAR(30),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE operating_systems (
    os_id INT PRIMARY KEY,
    os_name VARCHAR(50) NOT NULL,
    version VARCHAR(50),
    vendor VARCHAR(50),
    edition VARCHAR(50),
    architecture VARCHAR(20),
    release_date DATE,
    end_of_support DATE,
    kernel_version VARCHAR(50),
    build_number VARCHAR(50),
    patch_level VARCHAR(50),
    license_type VARCHAR(50),
    license_key VARCHAR(100),
    security_status VARCHAR(30),
    encryption_supported BIT,
    firewall_supported BIT,
    antivirus_supported BIT,
    default_port VARCHAR(100),
    platform_type VARCHAR(50),
    description VARCHAR(300)
);

CREATE TABLE devices (
    device_id INT PRIMARY KEY,
    device_name VARCHAR(100) NOT NULL,
    device_code VARCHAR(50) UNIQUE,
    device_type VARCHAR(50),
    serial_number VARCHAR(100) UNIQUE,
    asset_tag VARCHAR(50) UNIQUE,
    os_id INT,
    department_id INT,
    employee_id INT,
    ip_address VARCHAR(45),
    mac_address VARCHAR(50) UNIQUE,
    hostname VARCHAR(100),
    manufacturer VARCHAR(100),
    model VARCHAR(100),
    purchase_date DATE,
    warranty_expiry DATE,
    location VARCHAR(100),
    status VARCHAR(30),
    last_seen DATETIME,
    security_status VARCHAR(30),
    FOREIGN KEY (os_id) REFERENCES operating_systems(os_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE servers (
    server_id INT PRIMARY KEY,
    server_name VARCHAR(100) NOT NULL,
    server_code VARCHAR(50) UNIQUE,
    server_type VARCHAR(50),
    ip_address VARCHAR(45) UNIQUE,
    operating_system VARCHAR(100),
    os_version VARCHAR(50),
    hostname VARCHAR(100),
    domain_name VARCHAR(100),
    location VARCHAR(100),
    rack_number VARCHAR(30),
    data_center VARCHAR(100),
    processor VARCHAR(100),
    memory_gb INT,
    storage_gb INT,
    operating_status VARCHAR(30),
    security_status VARCHAR(30),
    installation_date DATE,
    last_patch_date DATE,
    description VARCHAR(300)
);

CREATE TABLE ip_addresses (
    ip_id INT PRIMARY KEY,
    ip_address VARCHAR(45) NOT NULL UNIQUE,
    ip_type VARCHAR(30),
    ip_version VARCHAR(10),
    country VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50),
    region VARCHAR(100),
    isp VARCHAR(100),
    organization VARCHAR(100),
    hostname VARCHAR(100),
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    reputation VARCHAR(30),
    risk_score INT,
    first_seen DATE,
    last_seen DATE,
    blacklist_status VARCHAR(30),
    proxy_status BIT,
    notes VARCHAR(300)
);

CREATE TABLE alert_types (
    alert_type_id INT PRIMARY KEY,
    alert_type_name VARCHAR(100) NOT NULL UNIQUE,
    alert_code VARCHAR(30) UNIQUE,
    description VARCHAR(200),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    source_system VARCHAR(100),
    detection_method VARCHAR(100),
    default_severity VARCHAR(30),
    priority INT,
    response_required BIT,
    automated_response BIT,
    notification_required BIT,
    escalation_level INT,
    frequency_limit INT,
    retention_days INT,
    status VARCHAR(30),
    created_date DATE,
    updated_date DATE,
    notes VARCHAR(300)
);

CREATE TABLE severity_levels (
    severity_id INT PRIMARY KEY,
    severity_name VARCHAR(30) NOT NULL UNIQUE,
    severity_code VARCHAR(20) UNIQUE,
    priority_value INT,
    risk_score_min INT,
    risk_score_max INT,
    description VARCHAR(200),
    response_time_minutes INT,
    escalation_required BIT,
    management_notification BIT,
    analyst_required VARCHAR(50),
    sla_hours INT,
    color_code VARCHAR(20),
    business_impact VARCHAR(100),
    security_impact VARCHAR(100),
    financial_impact VARCHAR(100),
    operational_impact VARCHAR(100),
    active_status VARCHAR(30),
    created_date DATE,
    notes VARCHAR(300)
);

CREATE TABLE incident_types (
    incident_type_id INT PRIMARY KEY,
    incident_type_name VARCHAR(100) NOT NULL UNIQUE,
    incident_code VARCHAR(30) UNIQUE,
    description VARCHAR(200),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    attack_stage VARCHAR(50),
    common_source VARCHAR(100),
    default_severity VARCHAR(30),
    response_team VARCHAR(100),
    investigation_required BIT,
    containment_required BIT,
    eradication_required BIT,
    recovery_required BIT,
    evidence_required BIT,
    notification_required BIT,
    retention_days INT,
    status VARCHAR(30),
    created_date DATE,
    notes VARCHAR(300)
);

CREATE TABLE incident_status (
    status_id INT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE,
    status_code VARCHAR(20) UNIQUE,
    description VARCHAR(200),
    status_order INT,
    is_open BIT,
    is_closed BIT,
    is_active BIT,
    requires_action BIT,
    requires_approval BIT,
    escalation_required BIT,
    notification_required BIT,
    allowed_role VARCHAR(100),
    next_status VARCHAR(50),
    sla_hours INT,
    color_code VARCHAR(20),
    created_date DATE,
    updated_date DATE,
    category VARCHAR(50),
    notes VARCHAR(300)
);

CREATE TABLE threat_types (
    threat_type_id INT PRIMARY KEY,
    threat_type_name VARCHAR(100) NOT NULL UNIQUE,
    threat_code VARCHAR(30) UNIQUE,
    description VARCHAR(200),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    attack_vector VARCHAR(100),
    target_type VARCHAR(100),
    threat_actor VARCHAR(100),
    motivation VARCHAR(100),
    typical_severity VARCHAR(30),
    risk_level VARCHAR(30),
    detection_method VARCHAR(100),
    mitigation_method VARCHAR(200),
    intelligence_source VARCHAR(100),
    frequency VARCHAR(50),
    active_status VARCHAR(30),
    created_date DATE,
    updated_date DATE,
    notes VARCHAR(300)
);

CREATE TABLE threats (
    threat_id INT PRIMARY KEY,
    threat_name VARCHAR(100) NOT NULL,
    threat_code VARCHAR(50) UNIQUE,
    threat_type_id INT,
    threat_source VARCHAR(100),
    threat_level VARCHAR(30),
    risk_score INT,
    first_detected DATE,
    last_detected DATE,
    detection_count INT,
    affected_assets INT,
    affected_users INT,
    attack_vector VARCHAR(100),
    target_system VARCHAR(100),
    threat_actor VARCHAR(100),
    geographic_origin VARCHAR(100),
    status VARCHAR(30),
    mitigation_status VARCHAR(50),
    description VARCHAR(300),
    created_date DATE,
    FOREIGN KEY (threat_type_id) REFERENCES threat_types(threat_type_id)
);

CREATE TABLE malware (
    malware_id INT PRIMARY KEY,
    malware_name VARCHAR(100) NOT NULL,
    malware_family VARCHAR(100),
    malware_type VARCHAR(50),
    version VARCHAR(50),
    threat_id INT,
    severity_id INT,
    hash_md5 VARCHAR(100),
    hash_sha1 VARCHAR(100),
    hash_sha256 VARCHAR(150),
    file_name VARCHAR(200),
    file_size BIGINT,
    file_type VARCHAR(50),
    first_seen DATE,
    last_seen DATE,
    source VARCHAR(100),
    infection_method VARCHAR(100),
    target_platform VARCHAR(100),
    status VARCHAR(30),
    description VARCHAR(300),
    FOREIGN KEY (threat_id) REFERENCES threats(threat_id),
    FOREIGN KEY (severity_id) REFERENCES severity_levels(severity_id)
);

CREATE TABLE vulnerabilities (
    vulnerability_id INT PRIMARY KEY,
    vulnerability_name VARCHAR(150) NOT NULL,
    vulnerability_code VARCHAR(50) UNIQUE,
    cve_number VARCHAR(50) UNIQUE,
    severity_id INT,
    vulnerability_type VARCHAR(100),
    affected_product VARCHAR(150),
    affected_version VARCHAR(100),
    fixed_version VARCHAR(100),
    discovered_date DATE,
    published_date DATE,
    last_modified_date DATE,
    cvss_score DECIMAL(3,1),
    exploit_available BIT,
    exploitability VARCHAR(50),
    patch_available BIT,
    remediation VARCHAR(300),
    reference_url VARCHAR(300),
    status VARCHAR(30),
    description VARCHAR(300),
    FOREIGN KEY (severity_id) REFERENCES severity_levels(severity_id)
);

CREATE TABLE vulnerability_types (
    vulnerability_type_id INT PRIMARY KEY,
    vulnerability_type_name VARCHAR(100) NOT NULL UNIQUE,
    vulnerability_code VARCHAR(30) UNIQUE,
    description VARCHAR(200),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    attack_vector VARCHAR(100),
    attack_complexity VARCHAR(50),
    privilege_required VARCHAR(50),
    user_interaction_required BIT,
    confidentiality_impact VARCHAR(30),
    integrity_impact VARCHAR(30),
    availability_impact VARCHAR(30),
    common_target VARCHAR(100),
    detection_method VARCHAR(100),
    mitigation_method VARCHAR(200),
    example_cve VARCHAR(50),
    risk_level VARCHAR(30),
    status VARCHAR(30),
    notes VARCHAR(300)
);

CREATE TABLE security_alerts (
    alert_id INT PRIMARY KEY,
    alert_name VARCHAR(150) NOT NULL,
    alert_code VARCHAR(50) UNIQUE,
    alert_type_id INT,
    severity_id INT,
    device_id INT,
    ip_id INT,
    analyst_id INT,
    alert_time DATETIME,
    detection_time DATETIME,
    alert_status VARCHAR(30),
    source_system VARCHAR(100),
    source_rule VARCHAR(150),
    event_count INT,
    risk_score INT,
    source_ip VARCHAR(45),
    destination_ip VARCHAR(45),
    protocol VARCHAR(20),
    description VARCHAR(300),
    resolution_notes VARCHAR(300),
    FOREIGN KEY (alert_type_id) REFERENCES alert_types(alert_type_id),
    FOREIGN KEY (severity_id) REFERENCES severity_levels(severity_id),
    FOREIGN KEY (device_id) REFERENCES devices(device_id),
    FOREIGN KEY (ip_id) REFERENCES ip_addresses(ip_id),
    FOREIGN KEY (analyst_id) REFERENCES soc_analysts(analyst_id)
);

CREATE TABLE incidents (
    incident_id INT PRIMARY KEY,
    incident_title VARCHAR(150) NOT NULL,
    incident_code VARCHAR(50) UNIQUE,
    incident_type_id INT,
    severity_id INT,
    status_id INT,
    alert_id INT,
    reported_by INT,
    assigned_analyst INT,
    created_time DATETIME,
    detected_time DATETIME,
    acknowledged_time DATETIME,
    contained_time DATETIME,
    resolved_time DATETIME,
    closed_time DATETIME,
    affected_device_count INT,
    affected_user_count INT,
    root_cause VARCHAR(300),
    description VARCHAR(500),
    resolution_notes VARCHAR(500),
    FOREIGN KEY (incident_type_id) REFERENCES incident_types(incident_type_id),
    FOREIGN KEY (severity_id) REFERENCES severity_levels(severity_id),
    FOREIGN KEY (status_id) REFERENCES incident_status(status_id),
    FOREIGN KEY (alert_id) REFERENCES security_alerts(alert_id),
    FOREIGN KEY (reported_by) REFERENCES users(user_id),
    FOREIGN KEY (assigned_analyst) REFERENCES soc_analysts(analyst_id)
);

INSERT INTO departments (
    department_id,
    department_name, department_code, location, building,
    floor_number, manager_name, manager_email, manager_phone,
    budget, employee_count, department_type, cost_center,
    contact_email, contact_phone, working_hours, status,
    created_date, updated_date, description
) VALUES
(1,'IT','IT-01','Hyderabad','Tech Park Tower A',3,'Ramesh','ramesh@company.com','9811000001',5000000.0,25,'Technical','CC-IT-101','it@company.com','040-40001001','09:00-18:00','Active','2020-01-15','2026-08-01','Manages IT infrastructure, applications and user support'),
(2,'Finance','FIN-01','Hyderabad','Tech Park Tower B',2,'Suresh','suresh@company.com','9811000002',3500000.0,15,'Business','CC-FIN-102','finance@company.com','040-40001002','09:30-18:30','Active','2020-01-15','2026-07-20','Handles accounts, payroll and budgeting'),
(3,'HR','HR-01','Bangalore','Prestige Tech Hub',1,'Priya','priya@company.com','9811000003',2500000.0,10,'Support','CC-HR-103','hr@company.com','080-40001003','09:30-18:30','Active','2020-02-01','2026-06-15','Manages recruitment, onboarding and employee welfare'),
(4,'Security','SEC-01','Hyderabad','Tech Park Tower A',5,'Kiran','kiran@company.com','9811000004',6500000.0,12,'Technical','CC-SEC-104','security@company.com','040-40001004','24x7','Active','2020-01-15','2026-09-01','Runs the SOC and handles security monitoring and incident response'),
(5,'Operations','OPS-01','Chennai','Chennai Business Center',4,'Arun','arun.ops@company.com','9811000005',4000000.0,20,'Operations','CC-OPS-105','operations@company.com','044-40001005','08:00-17:00','Active','2020-03-10','2026-07-05','Handles day-to-day business operations and logistics');

INSERT INTO roles (
    role_id,
    role_name, role_code, description, access_level,
    permission_level, department_name, job_category, employment_type,
    shift_type, certification_required, experience_required, salary_grade,
    reporting_level, remote_allowed, privileged_access, active_status,
    created_date, updated_date, notes
) VALUES
(1,'SOC Analyst','SOC-ANL','Monitors security alerts','High',3,'Security','Security Operations','Full-time','Rotational','Security+ / CEH',1,'G3','Level 2',0,0,'Active','2020-01-15','2026-05-10','Monitors, triages and escalates security alerts'),
(2,'System Admin','SYS-ADM','Manages systems','High',4,'IT','Infrastructure','Full-time','Day','RHCSA / MCSA',3,'G4','Level 3',1,1,'Active','2020-01-15','2026-05-10','Maintains servers, OS patches and system access'),
(3,'Network Admin','NET-ADM','Manages network','High',4,'IT','Infrastructure','Full-time','Day','CCNA',3,'G4','Level 3',1,1,'Active','2020-01-15','2026-05-10','Maintains routers, switches and firewalls'),
(4,'Security Manager','SEC-MGR','Manages security team','Admin',5,'Security','Management','Full-time','Day','CISSP / CISM',8,'G6','Level 5',1,1,'Active','2020-01-15','2026-05-10','Leads the security team and reports to management'),
(5,'Employee','EMP-USR','Regular company user','Basic',1,'All Departments','General','Full-time','Day','None',0,'G1','Level 1',0,0,'Active','2020-01-15','2026-05-10','Standard access for regular company staff');

INSERT INTO employees (
    employee_id,
    employee_code, employee_name, first_name, last_name,
    email, alternate_email, phone, alternate_phone,
    date_of_birth, gender, address, city,
    state, pincode, department_id, role_id,
    joining_date, employment_type, status
) VALUES
(1,'EMP001','Akash Kumar','Akash','Kumar','akash@gmail.com','akash.kumar@company.com','9876543210','9123456780','2001-04-12','Male','12-3-45 Madhapur','Hyderabad','Telangana','500081',1,1,'2025-06-10','Full-time','Active'),
(2,'EMP002','Rahul Sharma','Rahul','Sharma','rahul@gmail.com','rahul.sharma@company.com','9876543211','9123456781','1999-11-23','Male','45 Gachibowli','Hyderabad','Telangana','500032',4,1,'2024-08-15','Full-time','Active'),
(3,'EMP003','Priya Singh','Priya','Singh','priya@gmail.com','priya.singh@company.com','9876543212','9123456782','1996-07-08','Female','22 MG Road','Bangalore','Karnataka','560001',3,2,'2023-05-20','Full-time','Active'),
(4,'EMP004','Arun Kumar','Arun','Kumar','arun@gmail.com','arun.kumar@company.com','9876543213','9123456783','1994-02-17','Male','8 Kukatpally Housing Board','Hyderabad','Telangana','500072',1,3,'2022-03-10','Full-time','Active'),
(5,'EMP005','Kiran Reddy','Kiran','Reddy','kiran@gmail.com','kiran.reddy@company.com','9876543214','9123456784','1990-09-30','Male','101 Banjara Hills','Hyderabad','Telangana','500034',4,4,'2021-01-12','Full-time','Active'),
(6,'EMP006','Vijay Rao','Vijay','Rao','vijay@gmail.com','vijay.rao@company.com','9876543215','9123456785','1998-12-05','Male','15 Ameerpet','Hyderabad','Telangana','500016',2,5,'2025-01-10','Full-time','Active');

INSERT INTO users (
    user_id,
    employee_id, username, password_status, account_status,
    last_login, last_logout, password_changed_date, failed_login_count,
    account_locked, lock_reason, mfa_enabled, mfa_method,
    recovery_email, recovery_phone, privilege_level, created_date,
    expiry_date, login_attempt_limit, notes
) VALUES
(1,1,'akash','Strong','Active','2026-09-14 09:10:00','2026-09-14 17:30:00','2026-06-01',0,0,'Not applicable',1,'Authenticator App','akash.recovery@gmail.com','9123456780','Standard','2025-06-10','2027-06-10',5,'SOC L1 analyst account'),
(2,2,'rahul','Strong','Active','2026-09-14 09:15:00','2026-09-14 18:00:00','2026-05-15',0,0,'Not applicable',1,'Authenticator App','rahul.recovery@gmail.com','9123456781','Elevated','2024-08-15','2026-12-31',5,'SOC L2 analyst account'),
(3,3,'priya','Strong','Active','2026-09-13 10:20:00','2026-09-13 18:45:00','2026-04-20',0,0,'Not applicable',1,'SMS OTP','priya.recovery@gmail.com','9123456782','Standard','2023-05-20','2026-12-31',5,'HR department user'),
(4,4,'arun','Expired','Active','2026-09-12 08:45:00','2026-09-12 17:15:00','2025-12-01',2,0,'Not applicable',1,'SMS OTP','arun.recovery@gmail.com','9123456783','Admin','2022-03-10','2026-10-15',5,'Network admin - password change pending'),
(5,5,'kiran','Strong','Active','2026-09-14 08:30:00','2026-09-14 19:00:00','2026-07-10',0,0,'Not applicable',1,'Hardware Token','kiran.recovery@gmail.com','9123456784','Admin','2021-01-12','2027-01-12',3,'Security manager account'),
(6,6,'vijay','Weak','Active','2026-09-14 11:00:00','2026-09-14 17:45:00','2025-09-01',3,0,'Not applicable',0,'None','vijay.recovery@gmail.com','9123456785','Standard','2025-01-10','2026-11-30',5,'Finance user - weak password, MFA not enabled');

INSERT INTO soc_analysts (
    analyst_id,
    employee_id, analyst_code, analyst_level, shift_name,
    experience_years, certification, specialization, clearance_level,
    assigned_team, contact_email, contact_phone, availability_status,
    current_incidents, alerts_handled, incidents_resolved, last_training_date,
    next_training_date, joining_date, performance_status
) VALUES
(1,1,'SOC-A001','L1','Morning',1,'Security+','Alert Triage','Confidential','SOC Team A','akash.soc@company.com','9123456780','Busy',2,120,45,'2026-06-10','2026-12-10','2025-06-10','Good'),
(2,2,'SOC-A002','L2','Evening',2,'CEH','Incident Response','Secret','SOC Team A','rahul.soc@company.com','9123456781','Busy',2,310,140,'2026-05-20','2026-11-20','2024-08-15','Very Good'),
(3,5,'SOC-A003','L3','Night',4,'CISSP','Threat Hunting','Top Secret','SOC Team B','kiran.soc@company.com','9123456784','Available',0,640,380,'2026-04-15','2026-10-15','2021-01-12','Excellent');

INSERT INTO operating_systems (
    os_id,
    os_name, version, vendor, edition,
    architecture, release_date, end_of_support, kernel_version,
    build_number, patch_level, license_type, license_key,
    security_status, encryption_supported, firewall_supported, antivirus_supported,
    default_port, platform_type, description
) VALUES
(1,'Windows','11','Microsoft','Pro','x64','2021-10-05','2026-10-13','NT 10.0','22631.3007','2026-08 Cumulative','Commercial','WIN11-PRO-XXXXX-00001','Supported',1,1,1,'135, 139, 445, 3389','Desktop','Microsoft desktop operating system for workstations'),
(2,'Windows Server','2022','Microsoft','Standard','x64','2021-08-18','2031-10-14','NT 10.0','20348.2527','2026-08 Cumulative','Commercial','WINSRV22-STD-XXXXX-00002','Supported',1,1,1,'135, 445, 3389, 5985','Server','Microsoft server operating system for enterprise workloads'),
(3,'Ubuntu','24.04','Canonical','LTS','x64','2024-04-25','2029-05-31','6.8.0','24.04.1','2026-08 Security Update','Open Source','Not required','Supported',1,1,1,'22, 80, 443','Server / Desktop','Long-term support Linux distribution'),
(4,'Kali Linux','2026.1','Kali','Rolling','x64','2026-02-24','2027-02-24','6.12.0','2026.1','2026-08 Rolling Update','Open Source','Not required','Supported',1,1,0,'22','Security / Pentesting','Linux distribution used for security testing and analysis'),
(5,'Red Hat','9','Red Hat','Enterprise Linux','x64','2022-05-17','2032-05-31','5.14.0','9.4','2026-08 Errata','Subscription','RHEL9-SUB-XXXXX-00005','Supported',1,1,1,'22, 80, 443, 3306','Server','Enterprise Linux distribution for production servers');

INSERT INTO devices (
    device_id,
    device_name, device_code, device_type, serial_number,
    asset_tag, os_id, department_id, employee_id,
    ip_address, mac_address, hostname, manufacturer,
    model, purchase_date, warranty_expiry, location,
    status, last_seen, security_status
) VALUES
(1,'IT-PC-01','DEV-001','Desktop','PC1001','AST-1001',1,1,1,'192.168.1.10','AA:BB:CC:DD:EE:01','it-pc-01.corp.local','Dell','OptiPlex 7090','2024-01-10','2027-01-10','Hyderabad - Tower A, Floor 3','Active','2026-09-14 09:05:00','At Risk'),
(2,'IT-PC-02','DEV-002','Desktop','PC1002','AST-1002',1,1,4,'192.168.1.11','AA:BB:CC:DD:EE:02','it-pc-02.corp.local','Dell','OptiPlex 7090','2024-01-10','2027-01-10','Hyderabad - Tower A, Floor 3','Active','2026-09-14 09:08:00','Infected'),
(3,'FIN-PC-01','DEV-003','Desktop','PC1003','AST-1003',1,2,6,'192.168.2.10','AA:BB:CC:DD:EE:03','fin-pc-01.corp.local','HP','ProDesk 600 G6','2023-11-05','2026-11-05','Hyderabad - Tower B, Floor 2','Active','2026-09-14 10:15:00','Monitored'),
(4,'SOC-PC-01','DEV-004','Desktop','PC1004','AST-1004',4,4,2,'192.168.4.10','AA:BB:CC:DD:EE:04','soc-pc-01.corp.local','Lenovo','ThinkCentre M90t','2024-06-20','2027-06-20','Hyderabad - Tower A, Floor 5','Active','2026-09-14 11:55:00','Monitored'),
(5,'HR-PC-01','DEV-005','Laptop','PC1005','AST-1005',1,3,3,'192.168.3.10','AA:BB:CC:DD:EE:05','hr-pc-01.corp.local','Lenovo','ThinkPad E14','2025-02-12','2028-02-12','Bangalore - Prestige Tech Hub','Active','2026-09-14 11:25:00','Secure');

INSERT INTO servers (
    server_id,
    server_name, server_code, server_type, ip_address,
    operating_system, os_version, hostname, domain_name,
    location, rack_number, data_center, processor,
    memory_gb, storage_gb, operating_status, security_status,
    installation_date, last_patch_date, description
) VALUES
(1,'WEB-SERVER-01','SRV-001','Web','10.0.0.10','Ubuntu 24.04','24.04','web-server-01','corp.local','Hyderabad','Rack A1','Hyderabad Data Center','Intel Xeon Silver 4310',32,500,'Active','Secure','2024-02-15','2026-08-20','Hosts the company website and web applications'),
(2,'DB-SERVER-01','SRV-002','Database','10.0.0.20','Red Hat 9','9','db-server-01','corp.local','Hyderabad','Rack A2','Hyderabad Data Center','Intel Xeon Gold 5318Y',64,2000,'Active','Monitored','2024-02-15','2026-08-18','Stores business and security monitoring data'),
(3,'MAIL-SERVER-01','SRV-003','Mail','10.0.0.30','Windows Server 2022','2022','mail-server-01','corp.local','Bangalore','Rack B1','Bangalore Data Center','Intel Xeon Silver 4314',32,1000,'Active','Secure','2024-05-10','2026-08-22','Handles company email services'),
(4,'FILE-SERVER-01','SRV-004','File','10.0.0.40','Windows Server 2022','2022','file-server-01','corp.local','Chennai','Rack C1','Chennai Data Center','Intel Xeon Silver 4310',16,4000,'Active','Secure','2024-07-01','2026-08-25','Shared file storage for all departments');

INSERT INTO ip_addresses (
    ip_id,
    ip_address, ip_type, ip_version, country,
    state, city, region, isp,
    organization, hostname, latitude, longitude,
    reputation, risk_score, first_seen, last_seen,
    blacklist_status, proxy_status, notes
) VALUES
(1,'192.168.1.10','Private','IPv4','India','Telangana','Hyderabad','South India','Internal','Company Network','it-pc-01.corp.local',17.385044,78.486671,'Good',5,'2025-01-01','2026-09-14','Not Listed',0,'Internal IT desktop'),
(2,'192.168.1.11','Private','IPv4','India','Telangana','Hyderabad','South India','Internal','Company Network','it-pc-02.corp.local',17.385044,78.486671,'Good',10,'2025-01-01','2026-09-14','Not Listed',0,'Internal IT desktop'),
(3,'192.168.2.10','Private','IPv4','India','Telangana','Hyderabad','South India','Internal','Company Network','fin-pc-01.corp.local',17.385044,78.486671,'Good',5,'2025-01-01','2026-09-14','Not Listed',0,'Internal finance desktop'),
(4,'45.33.12.20','Public','IPv4','USA','New York','New York','North America','Cloud ISP','Cloud Hosting Provider','host-45-33-12-20.cloud.example',40.712776,-74.005974,'Bad',85,'2026-09-01','2026-09-14','Blacklisted',1,'Source of repeated failed logins'),
(5,'103.45.67.89','Public','IPv4','India','Maharashtra','Mumbai','West India','ISP India','Unknown Organization','host-103-45-67-89.isp.example',19.07609,72.877426,'Suspicious',60,'2026-09-03','2026-09-14','Watchlist',0,'Linked to suspicious login and malware activity'),
(6,'185.22.33.44','Public','IPv4','Russia','Moscow','Moscow','Eastern Europe','Unknown ISP','Unknown Organization','host-185-22-33-44.unknown.example',55.755826,37.6173,'Bad',90,'2026-09-05','2026-09-14','Blacklisted',1,'Source of port scanning activity');

INSERT INTO alert_types (
    alert_type_id,
    alert_type_name, alert_code, description, category,
    subcategory, source_system, detection_method, default_severity,
    priority, response_required, automated_response, notification_required,
    escalation_level, frequency_limit, retention_days, status,
    created_date, updated_date, notes
) VALUES
(1,'Brute Force','ALT-BRUTE','Multiple failed login attempts','Authentication','Credential Attack','SIEM','Threshold-based rule','High',2,1,0,1,2,100,365,'Active','2020-01-15','2026-06-01','Triggered after repeated failed logins from one source'),
(2,'Malware Detection','ALT-MAL','Malicious software detected','Endpoint Security','Malware','EDR','Signature and behavior based','Critical',1,1,1,1,3,50,730,'Active','2020-01-15','2026-06-01','Triggered when endpoint protection flags malicious files'),
(3,'Port Scan','ALT-PSCAN','Multiple ports scanned','Network','Reconnaissance','IDS/IPS','Anomaly detection','Medium',3,1,0,1,1,200,180,'Active','2020-01-15','2026-06-01','Triggered when one host probes many ports'),
(4,'Suspicious Login','ALT-SLOG','Unusual login detected','Authentication','Anomalous Access','Identity Provider','Behavior analytics','High',2,1,0,1,2,50,365,'Active','2020-01-15','2026-06-01','Triggered by unusual login location or time'),
(5,'Data Transfer','ALT-DTX','Unusual data transfer','Data Protection','Data Exfiltration','DLP / Firewall','Volume-based rule','Medium',3,1,0,1,2,30,365,'Active','2020-01-15','2026-06-01','Triggered by abnormally large outbound transfers');

INSERT INTO severity_levels (
    severity_id,
    severity_name, severity_code, priority_value, risk_score_min,
    risk_score_max, description, response_time_minutes, escalation_required,
    management_notification, analyst_required, sla_hours, color_code,
    business_impact, security_impact, financial_impact, operational_impact,
    active_status, created_date, notes
) VALUES
(1,'Low','LOW',1,0,25,'Low risk event',480,0,0,'L1 Analyst',72,'#28A745','Minimal','Minimal','Negligible','No disruption','Active','2020-01-15','Monitor and log only'),
(2,'Medium','MED',2,26,50,'Medium risk event',240,0,0,'L1 Analyst',24,'#FFC107','Limited','Low','Low','Minor disruption','Active','2020-01-15','Investigate within the same day'),
(3,'High','HIGH',3,51,75,'High risk event',60,1,1,'L2 Analyst',8,'#FD7E14','Significant','High','Moderate','Partial disruption','Active','2020-01-15','Escalate to L2 and inform management'),
(4,'Critical','CRIT',4,76,100,'Critical security event',15,1,1,'L3 Analyst',2,'#DC3545','Severe','Critical','High','Major disruption','Active','2020-01-15','Immediate response required');

INSERT INTO incident_types (
    incident_type_id,
    incident_type_name, incident_code, description, category,
    subcategory, attack_stage, common_source, default_severity,
    response_team, investigation_required, containment_required, eradication_required,
    recovery_required, evidence_required, notification_required, retention_days,
    status, created_date, notes
) VALUES
(1,'Brute Force Attack','INC-BRUTE','Repeated login attempts','Authentication','Credential Attack','Initial Access','External IP','High','SOC Team',1,1,0,0,1,1,365,'Active','2020-01-15','Often detected through failed login spikes'),
(2,'Malware Attack','INC-MAL','Malicious software incident','Endpoint','Malware','Execution','Email attachment or download','Critical','SOC and IT Team',1,1,1,1,1,1,730,'Active','2020-01-15','Isolate the device before cleanup'),
(3,'Phishing','INC-PHISH','Fraudulent communication','Social Engineering','Email Phishing','Initial Access','Email','High','SOC and Awareness Team',1,1,0,0,1,1,365,'Active','2020-01-15','Check for other recipients of the same email'),
(4,'Network Attack','INC-NET','Network based attack','Network','Reconnaissance / DoS','Reconnaissance','External network','Medium','Network and SOC Team',1,1,0,1,1,1,365,'Active','2020-01-15','Review firewall and IDS logs'),
(5,'Unauthorized Access','INC-UAC','Unauthorized account access','Access Control','Account Compromise','Privilege Escalation','Compromised credentials','High','SOC Team',1,1,1,1,1,1,545,'Active','2020-01-15','Reset credentials and review account activity');

INSERT INTO incident_status (
    status_id,
    status_name, status_code, description, status_order,
    is_open, is_closed, is_active, requires_action,
    requires_approval, escalation_required, notification_required, allowed_role,
    next_status, sla_hours, color_code, created_date,
    updated_date, category, notes
) VALUES
(1,'Open','OPEN','Incident is open',1,1,0,1,1,0,0,1,'SOC Analyst','Investigating',4,'#DC3545','2020-01-15','2026-06-01','Active','Newly created incident waiting for analyst action'),
(2,'Investigating','INVEST','Investigation is in progress',2,1,0,1,1,0,0,1,'SOC Analyst','Contained',24,'#FD7E14','2020-01-15','2026-06-01','Active','Analyst is collecting evidence and analysing the incident'),
(3,'Contained','CONTAIN','Threat has been contained',3,1,0,1,1,0,0,1,'SOC Analyst','Resolved',48,'#FFC107','2020-01-15','2026-06-01','Active','Threat is isolated and cannot spread further'),
(4,'Resolved','RESOLVED','Incident has been resolved',4,0,0,0,0,1,0,1,'SOC Manager','Closed',72,'#28A745','2020-01-15','2026-06-01','Completed','Fix applied, waiting for approval to close'),
(5,'Closed','CLOSED','Incident is closed',5,0,1,0,0,0,0,0,'SOC Manager','None',0,'#6C757D','2020-01-15','2026-06-01','Completed','Incident is fully closed and documented');

INSERT INTO threat_types (
    threat_type_id,
    threat_type_name, threat_code, description, category,
    subcategory, attack_vector, target_type, threat_actor,
    motivation, typical_severity, risk_level, detection_method,
    mitigation_method, intelligence_source, frequency, active_status,
    created_date, updated_date, notes
) VALUES
(1,'Network Threat','THR-NET','Threat through network','Network','Reconnaissance','Network scanning','Network infrastructure','External Attacker','Information gathering','Medium','Medium','IDS/IPS and firewall logs','Firewall rules and network segmentation','Internal SIEM','Frequent','Active','2020-01-15','2026-06-01','Includes port scans and probing'),
(2,'Malware Threat','THR-MAL','Threat caused by malware','Malware','Trojan / Ransomware','Email attachment','Endpoints','Cybercriminal Group','Financial gain','Critical','High','EDR and antivirus','Patch systems and use endpoint protection','Threat intelligence feed','Occasional','Active','2020-01-15','2026-06-01','Includes trojans, ransomware and spyware'),
(3,'Account Threat','THR-ACC','Threat related to accounts','Identity','Credential Abuse','Password guessing','User accounts','External Attacker','Unauthorized access','High','High','Authentication log analysis','Enable MFA and account lockout','SIEM correlation','Frequent','Active','2020-01-15','2026-06-01','Includes brute force and suspicious logins'),
(4,'Web Threat','THR-WEB','Threat through web services','Web','Web Application Attack','HTTP/HTTPS requests','Web servers','Hacktivist','Disruption or data theft','High','Medium','WAF logs','Use WAF and input validation','OWASP and WAF feed','Occasional','Active','2020-01-15','2026-06-01','Includes injection and XSS attempts');

INSERT INTO threats (
    threat_id,
    threat_name, threat_code, threat_type_id, threat_source,
    threat_level, risk_score, first_detected, last_detected,
    detection_count, affected_assets, affected_users, attack_vector,
    target_system, threat_actor, geographic_origin, status,
    mitigation_status, description, created_date
) VALUES
(1,'Brute Force Activity','THR-001',3,'45.33.12.20','High',78,'2026-09-01','2026-09-14',150,1,1,'Password guessing over SSH','IT-PC-01','External Attacker','United States','Active','In Progress','Repeated login attempts','2026-09-01'),
(2,'Trojan Activity','THR-002',2,'103.45.67.89','Critical',92,'2026-09-03','2026-09-14',12,2,2,'Malicious email attachment','IT-PC-02','Cybercriminal Group','India','Active','Under Investigation','Possible trojan detected','2026-09-03'),
(3,'Port Scanning','THR-003',1,'185.22.33.44','Medium',55,'2026-09-05','2026-09-14',400,3,0,'TCP SYN scan','FIN-PC-01','Unknown','Russia','Monitoring','Blocked at Firewall','Multiple ports scanned','2026-09-05'),
(4,'Suspicious Login','THR-004',3,'103.45.67.89','High',70,'2026-09-06','2026-09-14',5,1,1,'Compromised credentials','HR-PC-01','Unknown','India','Resolved','Mitigated','Unusual account login','2026-09-06');

INSERT INTO malware (
    malware_id,
    malware_name, malware_family, malware_type, version,
    threat_id, severity_id, hash_md5, hash_sha1,
    hash_sha256, file_name, file_size, file_type,
    first_seen, last_seen, source, infection_method,
    target_platform, status, description
) VALUES
(1,'TestTrojan','Generic Trojan','Trojan','1.2',2,4,'9a235e5f19529117e9aae3590f41b900','692c6967fca9d602e07540ca921729cc11bb788c','2df75f10202afe689aac918303fb10ca9e77f100dab6b79b00509e9a5797a805','invoice_update.exe',245760,'Executable (PE)','2026-09-03','2026-09-14','Email attachment','Phishing email attachment','Windows','Active','Trojan activity detected'),
(2,'DemoRansom','Demo Ransomware','Ransomware','2.1',2,4,'f51911882310a65f196aea65b4c99de1','9dcdbb1969b5454f7cea9bf3b8602f1e164dff8e','7564d00db58dff1c920e2433364ff4af498ed364962bc81272733518af6bf89f','document_locker.exe',512000,'Executable (PE)','2026-09-05','2026-09-13','Malicious download','Drive-by download','Windows','Quarantined','Ransomware behavior detected'),
(3,'FakeUpdater','Fake Updater','Spyware','1.0',2,3,'4e26736c191464f2cd3a6ed19eed1035','cd792bd5a1dff49701fbf63970444e31efa1186c','6da713142ffd2b959004358f26b9e67394db2b38d714ea95bdbe86c366c17ebd','update_installer.msi',1048576,'MSI Installer','2026-09-08','2026-09-14','Fake software update','Social engineering','Windows','Under Analysis','Suspicious updater detected');

INSERT INTO vulnerabilities (
    vulnerability_id,
    vulnerability_name, vulnerability_code, cve_number, severity_id,
    vulnerability_type, affected_product, affected_version, fixed_version,
    discovered_date, published_date, last_modified_date, cvss_score,
    exploit_available, exploitability, patch_available, remediation,
    reference_url, status, description
) VALUES
(1,'Web Server Vulnerability','VUL-001','CVE-2025-10001',3,'Software Vulnerability','Apache HTTP Server','Ubuntu 22.04','Ubuntu 24.04','2026-08-01','2026-08-03','2026-08-10',7.8,1,'Functional',1,'Upgrade web server packages and apply the latest security patches','https://nvd.nist.gov/vuln/detail/CVE-2025-10001','Open','Web service vulnerability'),
(2,'Database Vulnerability','VUL-002','CVE-2025-10002',4,'Software Vulnerability','Database Server','Red Hat 8','Red Hat 9','2026-08-05','2026-08-07','2026-08-12',9.8,1,'High',1,'Upgrade the database server and restrict network access','https://nvd.nist.gov/vuln/detail/CVE-2025-10002','Open','Database security issue'),
(3,'Windows Vulnerability','VUL-003','CVE-2025-10003',2,'Configuration Vulnerability','Windows Operating System','Windows 11','Windows 11 latest cumulative update','2026-08-10','2026-08-12','2026-08-18',5.5,0,'Low',1,'Install the latest Windows cumulative update','https://nvd.nist.gov/vuln/detail/CVE-2025-10003','Patched','Windows security issue');

INSERT INTO vulnerability_types (
    vulnerability_type_id,
    vulnerability_type_name, vulnerability_code, description, category,
    subcategory, attack_vector, attack_complexity, privilege_required,
    user_interaction_required, confidentiality_impact, integrity_impact, availability_impact,
    common_target, detection_method, mitigation_method, example_cve,
    risk_level, status, notes
) VALUES
(1,'Software Vulnerability','VT-SOFT','Software related issue','Software','Application Flaw','Network','Low','None',0,'High','High','High','Applications','Vulnerability scanning','Apply patches and updates','CVE-2025-10001','High','Active','Covers bugs in applications and services'),
(2,'Network Vulnerability','VT-NET','Network related issue','Network','Protocol Weakness','Network','Medium','None',0,'Medium','Low','High','Routers and firewalls','Network scanning','Segment the network and harden firewalls','CVE-2025-10002','Medium','Active','Covers weaknesses in network protocols and devices'),
(3,'Configuration Vulnerability','VT-CFG','Incorrect configuration','Configuration','Misconfiguration','Local','Low','Low',0,'High','Medium','Medium','Servers and endpoints','Configuration audit','Apply CIS hardening baselines','CVE-2025-10003','Medium','Active','Covers insecure default or incorrect settings');

INSERT INTO security_alerts (
    alert_id,
    alert_name, alert_code, alert_type_id, severity_id,
    device_id, ip_id, analyst_id, alert_time,
    detection_time, alert_status, source_system, source_rule,
    event_count, risk_score, source_ip, destination_ip,
    protocol, description, resolution_notes
) VALUES
(1,'Multiple Failed Logins','ALR-001',1,3,1,4,1,'2026-09-14 08:30:00','2026-09-14 08:32:00','Open','SIEM','Failed login threshold rule',45,78,'45.33.12.20','192.168.1.10','SSH','Multiple failed login attempts','Pending investigation'),
(2,'Malware Detected','ALR-002',2,4,2,5,2,'2026-09-14 09:10:00','2026-09-14 09:12:00','Investigating','EDR','Trojan signature detected',3,92,'103.45.67.89','192.168.1.11','HTTPS','Malware detected on device','Device isolated, analysis in progress'),
(3,'Port Scan Detected','ALR-003',3,2,3,6,1,'2026-09-14 10:20:00','2026-09-14 10:22:00','Open','IDS','Horizontal port scan rule',250,55,'185.22.33.44','192.168.2.10','TCP','Port scanning activity','Source IP being reviewed for blocking'),
(4,'Unusual Login','ALR-004',4,3,5,5,3,'2026-09-14 11:30:00','2026-09-14 11:32:00','Resolved','Identity Provider','Impossible travel rule',2,70,'103.45.67.89','192.168.3.10','HTTPS','Unusual login location','Verified with user, password reset and MFA enforced'),
(5,'Large Data Transfer','ALR-005',5,2,4,4,2,'2026-09-14 12:00:00','2026-09-14 12:02:00','Open','DLP','Outbound volume threshold',1,50,'192.168.4.10','45.33.12.20','FTP','Unusual data transfer','Transfer logs under review');

INSERT INTO incidents (
    incident_id,
    incident_title, incident_code, incident_type_id, severity_id,
    status_id, alert_id, reported_by, assigned_analyst,
    created_time, detected_time, acknowledged_time, contained_time,
    resolved_time, closed_time, affected_device_count, affected_user_count,
    root_cause, description, resolution_notes
) VALUES
(1,'Brute Force Attack','INC-2026-001',1,3,1,1,1,1,'2026-09-14 08:35:00','2026-09-14 08:32:00','2026-09-14 08:40:00',NULL,NULL,NULL,1,1,'Weak or guessable credentials exposed to the internet','Multiple failed login attempts','Source IP being blocked and account monitored'),
(2,'Malware Infection','INC-2026-002',2,4,2,2,2,2,'2026-09-14 09:15:00','2026-09-14 09:12:00','2026-09-14 09:20:00',NULL,NULL,NULL,2,2,'Malicious email attachment opened by user','Possible malware infection','Device isolated, full scan and analysis in progress'),
(3,'Network Port Scan','INC-2026-003',4,2,1,3,3,1,'2026-09-14 10:25:00','2026-09-14 10:22:00','2026-09-14 10:30:00',NULL,NULL,NULL,3,0,'Exposed services probed by external host','External port scanning','Source IP queued for firewall block'),
(4,'Suspicious Login','INC-2026-004',5,3,4,4,4,3,'2026-09-14 11:35:00','2026-09-14 11:32:00','2026-09-14 11:40:00','2026-09-14 12:30:00','2026-09-14 14:30:00','2026-09-14 15:00:00',1,1,'Credentials reused on an external site','Suspicious account login','Password reset, MFA enforced and login history reviewed'),
(5,'Data Transfer Alert','INC-2026-005',4,2,1,5,5,2,'2026-09-14 12:05:00','2026-09-14 12:02:00','2026-09-14 12:10:00',NULL,NULL,NULL,1,1,'Large outbound transfer from SOC workstation, cause under review','Large data transfer','Transfer logs under review');
SELECT * FROM departments;
SELECT department_id FROM departments;
SELECT DISTINCT department_id FROM departments;
SELECT department_id, COUNT(*) AS total FROM departments GROUP BY department_id;
SELECT department_id, COUNT(*) AS total FROM departments GROUP BY department_id ORDER BY total DESC;
SELECT * FROM departments WHERE department_id IS NOT NULL;
SELECT * FROM departments WHERE department_id IS NULL;
SELECT TOP (10) * FROM departments ORDER BY department_id ASC;
SELECT TOP (10) * FROM departments ORDER BY department_id DESC;
SELECT COUNT(department_id) AS total_values FROM departments;
SELECT COUNT(DISTINCT department_id) AS unique_values FROM departments;
SELECT department_name FROM departments;
SELECT DISTINCT department_name FROM departments;
SELECT department_name, COUNT(*) AS total FROM departments GROUP BY department_name;
SELECT department_name, COUNT(*) AS total FROM departments GROUP BY department_name ORDER BY total DESC;
SELECT * FROM departments WHERE department_name IS NOT NULL;
SELECT * FROM departments WHERE department_name IS NULL;
SELECT TOP (10) * FROM departments ORDER BY department_name ASC;
SELECT TOP (10) * FROM departments ORDER BY department_name DESC;
SELECT COUNT(department_name) AS total_values FROM departments;
SELECT COUNT(DISTINCT department_name) AS unique_values FROM departments;
SELECT location FROM departments;
SELECT DISTINCT location FROM departments;
SELECT location, COUNT(*) AS total FROM departments GROUP BY location;
SELECT location, COUNT(*) AS total FROM departments GROUP BY location ORDER BY total DESC;
SELECT * FROM departments WHERE location IS NOT NULL;
SELECT * FROM departments WHERE location IS NULL;
SELECT TOP (10) * FROM departments ORDER BY location ASC;
SELECT TOP (10) * FROM departments ORDER BY location DESC;
SELECT COUNT(location) AS total_values FROM departments;
SELECT COUNT(DISTINCT location) AS unique_values FROM departments;
SELECT manager_name FROM departments;
SELECT DISTINCT manager_name FROM departments;
SELECT manager_name, COUNT(*) AS total FROM departments GROUP BY manager_name;
SELECT manager_name, COUNT(*) AS total FROM departments GROUP BY manager_name ORDER BY total DESC;
SELECT * FROM departments WHERE manager_name IS NOT NULL;
SELECT * FROM departments WHERE manager_name IS NULL;
SELECT TOP (10) * FROM departments ORDER BY manager_name ASC;
SELECT TOP (10) * FROM departments ORDER BY manager_name DESC;
SELECT COUNT(manager_name) AS total_values FROM departments;
SELECT COUNT(DISTINCT manager_name) AS unique_values FROM departments;
SELECT * FROM roles;
SELECT role_id FROM roles;
SELECT DISTINCT role_id FROM roles;
SELECT role_id, COUNT(*) AS total FROM roles GROUP BY role_id;
SELECT role_id, COUNT(*) AS total FROM roles GROUP BY role_id ORDER BY total DESC;
SELECT * FROM roles WHERE role_id IS NOT NULL;
SELECT * FROM roles WHERE role_id IS NULL;
SELECT TOP (10) * FROM roles ORDER BY role_id ASC;
SELECT TOP (10) * FROM roles ORDER BY role_id DESC;
SELECT COUNT(role_id) AS total_values FROM roles;
SELECT COUNT(DISTINCT role_id) AS unique_values FROM roles;
SELECT role_name FROM roles;
SELECT DISTINCT role_name FROM roles;
SELECT role_name, COUNT(*) AS total FROM roles GROUP BY role_name;
SELECT role_name, COUNT(*) AS total FROM roles GROUP BY role_name ORDER BY total DESC;
SELECT * FROM roles WHERE role_name IS NOT NULL;
SELECT * FROM roles WHERE role_name IS NULL;
SELECT TOP (10) * FROM roles ORDER BY role_name ASC;
SELECT TOP (10) * FROM roles ORDER BY role_name DESC;
SELECT COUNT(role_name) AS total_values FROM roles;
SELECT COUNT(DISTINCT role_name) AS unique_values FROM roles;
SELECT description FROM roles;
SELECT DISTINCT description FROM roles;
SELECT description, COUNT(*) AS total FROM roles GROUP BY description;
SELECT description, COUNT(*) AS total FROM roles GROUP BY description ORDER BY total DESC;
SELECT * FROM roles WHERE description IS NOT NULL;
SELECT * FROM roles WHERE description IS NULL;
SELECT TOP (10) * FROM roles ORDER BY description ASC;
SELECT TOP (10) * FROM roles ORDER BY description DESC;
SELECT COUNT(description) AS total_values FROM roles;
SELECT COUNT(DISTINCT description) AS unique_values FROM roles;
SELECT * FROM employees;
SELECT employee_id FROM employees;
SELECT DISTINCT employee_id FROM employees;
SELECT employee_id, COUNT(*) AS total FROM employees GROUP BY employee_id;
SELECT employee_id, COUNT(*) AS total FROM employees GROUP BY employee_id ORDER BY total DESC;
SELECT * FROM employees WHERE employee_id IS NOT NULL;
SELECT * FROM employees WHERE employee_id IS NULL;
SELECT TOP (10) * FROM employees ORDER BY employee_id ASC;
SELECT TOP (10) * FROM employees ORDER BY employee_id DESC;
SELECT COUNT(employee_id) AS total_values FROM employees;
SELECT COUNT(DISTINCT employee_id) AS unique_values FROM employees;
SELECT employee_name FROM employees;
SELECT DISTINCT employee_name FROM employees;
SELECT employee_name, COUNT(*) AS total FROM employees GROUP BY employee_name;
SELECT employee_name, COUNT(*) AS total FROM employees GROUP BY employee_name ORDER BY total DESC;
SELECT * FROM employees WHERE employee_name IS NOT NULL;
SELECT * FROM employees WHERE employee_name IS NULL;
SELECT TOP (10) * FROM employees ORDER BY employee_name ASC;
SELECT TOP (10) * FROM employees ORDER BY employee_name DESC;
SELECT COUNT(employee_name) AS total_values FROM employees;
SELECT COUNT(DISTINCT employee_name) AS unique_values FROM employees;
SELECT email FROM employees;
SELECT DISTINCT email FROM employees;
SELECT email, COUNT(*) AS total FROM employees GROUP BY email;
SELECT email, COUNT(*) AS total FROM employees GROUP BY email ORDER BY total DESC;
SELECT * FROM employees WHERE email IS NOT NULL;
SELECT * FROM employees WHERE email IS NULL;
SELECT TOP (10) * FROM employees ORDER BY email ASC;
SELECT TOP (10) * FROM employees ORDER BY email DESC;
SELECT COUNT(email) AS total_values FROM employees;
SELECT COUNT(DISTINCT email) AS unique_values FROM employees;
SELECT phone FROM employees;
SELECT DISTINCT phone FROM employees;
SELECT phone, COUNT(*) AS total FROM employees GROUP BY phone;
SELECT phone, COUNT(*) AS total FROM employees GROUP BY phone ORDER BY total DESC;
SELECT * FROM employees WHERE phone IS NOT NULL;
SELECT * FROM employees WHERE phone IS NULL;
SELECT TOP (10) * FROM employees ORDER BY phone ASC;
SELECT TOP (10) * FROM employees ORDER BY phone DESC;
SELECT COUNT(phone) AS total_values FROM employees;
SELECT COUNT(DISTINCT phone) AS unique_values FROM employees;
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees;
SELECT department_id, COUNT(*) AS total FROM employees GROUP BY department_id;
SELECT department_id, COUNT(*) AS total FROM employees GROUP BY department_id ORDER BY total DESC;
SELECT * FROM employees WHERE department_id IS NOT NULL;
SELECT * FROM employees WHERE department_id IS NULL;
SELECT TOP (10) * FROM employees ORDER BY department_id ASC;
SELECT TOP (10) * FROM employees ORDER BY department_id DESC;
SELECT COUNT(department_id) AS total_values FROM employees;
SELECT COUNT(DISTINCT department_id) AS unique_values FROM employees;
SELECT role_id FROM employees;
SELECT DISTINCT role_id FROM employees;
SELECT role_id, COUNT(*) AS total FROM employees GROUP BY role_id;
SELECT role_id, COUNT(*) AS total FROM employees GROUP BY role_id ORDER BY total DESC;
SELECT * FROM employees WHERE role_id IS NOT NULL;
SELECT * FROM employees WHERE role_id IS NULL;
SELECT TOP (10) * FROM employees ORDER BY role_id ASC;
SELECT TOP (10) * FROM employees ORDER BY role_id DESC;
SELECT COUNT(role_id) AS total_values FROM employees;
SELECT COUNT(DISTINCT role_id) AS unique_values FROM employees;
SELECT joining_date FROM employees;
SELECT DISTINCT joining_date FROM employees;
SELECT joining_date, COUNT(*) AS total FROM employees GROUP BY joining_date;
SELECT joining_date, COUNT(*) AS total FROM employees GROUP BY joining_date ORDER BY total DESC;
SELECT * FROM employees WHERE joining_date IS NOT NULL;
SELECT * FROM employees WHERE joining_date IS NULL;
SELECT TOP (10) * FROM employees ORDER BY joining_date ASC;
SELECT TOP (10) * FROM employees ORDER BY joining_date DESC;
SELECT COUNT(joining_date) AS total_values FROM employees;
SELECT COUNT(DISTINCT joining_date) AS unique_values FROM employees;
SELECT status FROM employees;
SELECT DISTINCT status FROM employees;
SELECT status, COUNT(*) AS total FROM employees GROUP BY status;
SELECT status, COUNT(*) AS total FROM employees GROUP BY status ORDER BY total DESC;
SELECT * FROM employees WHERE status IS NOT NULL;
SELECT * FROM employees WHERE status IS NULL;
SELECT TOP (10) * FROM employees ORDER BY status ASC;
SELECT TOP (10) * FROM employees ORDER BY status DESC;
SELECT COUNT(status) AS total_values FROM employees;
SELECT COUNT(DISTINCT status) AS unique_values FROM employees;
SELECT * FROM users;
SELECT user_id FROM users;
SELECT DISTINCT user_id FROM users;
SELECT user_id, COUNT(*) AS total FROM users GROUP BY user_id;
SELECT user_id, COUNT(*) AS total FROM users GROUP BY user_id ORDER BY total DESC;
SELECT * FROM users WHERE user_id IS NOT NULL;
SELECT * FROM users WHERE user_id IS NULL;
SELECT TOP (10) * FROM users ORDER BY user_id ASC;
SELECT TOP (10) * FROM users ORDER BY user_id DESC;
SELECT COUNT(user_id) AS total_values FROM users;
SELECT COUNT(DISTINCT user_id) AS unique_values FROM users;
SELECT employee_id FROM users;
SELECT DISTINCT employee_id FROM users;
SELECT employee_id, COUNT(*) AS total FROM users GROUP BY employee_id;
SELECT employee_id, COUNT(*) AS total FROM users GROUP BY employee_id ORDER BY total DESC;
SELECT * FROM users WHERE employee_id IS NOT NULL;
SELECT * FROM users WHERE employee_id IS NULL;
SELECT TOP (10) * FROM users ORDER BY employee_id ASC;
SELECT TOP (10) * FROM users ORDER BY employee_id DESC;
SELECT COUNT(employee_id) AS total_values FROM users;
SELECT COUNT(DISTINCT employee_id) AS unique_values FROM users;
SELECT username FROM users;
SELECT DISTINCT username FROM users;
SELECT username, COUNT(*) AS total FROM users GROUP BY username;
SELECT username, COUNT(*) AS total FROM users GROUP BY username ORDER BY total DESC;
SELECT * FROM users WHERE username IS NOT NULL;
SELECT * FROM users WHERE username IS NULL;
SELECT TOP (10) * FROM users ORDER BY username ASC;
SELECT TOP (10) * FROM users ORDER BY username DESC;
SELECT COUNT(username) AS total_values FROM users;
SELECT COUNT(DISTINCT username) AS unique_values FROM users;
SELECT password_status FROM users;
SELECT DISTINCT password_status FROM users;
SELECT password_status, COUNT(*) AS total FROM users GROUP BY password_status;
SELECT password_status, COUNT(*) AS total FROM users GROUP BY password_status ORDER BY total DESC;
SELECT * FROM users WHERE password_status IS NOT NULL;
SELECT * FROM users WHERE password_status IS NULL;
SELECT TOP (10) * FROM users ORDER BY password_status ASC;
SELECT TOP (10) * FROM users ORDER BY password_status DESC;
SELECT COUNT(password_status) AS total_values FROM users;
SELECT COUNT(DISTINCT password_status) AS unique_values FROM users;
SELECT account_status FROM users;
SELECT DISTINCT account_status FROM users;
SELECT account_status, COUNT(*) AS total FROM users GROUP BY account_status;
SELECT account_status, COUNT(*) AS total FROM users GROUP BY account_status ORDER BY total DESC;
SELECT * FROM users WHERE account_status IS NOT NULL;
SELECT * FROM users WHERE account_status IS NULL;
SELECT TOP (10) * FROM users ORDER BY account_status ASC;
SELECT TOP (10) * FROM users ORDER BY account_status DESC;
SELECT COUNT(account_status) AS total_values FROM users;
SELECT COUNT(DISTINCT account_status) AS unique_values FROM users;
SELECT last_login FROM users;
SELECT DISTINCT last_login FROM users;
SELECT last_login, COUNT(*) AS total FROM users GROUP BY last_login;
SELECT last_login, COUNT(*) AS total FROM users GROUP BY last_login ORDER BY total DESC;
SELECT * FROM users WHERE last_login IS NOT NULL;
SELECT * FROM users WHERE last_login IS NULL;
SELECT TOP (10) * FROM users ORDER BY last_login ASC;
SELECT TOP (10) * FROM users ORDER BY last_login DESC;
SELECT COUNT(last_login) AS total_values FROM users;
SELECT COUNT(DISTINCT last_login) AS unique_values FROM users;
SELECT * FROM soc_analysts;
SELECT analyst_id FROM soc_analysts;
SELECT DISTINCT analyst_id FROM soc_analysts;
SELECT analyst_id, COUNT(*) AS total FROM soc_analysts GROUP BY analyst_id;
SELECT analyst_id, COUNT(*) AS total FROM soc_analysts GROUP BY analyst_id ORDER BY total DESC;
SELECT * FROM soc_analysts WHERE analyst_id IS NOT NULL;
SELECT * FROM soc_analysts WHERE analyst_id IS NULL;
SELECT TOP (10) * FROM soc_analysts ORDER BY analyst_id ASC;
SELECT TOP (10) * FROM soc_analysts ORDER BY analyst_id DESC;
SELECT COUNT(analyst_id) AS total_values FROM soc_analysts;
SELECT COUNT(DISTINCT analyst_id) AS unique_values FROM soc_analysts;
SELECT employee_id FROM soc_analysts;
SELECT DISTINCT employee_id FROM soc_analysts;
SELECT employee_id, COUNT(*) AS total FROM soc_analysts GROUP BY employee_id;
SELECT employee_id, COUNT(*) AS total FROM soc_analysts GROUP BY employee_id ORDER BY total DESC;
SELECT * FROM soc_analysts WHERE employee_id IS NOT NULL;
SELECT * FROM soc_analysts WHERE employee_id IS NULL;
SELECT TOP (10) * FROM soc_analysts ORDER BY employee_id ASC;
SELECT TOP (10) * FROM soc_analysts ORDER BY employee_id DESC;
SELECT COUNT(employee_id) AS total_values FROM soc_analysts;
SELECT COUNT(DISTINCT employee_id) AS unique_values FROM soc_analysts;
SELECT analyst_level FROM soc_analysts;
SELECT DISTINCT analyst_level FROM soc_analysts;
SELECT analyst_level, COUNT(*) AS total FROM soc_analysts GROUP BY analyst_level;
SELECT analyst_level, COUNT(*) AS total FROM soc_analysts GROUP BY analyst_level ORDER BY total DESC;
SELECT * FROM soc_analysts WHERE analyst_level IS NOT NULL;
SELECT * FROM soc_analysts WHERE analyst_level IS NULL;
SELECT TOP (10) * FROM soc_analysts ORDER BY analyst_level ASC;
SELECT TOP (10) * FROM soc_analysts ORDER BY analyst_level DESC;
SELECT COUNT(analyst_level) AS total_values FROM soc_analysts;
SELECT COUNT(DISTINCT analyst_level) AS unique_values FROM soc_analysts;
SELECT shift_name FROM soc_analysts;
SELECT DISTINCT shift_name FROM soc_analysts;
SELECT shift_name, COUNT(*) AS total FROM soc_analysts GROUP BY shift_name;
SELECT shift_name, COUNT(*) AS total FROM soc_analysts GROUP BY shift_name ORDER BY total DESC;
SELECT * FROM soc_analysts WHERE shift_name IS NOT NULL;
SELECT * FROM soc_analysts WHERE shift_name IS NULL;
SELECT TOP (10) * FROM soc_analysts ORDER BY shift_name ASC;
SELECT TOP (10) * FROM soc_analysts ORDER BY shift_name DESC;
SELECT COUNT(shift_name) AS total_values FROM soc_analysts;
SELECT COUNT(DISTINCT shift_name) AS unique_values FROM soc_analysts;
SELECT experience_years FROM soc_analysts;
SELECT DISTINCT experience_years FROM soc_analysts;
SELECT experience_years, COUNT(*) AS total FROM soc_analysts GROUP BY experience_years;
SELECT experience_years, COUNT(*) AS total FROM soc_analysts GROUP BY experience_years ORDER BY total DESC;
SELECT * FROM soc_analysts WHERE experience_years IS NOT NULL;
SELECT * FROM soc_analysts WHERE experience_years IS NULL;
SELECT TOP (10) * FROM soc_analysts ORDER BY experience_years ASC;
SELECT TOP (10) * FROM soc_analysts ORDER BY experience_years DESC;
SELECT COUNT(experience_years) AS total_values FROM soc_analysts;
SELECT COUNT(DISTINCT experience_years) AS unique_values FROM soc_analysts;
SELECT certification FROM soc_analysts;
SELECT DISTINCT certification FROM soc_analysts;
SELECT certification, COUNT(*) AS total FROM soc_analysts GROUP BY certification;
SELECT certification, COUNT(*) AS total FROM soc_analysts GROUP BY certification ORDER BY total DESC;
SELECT * FROM soc_analysts WHERE certification IS NOT NULL;
SELECT * FROM soc_analysts WHERE certification IS NULL;
SELECT TOP (10) * FROM soc_analysts ORDER BY certification ASC;
SELECT TOP (10) * FROM soc_analysts ORDER BY certification DESC;
SELECT COUNT(certification) AS total_values FROM soc_analysts;
SELECT COUNT(DISTINCT certification) AS unique_values FROM soc_analysts;
SELECT * FROM operating_systems;
SELECT os_id FROM operating_systems;
SELECT DISTINCT os_id FROM operating_systems;
SELECT os_id, COUNT(*) AS total FROM operating_systems GROUP BY os_id;
SELECT os_id, COUNT(*) AS total FROM operating_systems GROUP BY os_id ORDER BY total DESC;
SELECT * FROM operating_systems WHERE os_id IS NOT NULL;
SELECT * FROM operating_systems WHERE os_id IS NULL;
SELECT TOP (10) * FROM operating_systems ORDER BY os_id ASC;
SELECT TOP (10) * FROM operating_systems ORDER BY os_id DESC;
SELECT COUNT(os_id) AS total_values FROM operating_systems;
SELECT COUNT(DISTINCT os_id) AS unique_values FROM operating_systems;
SELECT os_name FROM operating_systems;
SELECT DISTINCT os_name FROM operating_systems;
SELECT os_name, COUNT(*) AS total FROM operating_systems GROUP BY os_name;
SELECT os_name, COUNT(*) AS total FROM operating_systems GROUP BY os_name ORDER BY total DESC;
SELECT * FROM operating_systems WHERE os_name IS NOT NULL;
SELECT * FROM operating_systems WHERE os_name IS NULL;
SELECT TOP (10) * FROM operating_systems ORDER BY os_name ASC;
SELECT TOP (10) * FROM operating_systems ORDER BY os_name DESC;
SELECT COUNT(os_name) AS total_values FROM operating_systems;
SELECT COUNT(DISTINCT os_name) AS unique_values FROM operating_systems;
SELECT version FROM operating_systems;
SELECT DISTINCT version FROM operating_systems;