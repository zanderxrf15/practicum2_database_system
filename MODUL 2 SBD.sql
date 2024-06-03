CREATE TABLE Customer (
    ID_customer CHAR(6) PRIMARY KEY,
    Nama_customer VARCHAR(100)
);

SELECT * FROM Customer;

CREATE TABLE Pegawai (
    NIK CHAR(16) PRIMARY KEY,
    Nama_pegawai VARCHAR(100),
    Jenis_kelamin CHAR(1),
    Email VARCHAR(50),
    Umur INT
);

SELECT * FROM Pegawai;

CREATE TABLE Telepon (
    No_telp_pegawai VARCHAR(15) PRIMARY KEY,
    Pegawai_NIK CHAR(16),
    FOREIGN KEY (Pegawai_NIK) REFERENCES Pegawai(NIK)
);

SELECT * FROM Telepon;

CREATE TABLE Menu_minuman (
    ID_minuman CHAR(6) PRIMARY KEY,
    Nama_minuman VARCHAR(50),
    Harga_minuman FLOAT
);

SELECT * FROM Menu_minuman;

CREATE TABLE Transaksi (
    ID_transaksi CHAR(10) PRIMARY KEY,
    Tanggal_transaksi DATE,
    Metode_pembayaran VARCHAR(15),
    Customer_ID_customer CHAR(6),
    Pegawai_NIK CHAR(16),
    FOREIGN KEY (Customer_ID_customer) REFERENCES Customer(ID_customer),
    FOREIGN KEY (Pegawai_NIK) REFERENCES Pegawai(NIK)
);

SELECT * FROM Transaksi;

CREATE TABLE Transaksi_minuman (
    TM_Menu_minuman_ID CHAR(6),
    TM_Transaksi_ID CHAR(10),
    Jumlah_cup INT,
    PRIMARY KEY (TM_Menu_minuman_ID, TM_Transaksi_ID),
    FOREIGN KEY (TM_Menu_minuman_ID) REFERENCES Menu_minuman(ID_minuman),
    FOREIGN KEY (TM_Transaksi_ID) REFERENCES Transaksi(ID_transaksi)
);

SELECT * FROM Transaksi_minuman;

CREATE TABLE Membership (
    id_membership CHAR(6) PRIMARY KEY,
    no_telepon_customer VARCHAR(15),
    alamat_customer VARCHAR(100),
    tanggal_pembuatan_kartu_membership DATE DEFAULT CURRENT_DATE,
    tanggal_kedaluawarsa_kartu_membership DATE,
    total_poin INT CHECK (total_poin >= 0),
    customer_id_customer CHAR(6),
    FOREIGN KEY (customer_id_customer) REFERENCES Customer(ID_customer) ON UPDATE CASCADE ON DELETE RESTRICT
);

ALTER TABLE Transaksi
ADD FOREIGN KEY (Customer_ID_customer) REFERENCES Membership(customer_id_customer) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Membership
ALTER COLUMN alamat_customer TYPE VARCHAR(150);

SELECT * FROM Membership;

ALTER TABLE Pegawai 
ADD COLUMN No_telepon VARCHAR(15);

DROP TABLE Telepon;

INSERT INTO Customer (id_customer, nama_customer) 
VALUES 
('CTR001', 'Budi Santoso'),
('CTR002', 'Sisil Triana'),
('CTR003', 'Davi Liam'),
('CTRo04', 'Sutris Ten An'),
('CTR005', 'Hendra Asto');

INSERT INTO Membership (id_membership, no_telepon_customer, alamat_customer, tanggal_pembuatan_kartu_membership, tanggal_kedaluawarsa_kartu_membership, total_poin, customer_id_customer) 
VALUES 
('MBR001', '08123456789', 'Jl. Imam Bonjol', '24 October 2023', '30 November 2023', 0, 'CTR001'),
('MBR002', '0812345678', 'Jl. Kelinci', '24 October 2023', '30 November 2023', 3, 'CTR002'),
('MBR003', '081234567890', 'Jl. Abah Ojak', '25 October 2023', '1 December 2023', 2, 'CTR003'),
('MBR004', '08987654321', 'Jl. Kenangan', '26 October 2023', '2 December 2023', 6, 'CTR005');

