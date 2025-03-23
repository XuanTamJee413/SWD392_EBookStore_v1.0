CREATE DATABASE EBookStore;
GO

USE EBookStore;
GO
-- Tạo bảng UserRole
CREATE TABLE UserRole (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL
);
GO

-- Tạo bảng Users
CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber NVARCHAR(15) NOT NULL,
    Address NVARCHAR(255),
    Password NVARCHAR(255) NOT NULL,
    RoleId INT NOT NULL,
    FOREIGN KEY (RoleId) REFERENCES UserRole(Id)
);
GO

-- Tạo bảng Categories
CREATE TABLE Categories (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL
);
GO

-- Tạo bảng Books
CREATE TABLE Books (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(255) NOT NULL,
    Author NVARCHAR(100) NOT NULL,
    CategoryId INT NOT NULL,
    Description NVARCHAR(500),
    ISBN NVARCHAR(13) UNIQUE NOT NULL,
    PublishedYear INT NOT NULL,
    ImageUrl NVARCHAR(255),
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);
GO

-- Tạo bảng Suppliers
CREATE TABLE Suppliers (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    ContactInfo NVARCHAR(255)
);
GO

-- Tạo bảng ImportBills
CREATE TABLE ImportBills (
    Id INT PRIMARY KEY IDENTITY(1,1),
    SupplierId INT NOT NULL,
    StaffId INT NOT NULL,
    FOREIGN KEY (SupplierId) REFERENCES Suppliers(Id),
    FOREIGN KEY (StaffId) REFERENCES Users(Id)
);
GO

-- Tạo bảng ImportBillDetails
CREATE TABLE ImportBillDetails (
    Id INT PRIMARY KEY IDENTITY(1,1),
    ImportBillId INT NOT NULL,
    BookId INT NOT NULL,
    Quantity INT NOT NULL,
    CostPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ImportBillId) REFERENCES ImportBills(Id),
    FOREIGN KEY (BookId) REFERENCES Books(Id)
);
GO

-- Tạo bảng Inventory
CREATE TABLE Inventory (
    Id INT PRIMARY KEY IDENTITY(1,1),
    BookId INT NOT NULL,
    Quantity INT NOT NULL,
    SalePrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (BookId) REFERENCES Books(Id)
);
GO

-- Tạo bảng Discounts
CREATE TABLE Discounts (
    Id INT PRIMARY KEY IDENTITY(1,1),
    BookId INT NOT NULL,
    DiscountPercentage INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    FOREIGN KEY (BookId) REFERENCES Books(Id)
);
GO

-- Tạo bảng OrderStatus
CREATE TABLE OrderStatus (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL
);
GO

-- Tạo bảng Orders
CREATE TABLE Orders (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CustomerId INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalPrice DECIMAL(10,2) NOT NULL,
    StatusId INT NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES Users(Id),
    FOREIGN KEY (StatusId) REFERENCES OrderStatus(Id)
);
GO

-- Tạo bảng OrderDetails
CREATE TABLE OrderDetails (
    Id INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL,
    BookId INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(Id),
    FOREIGN KEY (BookId) REFERENCES Books(Id)
);
GO

-- Tạo bảng News
CREATE TABLE News (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(255) NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    PublishedAt DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(50) NOT NULL,
    UserId INT NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);
GO

-- Tạo bảng Feedbacks
CREATE TABLE Feedbacks (
    Id INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(500),
    FOREIGN KEY (OrderId) REFERENCES Orders(Id)
);
GO

INSERT INTO UserRole (Name) VALUES 
(N'Admin'), 
(N'StoreOwner'), 
(N'WarehouseStaff'),
(N'SaleStaff'), 
(N'Customer'), 
(N'Supplier');
GO

