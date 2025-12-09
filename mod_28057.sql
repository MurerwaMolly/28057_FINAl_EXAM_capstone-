CREATE TABLE Visitors (
    Visitor_ID      NUMBER PRIMARY KEY,
    Full_Name       VARCHAR2(150) NOT NULL,
    Gender          VARCHAR2(20) CHECK (Gender IN ('Male','Female','Other')),
    ID_Number       VARCHAR2(50) UNIQUE NOT NULL,
    Contact_Info    VARCHAR2(100),
    Created_At      DATE DEFAULT SYSDATE
);

CREATE TABLE Staff (
    Staff_ID       NUMBER PRIMARY KEY,
    Staff_Name     VARCHAR2(150) NOT NULL,
    Department     VARCHAR2(100) NOT NULL,
    Position       VARCHAR2(100),
    Contact_Info   VARCHAR2(100)
);
 CREATE TABLE Visit_Log (
    Log_ID       NUMBER PRIMARY KEY,
    Visitor_ID   NUMBER REFERENCES Visitors(Visitor_ID),
    Staff_ID     NUMBER REFERENCES Staff(Staff_ID),
    Purpose      VARCHAR2(500),
    Entry_Time   DATE DEFAULT SYSDATE,
    Exit_Time    DATE,
    Status       VARCHAR2(30) CHECK (Status IN ('Entered','Exited','Pending')),
    Pass_Number  VARCHAR2(50) UNIQUE NOT NULL
);
 
 CREATE TABLE System_Users (
    User_ID        NUMBER PRIMARY KEY,
    Username       VARCHAR2(100) UNIQUE NOT NULL,
    Password_Hash  VARCHAR2(200) NOT NULL,
    Role           VARCHAR2(50) CHECK (Role IN ('Admin','Security','Reception')),
    Created_At     DATE DEFAULT SYSDATE
);

CREATE TABLE Verification_Log (
    Verif_ID          NUMBER PRIMARY KEY,
    Visitor_ID        NUMBER REFERENCES Visitors(Visitor_ID),
    Verified_By       NUMBER REFERENCES System_Users(User_ID),
    Verification_Time DATE DEFAULT SYSDATE,
    Verification_Type VARCHAR2(50)
        CHECK (Verification_Type IN ('ID Check','QR Scan','Manual Entry')),
    Note              VARCHAR2(500)
);

CREATE TABLE Alert_Log (
    Alert_ID      NUMBER PRIMARY KEY,
    Visitor_ID    NUMBER REFERENCES Visitors(Visitor_ID),
    Staff_ID      NUMBER REFERENCES Staff(Staff_ID),
    Alert_Message VARCHAR2(2000) NOT NULL,
    Severity      VARCHAR2(20) CHECK (Severity IN ('Low','Medium','High')),
    Alert_Time    DATE DEFAULT SYSDATE
);

CREATE TABLE Status_Log (
    StatusLog_ID  NUMBER PRIMARY KEY,
    Visitor_ID    NUMBER REFERENCES Visitors(Visitor_ID),
    Old_Status    VARCHAR2(30),
    New_Status    VARCHAR2(30) NOT NULL,
    Updated_At    DATE DEFAULT SYSDATE,
    Note          VARCHAR2(500)
);

INSERT INTO Visitors VALUES (visitor_seq.NEXTVAL, 'John Doe', 'Male', 'ID10221', '0789001122', SYSDATE);
INSERT INTO Visitors VALUES (visitor_seq.NEXTVAL, 'Sarah Mukamana', 'Female', 'ID99881', '0722003344', SYSDATE);
INSERT INTO Visitors VALUES (visitor_seq.NEXTVAL, 'Eric Ndayizigiye', 'Male', 'ID88441', '0734556611', SYSDATE);

INSERT INTO Staff VALUES (staff_seq.NEXTVAL, 'Alice Uwase', 'Human Resources', 'HR Manager', '0788112233');
INSERT INTO Staff VALUES (staff_seq.NEXTVAL, 'Patrick Mugabo', 'IT Department', 'IT Support', '0788334411');
INSERT INTO Staff VALUES (staff_seq.NEXTVAL, 'Grace Ineza', 'Finance', 'Accountant', '0722881199');

INSERT INTO System_Users VALUES (users_seq.NEXTVAL, 'admin01', 'hash123', 'Admin', SYSDATE);
INSERT INTO System_Users VALUES (users_seq.NEXTVAL, 'security01', 'hash456', 'Security', SYSDATE);
INSERT INTO System_Users VALUES (users_seq.NEXTVAL, 'reception01', 'hash789', 'Reception', SYSDATE);

INSERT INTO Visit_Log VALUES (
    visitlog_seq.NEXTVAL,
    1,   -- John Doe
    1,   -- HR Staff (Alice)
    'Job Application Submission',
    SYSDATE,
    NULL,
    'Entered',
    'PASS-101'
);

INSERT INTO Visit_Log VALUES (
    visitlog_seq.NEXTVAL,
    2,
    2,
    'System Maintenance Inquiry',
    SYSDATE,
    NULL,
    'Entered',
    'PASS-102'
);

INSERT INTO Verification_Log VALUES (
    verify_seq.NEXTVAL,
    1,
    2,  -- Verified by security01
    SYSDATE,
    'ID Check',
    'ID verified and matched registry'
);

INSERT INTO Verification_Log VALUES (
    verify_seq.NEXTVAL,
    2,
    2,
    SYSDATE,
    'Manual Entry',
    'Visitor forgot ID—verified manually'
);

INSERT INTO Alert_Log VALUES (
    alert_seq.NEXTVAL,
    1,
    1,
    'Visitor arrival notification sent to HR Manager.',
    'Low',
    SYSDATE
);

INSERT INTO Alert_Log VALUES (
    alert_seq.NEXTVAL,
    2,
    2,
    'Urgent IT visitor awaiting assistance.',
    'High',
    SYSDATE
);