INSERT INTO Pegawai (NIK, Nama_pegawai, Jenis_kelamin, Email, Umur, No_telepon) 
VALUES 
('1234567890123456', 'Naufal Raf', 'Laki-Laki', 'nuafal@gmail.com', 19, '62123456789'),
('2345678901234561', 'Surinala', 'Perempuan', 'surinala@gmail.com', 24, '621234567890'),
('3456789012345612', 'Ben John', 'Laki-Laki', 'benjohn@gmail.com', 22, '6212345678');

ALTER TABLE Pegawai 
ALTER COLUMN Jenis_kelamin TYPE VARCHAR(10);

INSERT INTO Transaksi (ID_transaksi, Tanggal_transaksi, Metode_pembayaran, Pegawai_NIK, Customer_ID_customer) 
VALUES 
('TRX0000001', '2023-10-01', 'Kartu kredit', '2345678901234561', 'CTR002'),
('TRX0000002', '2023-10-03', 'Transfer bank', '3456789012345612', 'CTRo04'),
('TRX0000003', '2023-10-05', 'Tunai', '3456789012345612', 'CTR001'),
('TRX0000004', '2023-10-15', 'Kartu debit', '1234567890123456', 'CTR003'),
('TRX0000005', '2023-10-15', 'E-wallet', '1234567890123456', 'CTRo04'),
('TRX0000006', '2023-10-21', 'Tunai', '2345678901234561', 'CTR001');
 
INSERT INTO Menu_minuman (ID_minuman, Nama_minuman, Harga_minuman) 
VALUES 
('MNM001', 'Expresso', 18000),
('MNM002', 'Cappuccino', 20000),
('MNM003', 'Latte', 21000),
('MNM004', 'Americano', 19000),
('MNM005', 'Mocha', 22000),
('MNM006', 'Macchiato', 23000),
('MNM007', 'Cold Brew', 21000),
('MNM008', 'Iced Coffee', 18000),
('MNM009', 'Affogato', 23000),
('MNM010', 'Coffee Frappe', 22000);

INSERT INTO Transaksi_minuman (TM_Transaksi_ID, TM_Menu_minuman_ID, Jumlah_cup) 
VALUES 
('TRX0000005', 'MNM006', 2),
('TRX0000001', 'MNM010', 1),
('TRX0000002', 'MNM005', 1),
('TRX0000005', 'MNM009', 1),
('TRX0000003', 'MNM001', 3),
('TRX0000006', 'MNM003', 2),
('TRX0000004', 'MNM004', 2),
('TRX0000004', 'MNM010', 1),
('TRX0000002', 'MNM003', 2),
('TRX0000001', 'MNM007', 1),
('TRX0000005', 'MNM001', 1),
('TRX0000003', 'MNM003', 1);

INSERT INTO Transaksi (ID_transaksi, Tanggal_transaksi, Metode_pembayaran, Pegawai_NIK, Customer_ID_customer) 
VALUES ('TRX0000007', '2023-10-03', 'Transfer bank', '2345678901234561', 'CTRo04');

INSERT INTO Transaksi_minuman (TM_Transaksi_ID, TM_Menu_minuman_ID, Jumlah_cup) 
VALUES ('TRX0000007', 'MNM005', 1);

INSERT INTO Pegawai (NIK, Nama_pegawai, Jenis_kelamin, Email, Umur, No_telepon) 
VALUES ('1111222233334444', 'Maimunah', NULL, NULL, 25, NULL);

UPDATE Pegawai
SET Jenis_kelamin = 'Perempuan', Email = 'maimunah@gmail.com', No_telepon = '621234567'
WHERE Nama_pegawai = 'Maimunah';

UPDATE Membership
SET total_poin = 0
WHERE tanggal_kedaluawarsa_kartu_membership < '2023-12-01';

DELETE FROM Membership;

DELETE FROM Pegawai
WHERE Nama_pegawai = 'Maimunah';