-- Chèn dữ liệu mẫu vào bảng Users
INSERT INTO Users (FullName, Email, PhoneNumber, Address, Password, RoleId) VALUES
(N'Nguyễn Văn A', 'a@gmail.com', '0901234567', N'Hà Nội', '@1', 1),  -- Admin
(N'Trần Thị B', 'b@gmail.com', '0912345678', N'TP.HCM', '@1', 2),  -- StoreOwner
(N'Lê Văn C', 'c@gmail.com', '0923456789', N'Đà Nẵng', '@1', 3),  -- WarehouseStaff
(N'Lưu Minh D', 'd@gmail.com', '0934567890', N'Cần Thơ', '@1', 4),  -- SaleStaff
(N'Hoàng Thị E', 'e@gmail.com', '0945678901', N'Hải Phòng', '@1', 5),  -- Customer
(N'Nguyễn Văn I', 'i1@gmail.com', '0956789012', N'Hà Nội', '@1', 6),  -- Supplier
(N'Trần Thị J', 'j1@gmail.com', '0967890123', N'TP.HCM', '@1', 2),  -- StoreOwner
(N'Lê Văn K', 'k1@gmail.com', '0978901234', N'Đà Nẵng', '@1', 3),  -- WarehouseStaff
(N'Hoàng Thị L', 'l1@gmail.com', '0989012345', N'Hải Phòng', '@1', 4),  -- SaleStaff
(N'Phạm Minh M', 'm1@gmail.com', '0990123456', N'Cần Thơ', '@1', 5),  -- Customer
(N'Võ Quốc N', 'n1@gmail.com', '0901123456', N'Bình Dương', '@1', 6),  -- Supplier
(N'Đặng Thị O', 'o1@gmail.com', '0912234567', N'Huế', '@1', 3),  -- WarehouseStaff
(N'Ngô Huy P', 'p1@gmail.com', '0923345678', N'Hải Dương', '@1', 4),  -- SaleStaff
(N'Bùi Văn Q', 'q1@gmail.com', '0934456789', N'Nha Trang', '@1', 5),  -- Customer
(N'Lương Thị R', 'r1@gmail.com', '0945567890', N'Vũng Tàu', '@1', 6);  -- Supplier
GO

-- Chèn dữ liệu mẫu vào bảng OrderStatus
INSERT INTO OrderStatus (Name) VALUES ('Pending'), ('Processing'), ('Shipped'), ('Delivered'), ('Cancelled');
GO

-- Chèn dữ liệu mẫu vào bảng Categories
INSERT INTO Categories (Name) VALUES
('Khoa học'), ('Văn học'), ('Kinh tế'), ('Công nghệ'), ('Lịch sử');
GO

-- Chèn dữ liệu mẫu vào bảng Books
INSERT INTO Books (Title, Author, CategoryId, Description, ISBN, PublishedYear, ImageUrl) VALUES
(N'Đắc Nhân Tâm', N'Dale Carnegie', 3, N'Cuốn sách giúp cải thiện kỹ năng giao tiếp', '1111111111111', 1936, 'dacnhantam.jpg'),
(N'Nhà Giả Kim', N'Paulo Coelho', 2, N'Câu chuyện triết lý về cuộc sống', '2222222222222', 1988, 'nhagiakim.jpg'),
(N'Bí Mật Tư Duy Triệu Phú', N'T. Harv Eker', 3, N'Những nguyên tắc thành công tài chính', '3333333333333', 2005, 'tuytrieuphu.jpg'),
(N'Cha Giàu Cha Nghèo', N'Robert Kiyosaki', 3, N'Bài học về tài chính cá nhân', '4444444444444', 1997, 'chagiauchangheo.jpg'),
(N'Thép Đã Tôi Thế Đấy', N'Nikolai Ostrovsky', 2, N'Cuộc đời gian khổ của nhân vật chính', '5555555555555', 1932, 'thepdattoitheday.jpg'),
(N'Tư Duy Nhanh và Chậm', N'Daniel Kahneman', 3, N'Nghiên cứu về tâm lý học và kinh tế học hành vi', '6666666666666', 2011, 'tuduy nhanh cham.jpg'),
(N'Tội Ác và Hình Phạt', N'Fyodor Dostoevsky', 2, N'Tác phẩm kinh điển về tâm lý con người', '7777777777777', 1866, 'toiac hinhphat.jpg'),
(N'1984', N'George Orwell', 2, N'Tiểu thuyết dystopia nổi tiếng', '8888888888888', 1949, '1984.jpg'),
(N'Cuốn Theo Chiều Gió', N'Margaret Mitchell', 2, N'Tiểu thuyết lịch sử lãng mạn', '9999999999999', 1936, 'cuontheo chieugio.jpg'),
(N'Trại Súc Vật', N'George Orwell', 2, N'Truyện ngụ ngôn chính trị', '1010101010101', 1945, 'traisucvat.jpg'),
(N'Súng, Vi Trùng và Thép', N'Jared Diamond', 5, N'Nghiên cứu lịch sử về sự phát triển của các nền văn minh', '1112131415161', 1997, 'sungvitrumthep.jpg'),
(N'Sapiens: Lược Sử Loài Người', N'Yuval Noah Harari', 5, N'Khám phá lịch sử loài người', '1213141516171', 2011, 'sapiens.jpg'),
(N'21 Bài Học Cho Thế Kỷ 21', N'Yuval Noah Harari', 5, N'Những thách thức trong thời đại hiện đại', '1314151617181', 2018, '21baihoc.jpg'),
(N'Homo Deus', N'Yuval Noah Harari', 5, N'Tương lai của nhân loại', '1415161718191', 2016, 'homodeus.jpg'),
(N'Triệu Phú Kế Tiếp', N'MJ DeMarco', 3, N'Cách tạo dựng sự giàu có nhanh chóng', '1516171819201', 2011, 'trieuphu.jpg'),
(N'Thuyết Tiến Hóa', N'Charles Darwin', 1, N'Lý thuyết tiến hóa nổi tiếng', '1617181920211', 1859, 'thuyettienhoa.jpg'),
(N'Steve Jobs', N'Walter Isaacson', 3, N'Tiểu sử Steve Jobs', '1718192021221', 2011, 'stevejobs.jpg'),
(N'Elon Musk', N'Ashlee Vance', 3, N'Tiểu sử của tỷ phú Elon Musk', '1819202122231', 2015, 'elonmusk.jpg'),
(N'Lập Trình Python', N'Guido van Rossum', 4, N'Sách hướng dẫn lập trình Python', '1920212223241', 2020, 'python.jpg'),
(N'Giải Tích Toán Học', N'Rudin', 1, N'Sách giải tích nâng cao', '2021222324251', 1953, 'giaitich.jpg'),
(N'Thế Giới Phẳng', N'Thomas Friedman', 3, N'Phân tích toàn cầu hóa', '2122232425261', 2005, 'thegioiphang.jpg'),
(N'Cuộc Cách Mạng Công Nghiệp 4.0', N'Klaus Schwab', 4, N'Thời đại công nghệ mới', '2223242526271', 2016, 'cachmang4.0.jpg'),
(N'Lịch Sử Ngắn Về Thời Gian', N'Stephen Hawking', 1, N'Giải thích các lý thuyết vật lý', '2324252627281', 1988, 'lichsuvatly.jpg'),
(N'Vật Lý Lượng Tử', N'Albert Einstein', 1, N'Giới thiệu về vật lý lượng tử', '2425262728291', 1905, 'vatlyluongtu.jpg'),
(N'Mật Mã Học', N'Simon Singh', 1, N'Lịch sử của mật mã học', '2526272829301', 1999, 'matmahoc.jpg'),
(N'Tiền Tệ Tương Lai', N'Chris Burniske', 3, N'Tương lai của tiền điện tử', '2627282930311', 2017, 'tientuonglai.jpg'),
(N'Công Nghệ Blockchain', N'Don Tapscott', 4, N'Ứng dụng của blockchain', '2728293031321', 2016, 'blockchain.jpg'),
(N'Người Giàu Nhất Thành Babylon', N'George Clason', 3, N'Nguyên tắc làm giàu', '2829303132331', 1926, 'babylon.jpg'),
(N'Lịch Sử Văn Minh', N'Will Durant', 5, N'Tổng quan lịch sử văn minh nhân loại', '2930313233341', 1935, 'lichsu.jpg'),
(N'Bản Đồ Tư Duy', N'Tony Buzan', 3, N'Phương pháp tư duy hiệu quả', '3031323334351', 1996, 'bandomindmap.jpg'),
(N'Phương Pháp Học Tập Siêu Tốc', N'Tony Buzan', 3, N'Bí quyết học nhanh', '3132333435361', 1991, 'hoctapsieutoc.jpg'),
(N'Sống Thật Đơn Giản', N'Dominique Loreau', 3, N'Bí quyết sống tối giản', '3233343536371', 2005, 'songdonian.jpg'),
(N'Chủ Nghĩa Hiện Sinh Là Chủ Nghĩa Nhân Đạo', N'Jean-Paul Sartre', 2, N'Quan điểm triết học hiện sinh', '3334353637381', 1946, 'hien sinh.jpg'),
(N'Nền Dân Chủ Ở Mỹ', N'Alexis de Tocqueville', 5, N'Phân tích về nền dân chủ Hoa Kỳ', '3435363738391', 1835, 'danchu.jpg'),
(N'Kỹ Năng Đàm Phán', N'Roger Fisher', 3, N'Chiến thuật đàm phán hiệu quả', '3536373839401', 1981, 'damphan.jpg');

GO


-- Chèn dữ liệu mẫu vào bảng Suppliers
INSERT INTO Suppliers (Name, ContactInfo) VALUES
('Nhà sách Alpha', 'alpha@gmail.com'),
('Công ty Sách Trẻ', 'sachtre@gmail.com');
GO

-- Chèn dữ liệu mẫu vào bảng ImportBills
INSERT INTO ImportBills (SupplierId, StaffId) VALUES
(1, 3), (2, 3);
GO

-- Chèn dữ liệu mẫu vào bảng ImportBillDetails
INSERT INTO ImportBillDetails (ImportBillId, BookId, Quantity, CostPrice) VALUES
(1, 1, 100, 50000), (2, 2, 50, 75000);
GO

-- Chèn dữ liệu mẫu vào bảng Inventory
INSERT INTO Inventory (BookId, Quantity, SalePrice) VALUES
(1, 90, 60000), (2, 45, 80000);
GO

-- Chèn dữ liệu mẫu vào bảng Discounts
INSERT INTO Discounts (BookId, DiscountPercentage, StartDate, EndDate) VALUES
(1, 10, '2025-03-01', '2025-03-31');
GO

INSERT INTO News (Title, Content, PublishedAt, Status, UserId) VALUES
(N'Sách mới tháng 3', N'Chúng tôi vừa nhập về nhiều sách mới hấp dẫn...', '2025-03-05', 'Active', 1),
(N'Giảm giá tháng 4', N'Hàng loạt ưu đãi đặc biệt trong tháng 4...', '2025-03-10', 'Active', 2),
(N'Cuốn sách hay nên đọc', N'Giới thiệu những tựa sách kinh điển mà bạn không thể bỏ qua...', '2025-03-15', 'Active', 3),
(N'Chương trình tặng sách', N'Nhận sách miễn phí khi mua hàng trên 200k...', '2025-03-18', 'Inactive', 1),
(N'Thông báo bảo trì hệ thống', N'Hệ thống sẽ được bảo trì vào ngày 20/03...', '2025-03-19', 'Active', 2),
(N'Sách mới ra mắt', N'Cập nhật những cuốn sách mới nhất...', '2025-03-22', 'Active', 3),
(N'Cuộc thi review sách', N'Chia sẻ cảm nhận của bạn về cuốn sách yêu thích...', '2025-03-25', 'Active', 1),
(N'Những cuốn sách truyền cảm hứng', N'Giới thiệu các cuốn sách giúp thay đổi tư duy...', '2025-03-27', 'Active', 2),
(N'Khuyến mãi đặc biệt', N'Ưu đãi lên đến 50% cho sách best-seller...', '2025-03-30', 'Inactive', 3),
(N'Cách chọn sách phù hợp', N'Hướng dẫn cách chọn sách theo sở thích...', '2025-04-02', 'Active', 1),
(N'Gợi ý sách cho mùa hè', N'Những cuốn sách phù hợp cho kỳ nghỉ hè...', '2025-04-05', 'Active', 2),
(N'Thông báo thay đổi chính sách', N'Cập nhật chính sách đổi trả sách mới...', '2025-04-08', 'Active', 3),
(N'Sách hay về kinh doanh', N'Những cuốn sách giúp bạn hiểu về thế giới kinh doanh...', '2025-04-10', 'Active', 1),
(N'Cuộc thi viết truyện ngắn', N'Cuộc thi dành cho những ai yêu thích sáng tác...', '2025-04-15', 'Inactive', 2),
(N'Cách đọc sách hiệu quả', N'Những mẹo giúp bạn đọc sách nhanh và nhớ lâu hơn...', '2025-04-18', 'Active', 3),
(N'Giảm giá sách khoa học', N'Những tựa sách khoa học đang giảm giá...', '2025-04-20', 'Active', 1),
(N'Chương trình khách hàng thân thiết', N'Nhận ưu đãi khi trở thành thành viên VIP...', '2025-04-22', 'Active', 2),
(N'Những cuốn sách bán chạy tháng 5', N'Danh sách những cuốn sách hot nhất...', '2025-04-25', 'Active', 3),
(N'Cách chọn sách cho trẻ em', N'Những tiêu chí quan trọng khi chọn sách cho trẻ...', '2025-04-28', 'Active', 1),
(N'Thông báo về sách sắp ra mắt', N'Danh sách những cuốn sách dự kiến phát hành...', '2025-05-01', 'Active', 2),
(N'Những cuốn sách tâm lý học hay', N'Sách giúp bạn hiểu rõ hơn về tâm lý con người...', '2025-05-03', 'Active', 3),
(N'Thông tin về hội sách 2025', N'Những hoạt động thú vị tại hội sách...', '2025-05-05', 'Active', 1),
(N'Chương trình đọc sách miễn phí', N'Đọc sách miễn phí tại cửa hàng...', '2025-05-08', 'Inactive', 2),
(N'Tổng hợp sách về phát triển bản thân', N'Những cuốn sách giúp bạn trở nên tốt hơn...', '2025-05-10', 'Active', 3),
(N'Sách về đầu tư tài chính', N'Những nguyên tắc đầu tư hiệu quả...', '2025-05-12', 'Active', 1),
(N'Cuộc thi viết cảm nhận sách', N'Chia sẻ bài viết để nhận quà hấp dẫn...', '2025-05-15', 'Active', 2),
(N'Những tựa sách nổi bật tháng 6', N'Danh sách sách bán chạy trong tháng...', '2025-05-18', 'Active', 3),
(N'Góc nhìn về sách điện tử', N'Lợi ích và hạn chế của sách điện tử...', '2025-05-20', 'Active', 1),
(N'Sách dành cho người mới bắt đầu kinh doanh', N'Những cuốn sách giúp khởi nghiệp dễ dàng hơn...', '2025-05-22', 'Active', 2),
(N'Thiếu nhi và sách', N'Tác động của sách đối với sự phát triển của trẻ...', '2025-05-25', 'Active', 3),
(N'Sách hay về tâm linh', N'Khám phá những triết lý sâu sắc trong cuộc sống...', '2025-05-27', 'Active', 1),
(N'Thông tin về sách sắp xuất bản', N'Những đầu sách hot sắp ra mắt...', '2025-05-30', 'Active', 2),
(N'Những tác giả trẻ tài năng', N'Giới thiệu những tác giả trẻ đang lên...', '2025-06-02', 'Active', 3),
(N'Sách giúp nâng cao kỹ năng mềm', N'Những cuốn sách phát triển kỹ năng sống...', '2025-06-05', 'Active', 1),
(N'Bí quyết chọn sách phù hợp', N'Những cách tìm sách theo đúng nhu cầu...', '2025-06-08', 'Active', 2),
(N'Những cuốn tiểu thuyết kinh điển', N'Thế giới của những tác phẩm bất hủ...', '2025-06-10', 'Active', 3),
(N'Thông tin về chương trình khuyến mãi sách', N'Giảm giá sốc trong tháng này...', '2025-06-12', 'Active', 1),
(N'Cuộc thi sáng tác thơ', N'Viết thơ và nhận phần thưởng hấp dẫn...', '2025-06-15', 'Active', 2),
(N'Những cuốn sách về công nghệ AI', N'Tìm hiểu về trí tuệ nhân tạo...', '2025-06-18', 'Active', 3),
(N'Giảm giá sách văn học', N'Ưu đãi cho các tác phẩm văn học nổi tiếng...', '2025-06-20', 'Inactive', 1),
(N'Những cuốn sách về lịch sử Việt Nam', N'Thấu hiểu quá khứ thông qua sách...', '2025-06-22', 'Active', 2),
(N'Thông tin về hội thảo sách', N'Những diễn giả nổi tiếng sẽ có mặt...', '2025-06-25', 'Active', 3),
(N'Sách dành cho người hướng nội', N'Lựa chọn sách phù hợp với tính cách...', '2025-06-28', 'Active', 1),
(N'Những cuốn sách hot nhất mùa hè', N'Những tựa sách đáng đọc trong kỳ nghỉ...', '2025-07-01', 'Active', 2),
(N'Chương trình đổi sách cũ lấy sách mới', N'Trao đổi sách tại cửa hàng...', '2025-07-05', 'Active', 3);
GO

INSERT INTO Orders (CustomerId, OrderDate, TotalPrice, StatusId) VALUES
(1, '2025-03-10', 160000, 1);
GO

-- Chèn dữ liệu mẫu vào bảng OrderDetails
INSERT INTO OrderDetails (OrderId, BookId, Quantity, Price) VALUES
(1, 1, 2, 60000);
GO

INSERT INTO News (Title, Content, PublishedAt, Status, UserId) VALUES
(N'Sách mới tháng 3', N'Chúng tôi vừa nhập về nhiều sách mới hấp dẫn...', '2025-03-05', 'Active', 1),
(N'Giảm giá tháng 4', N'Hàng loạt ưu đãi đặc biệt trong tháng 4...', '2025-03-10', 'Active', 2),
(N'Cuốn sách hay nên đọc', N'Giới thiệu những tựa sách kinh điển mà bạn không thể bỏ qua...', '2025-03-15', 'Active', 3),
(N'Chương trình tặng sách', N'Nhận sách miễn phí khi mua hàng trên 200k...', '2025-03-18', 'Inactive', 1),
(N'Thông báo bảo trì hệ thống', N'Hệ thống sẽ được bảo trì vào ngày 20/03...', '2025-03-19', 'Active', 2),
(N'Sách mới ra mắt', N'Cập nhật những cuốn sách mới nhất...', '2025-03-22', 'Active', 3),
(N'Cuộc thi review sách', N'Chia sẻ cảm nhận của bạn về cuốn sách yêu thích...', '2025-03-25', 'Active', 1),
(N'Những cuốn sách truyền cảm hứng', N'Giới thiệu các cuốn sách giúp thay đổi tư duy...', '2025-03-27', 'Active', 2),
(N'Khuyến mãi đặc biệt', N'Ưu đãi lên đến 50% cho sách best-seller...', '2025-03-30', 'Inactive', 3),
(N'Cách chọn sách phù hợp', N'Hướng dẫn cách chọn sách theo sở thích...', '2025-04-02', 'Active', 1),
(N'Gợi ý sách cho mùa hè', N'Những cuốn sách phù hợp cho kỳ nghỉ hè...', '2025-04-05', 'Active', 2),
(N'Thông báo thay đổi chính sách', N'Cập nhật chính sách đổi trả sách mới...', '2025-04-08', 'Active', 3),
(N'Sách hay về kinh doanh', N'Những cuốn sách giúp bạn hiểu về thế giới kinh doanh...', '2025-04-10', 'Active', 1),
(N'Cuộc thi viết truyện ngắn', N'Cuộc thi dành cho những ai yêu thích sáng tác...', '2025-04-15', 'Inactive', 2),
(N'Cách đọc sách hiệu quả', N'Những mẹo giúp bạn đọc sách nhanh và nhớ lâu hơn...', '2025-04-18', 'Active', 3),
(N'Giảm giá sách khoa học', N'Những tựa sách khoa học đang giảm giá...', '2025-04-20', 'Active', 1),
(N'Chương trình khách hàng thân thiết', N'Nhận ưu đãi khi trở thành thành viên VIP...', '2025-04-22', 'Active', 2),
(N'Những cuốn sách bán chạy tháng 5', N'Danh sách những cuốn sách hot nhất...', '2025-04-25', 'Active', 3),
(N'Cách chọn sách cho trẻ em', N'Những tiêu chí quan trọng khi chọn sách cho trẻ...', '2025-04-28', 'Active', 1),
(N'Thông báo về sách sắp ra mắt', N'Danh sách những cuốn sách dự kiến phát hành...', '2025-05-01', 'Active', 2),
(N'Những cuốn sách tâm lý học hay', N'Sách giúp bạn hiểu rõ hơn về tâm lý con người...', '2025-05-03', 'Active', 3),
(N'Thông tin về hội sách 2025', N'Những hoạt động thú vị tại hội sách...', '2025-05-05', 'Active', 1),
(N'Chương trình đọc sách miễn phí', N'Đọc sách miễn phí tại cửa hàng...', '2025-05-08', 'Inactive', 2),
(N'Tổng hợp sách về phát triển bản thân', N'Những cuốn sách giúp bạn trở nên tốt hơn...', '2025-05-10', 'Active', 3),
(N'Sách về đầu tư tài chính', N'Những nguyên tắc đầu tư hiệu quả...', '2025-05-12', 'Active', 1),
(N'Cuộc thi viết cảm nhận sách', N'Chia sẻ bài viết để nhận quà hấp dẫn...', '2025-05-15', 'Active', 2),
(N'Những tựa sách nổi bật tháng 6', N'Danh sách sách bán chạy trong tháng...', '2025-05-18', 'Active', 3),
(N'Góc nhìn về sách điện tử', N'Lợi ích và hạn chế của sách điện tử...', '2025-05-20', 'Active', 1),
(N'Sách dành cho người mới bắt đầu kinh doanh', N'Những cuốn sách giúp khởi nghiệp dễ dàng hơn...', '2025-05-22', 'Active', 2),
(N'Thiếu nhi và sách', N'Tác động của sách đối với sự phát triển của trẻ...', '2025-05-25', 'Active', 3),
(N'Sách hay về tâm linh', N'Khám phá những triết lý sâu sắc trong cuộc sống...', '2025-05-27', 'Active', 1),
(N'Thông tin về sách sắp xuất bản', N'Những đầu sách hot sắp ra mắt...', '2025-05-30', 'Active', 2),
(N'Những tác giả trẻ tài năng', N'Giới thiệu những tác giả trẻ đang lên...', '2025-06-02', 'Active', 3),
(N'Sách giúp nâng cao kỹ năng mềm', N'Những cuốn sách phát triển kỹ năng sống...', '2025-06-05', 'Active', 1),
(N'Bí quyết chọn sách phù hợp', N'Những cách tìm sách theo đúng nhu cầu...', '2025-06-08', 'Active', 2),
(N'Những cuốn tiểu thuyết kinh điển', N'Thế giới của những tác phẩm bất hủ...', '2025-06-10', 'Active', 3),
(N'Thông tin về chương trình khuyến mãi sách', N'Giảm giá sốc trong tháng này...', '2025-06-12', 'Active', 1),
(N'Cuộc thi sáng tác thơ', N'Viết thơ và nhận phần thưởng hấp dẫn...', '2025-06-15', 'Active', 2),
(N'Những cuốn sách về công nghệ AI', N'Tìm hiểu về trí tuệ nhân tạo...', '2025-06-18', 'Active', 3),
(N'Giảm giá sách văn học', N'Ưu đãi cho các tác phẩm văn học nổi tiếng...', '2025-06-20', 'Inactive', 1),
(N'Những cuốn sách về lịch sử Việt Nam', N'Thấu hiểu quá khứ thông qua sách...', '2025-06-22', 'Active', 2),
(N'Thông tin về hội thảo sách', N'Những diễn giả nổi tiếng sẽ có mặt...', '2025-06-25', 'Active', 3),
(N'Sách dành cho người hướng nội', N'Lựa chọn sách phù hợp với tính cách...', '2025-06-28', 'Active', 1),
(N'Những cuốn sách hot nhất mùa hè', N'Những tựa sách đáng đọc trong kỳ nghỉ...', '2025-07-01', 'Active', 2),
(N'Chương trình đổi sách cũ lấy sách mới', N'Trao đổi sách tại cửa hàng...', '2025-07-05', 'Active', 3);
GO


-- Chèn dữ liệu mẫu vào bảng Feedbacks
INSERT INTO Feedbacks (OrderId, Rating, Comment) VALUES
(1, 5, 'Sách rất hay, giao hàng nhanh!');
GO

