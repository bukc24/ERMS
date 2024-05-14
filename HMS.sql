USE [master]
GO
/****** Object:  Database [HospitalManagementSystem]    Script Date: 5/15/2024 12:42:33 AM ******/
CREATE DATABASE [HospitalManagementSystem]
GO
ALTER DATABASE [HospitalManagementSystem] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HospitalManagementSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HospitalManagementSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HospitalManagementSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HospitalManagementSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HospitalManagementSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HospitalManagementSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HospitalManagementSystem] SET  MULTI_USER 
GO
ALTER DATABASE [HospitalManagementSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HospitalManagementSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HospitalManagementSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HospitalManagementSystem] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HospitalManagementSystem] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'HospitalManagementSystem', N'ON'
GO
ALTER DATABASE [HospitalManagementSystem] SET QUERY_STORE = ON
GO
ALTER DATABASE [HospitalManagementSystem] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [HospitalManagementSystem]
GO
/****** Object:  UserDefinedFunction [dbo].[GetNumberOfPatientsInER]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetNumberOfPatientsInER]()
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;

    SELECT @Count = COUNT(*)
    FROM PatientsInER;

    RETURN @Count;
END;
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[DoctorID] [int] IDENTITY(1,1) NOT NULL,
	[Specialization] [varchar](100) NULL,
	[OPDCharges] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DoctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoctorShift]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoctorShift](
	[ShiftID] [int] IDENTITY(1,1) NOT NULL,
	[DoctorID] [int] NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[Day] [varchar](20) NULL,
	[Placement] [varchar](100) NULL,
	[RoomNo] [varchar](50) NULL,
	[AppointmentsLimit] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ShiftID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmpID] [int] IDENTITY(1,1) NOT NULL,
	[EmpName] [varchar](100) NULL,
	[DOB] [date] NULL,
	[Gender] [char](1) NULL,
	[Contact] [varchar](20) NULL,
	[Address] [varchar](255) NULL,
	[JobTitle] [varchar](100) NULL,
	[DeptID] [int] NULL,
	[Email] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[DOJ] [date] NULL,
	[Salary] [decimal](10, 2) NULL,
	[Status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetDoctorsInER]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetDoctorsInER]()
RETURNS TABLE
AS
RETURN
(
    SELECT d.DoctorID,e.EmpName,d.Specialization,ds.AppointmentsLimit,ds.RoomNo
    FROM dbo.DoctorShift ds
	join doctor d on ds.DoctorID = d.DoctorID
	join Employee e on d.DoctorID=e.EmpID
    WHERE [Day] = DATENAME(WEEKDAY, GETDATE())
        AND CAST(GETDATE() AS TIME) BETWEEN StartTime AND EndTime
        AND Placement = 'ER'
);
GO
/****** Object:  Table [dbo].[Ambulance]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ambulance](
	[AmbulanceID] [int] IDENTITY(1,1) NOT NULL,
	[Model] [varchar](255) NULL,
	[NumberPlate] [varchar](50) NULL,
	[Description] [varchar](255) NULL,
	[IsAvailable] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AmbulanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AmbulanceRequest]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AmbulanceRequest](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[AmbulanceID] [int] NULL,
	[CallID] [int] NULL,
	[DispatchTime] [datetime] NULL,
	[ReturnTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmergencyCall]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmergencyCall](
	[CallID] [int] IDENTITY(1,1) NOT NULL,
	[CallerName] [varchar](255) NULL,
	[ContactNumber] [varchar](20) NULL,
	[Description] [varchar](255) NULL,
	[Location] [varchar](255) NULL,
	[Timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetEmergencyCallDetails]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetEmergencyCallDetails]()
RETURNS TABLE
AS
RETURN
(
    SELECT ar.RequestID, e.*, ar.DispatchTime,ar.ReturnTime, a.Model, a.NumberPlate
    FROM EmergencyCall e
    JOIN AmbulanceRequest ar ON e.CallID = ar.CallID 
    JOIN Ambulance a ON ar.AmbulanceID = a.AmbulanceID
);
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[PatientName] [varchar](100) NULL,
	[DOB] [date] NULL,
	[Gender] [char](1) NULL,
	[Contact] [varchar](20) NULL,
	[Address] [varchar](255) NULL,
	[Email] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[Status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientsInER]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientsInER](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[RequestID] [int] NULL,
	[Status] [varchar](50) NULL,
	[Triage] [varchar](50) NULL,
	[DoctorID] [int] NULL,
	[Description] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetPatientsNotInER]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetPatientsNotInER]()
RETURNS TABLE
AS
RETURN
(
    SELECT p.PatientID, p.PatientName, p.DOB, p.Gender, p.Contact, p.Address
    FROM PatientsInER pe
    RIGHT OUTER JOIN Patient p ON pe.PatientID = p.PatientID
    WHERE pe.PatientID IS NULL
);
GO
/****** Object:  UserDefinedFunction [dbo].[GetPatientsInER]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetPatientsInER]()
RETURNS TABLE
AS
RETURN
(
    SELECT p.PatientID, p.PatientName, p.DOB,YEAR(GETDATE()) - YEAR(DOB) AS Age, p.Gender, p.Contact, p.Address, pe.RequestID, pe.Status, pe.Triage,pe.DoctorID
    FROM PatientsInER pe
    INNER JOIN Patient p ON pe.PatientID = p.PatientID
);
GO
/****** Object:  UserDefinedFunction [dbo].[GetPatientCountByTriage]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetPatientCountByTriage]()
RETURNS TABLE
AS
RETURN
(
    SELECT Triage, COUNT(*) AS NumberOfPatients
    FROM PatientsInER
    GROUP BY Triage
);
GO
/****** Object:  UserDefinedFunction [dbo].[GetAvailableAmbulances]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetAvailableAmbulances]()
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM Ambulance
    WHERE IsAvailable = 1
);
GO
/****** Object:  Table [dbo].[MedicalHistory]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicalHistory](
	[MedicalHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NULL,
	[TreatmentHistory] [varchar](max) NULL,
	[Allergies] [varchar](max) NULL,
	[PreviousSurgeries] [varchar](max) NULL,
	[FamilyHistory] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MedicalHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetPatientMedicalHistory]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetPatientMedicalHistory]
(
    @PatientID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM MedicalHistory
    WHERE PatientID = @PatientID
);
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[AdminID] [int] IDENTITY(1,1) NOT NULL,
	[AdminName] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[Contact] [varchar](20) NULL,
	[Role] [varchar](50) NULL,
	[Permission] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Appointment]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointment](
	[AppointmentID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NULL,
	[DoctorID] [int] NULL,
	[Date] [date] NULL,
	[Time] [time](7) NULL,
	[Status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Control]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Control](
	[ActionID] [int] IDENTITY(1,1) NOT NULL,
	[ActionType] [varchar](50) NULL,
	[Description] [varchar](max) NULL,
	[Timestamp] [datetime] NULL,
	[AdminID] [int] NULL,
	[Details] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DeptID] [int] IDENTITY(1,1) NOT NULL,
	[DeptName] [varchar](100) NULL,
	[DeptContact] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[DeptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DepartmentHead]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepartmentHead](
	[DeptID] [int] NOT NULL,
	[HOD] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DeptID] ASC,
	[HOD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Diagnosis]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diagnosis](
	[DiagnosisID] [int] IDENTITY(1,1) NOT NULL,
	[DiagnosisName] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[DiagnosisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoctorFeeBilling]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoctorFeeBilling](
	[BillingID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NULL,
	[DoctorID] [int] NULL,
	[AppointmentID] [int] NULL,
	[Date] [date] NULL,
	[TotalAmount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[BillingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ER_Receptionist]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ER_Receptionist](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](250) NOT NULL,
	[password] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[FeedbackID] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentID] [int] NULL,
	[Rating] [int] NULL,
	[Comments] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[FeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[InventoryID] [int] IDENTITY(1,1) NOT NULL,
	[MedicineID] [int] NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Issue]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Issue](
	[IssueID] [int] IDENTITY(1,1) NOT NULL,
	[DeptID] [int] NULL,
	[EmpID] [int] NULL,
	[CreationDate] [date] NULL,
	[Condition] [varchar](max) NULL,
	[Category] [varchar](50) NULL,
	[Content] [varchar](max) NULL,
	[Status] [varchar](20) NULL,
	[Remarks] [varchar](max) NULL,
	[ResolvedBy] [int] NULL,
	[CompletionDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[IssueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LabInvoices]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LabInvoices](
	[InvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[Timestamp] [datetime] NULL,
	[Amount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LabResults]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LabResults](
	[SampleID] [int] NOT NULL,
	[FieldID] [int] NOT NULL,
	[FieldResult] [varchar](max) NULL,
	[Timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SampleID] ASC,
	[FieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufacturer]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturer](
	[ManufacturerID] [int] IDENTITY(1,1) NOT NULL,
	[ManufacturerName] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[Address] [varchar](255) NULL,
	[Contact] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ManufacturerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManufacturerMedicine]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManufacturerMedicine](
	[ManufacturerID] [int] NOT NULL,
	[MedicineID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ManufacturerID] ASC,
	[MedicineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedBilling]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedBilling](
	[BillingID] [int] IDENTITY(1,1) NOT NULL,
	[PrescriptionID] [int] NULL,
	[Date] [date] NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[PaymentMethod] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BillingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medicine]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicine](
	[MedicineID] [int] IDENTITY(1,1) NOT NULL,
	[MedicineName] [varchar](100) NULL,
	[ManufacturerID] [int] NULL,
	[Category] [varchar](50) NULL,
	[ManufacturingDate] [date] NULL,
	[ExpiryDate] [date] NULL,
	[PricePerUnit] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[MedicineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedStock]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedStock](
	[StockID] [int] IDENTITY(1,1) NOT NULL,
	[MedicineID] [int] NULL,
	[SupplierID] [int] NULL,
	[PurchaseDate] [date] NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientsInERHistory]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientsInERHistory](
	[PatientID] [int] NULL,
	[Timestamp] [datetime] NULL,
	[Description] [varchar](255) NULL,
	[Status] [varchar](50) NULL,
	[DoctorID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientTest]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientTest](
	[PrescriptionID] [int] NOT NULL,
	[TestID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PrescriptionID] ASC,
	[TestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pharmacist]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pharmacist](
	[EmpID] [int] NOT NULL,
	[ExperienceLevel] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prescription]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prescription](
	[PrescriptionID] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentID] [int] NULL,
	[ClinicalNotes] [varchar](max) NULL,
	[Status] [varchar](20) NULL,
	[Date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[PrescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrescriptionDiagnosis]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrescriptionDiagnosis](
	[PrescriptionID] [int] NOT NULL,
	[DiagnosisID] [int] NOT NULL,
	[Date] [date] NULL,
	[Description] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[PrescriptionID] ASC,
	[DiagnosisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrescriptionMedicine]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrescriptionMedicine](
	[PrescriptionID] [int] NOT NULL,
	[MedicineID] [int] NOT NULL,
	[Frequency] [varchar](50) NULL,
	[Quantity] [int] NULL,
	[Dosage] [varchar](100) NULL,
	[Instructions] [varchar](max) NULL,
	[MedicineDuration] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PrescriptionID] ASC,
	[MedicineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
	[ReportName] [varchar](100) NULL,
	[Description] [varchar](max) NULL,
	[GeneratedBy] [int] NULL,
	[Timestamp] [datetime] NULL,
	[DeptID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Samples]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Samples](
	[SampleID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[SampleShift] [varchar](50) NULL,
	[Timestamp] [datetime] NULL,
	[Volume] [int] NULL,
	[StorageCondition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[SampleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[Supplier_Name] [varchar](100) NULL,
	[Contact_Number] [varchar](20) NULL,
	[Address] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestCountAndStatus]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestCountAndStatus](
	[OrderID] [int] NOT NULL,
	[TestID] [int] NOT NULL,
	[Status] [varchar](20) NULL,
	[SampleID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[TestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestFields]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestFields](
	[FieldID] [int] IDENTITY(1,1) NOT NULL,
	[FieldName] [varchar](100) NULL,
	[NormalRange] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[FieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestFieldsBridge]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestFieldsBridge](
	[TestID] [int] NOT NULL,
	[FieldID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TestID] ASC,
	[FieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestOrders]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestOrders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[PrescriptionID] [int] NULL,
	[InvoiceID] [int] NULL,
	[Timestamp] [datetime] NULL,
	[collection_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestRequirements]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestRequirements](
	[RequirementID] [int] IDENTITY(1,1) NOT NULL,
	[TestID] [int] NULL,
	[RequirementName] [varchar](100) NULL,
	[Description] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[RequirementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TotalLabTest]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TotalLabTest](
	[TestID] [int] IDENTITY(1,1) NOT NULL,
	[Testname] [varchar](100) NULL,
	[ProcessingTime] [int] NULL,
	[Cost] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[TestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VitalSigns]    Script Date: 5/15/2024 12:42:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VitalSigns](
	[VitalID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NULL,
	[Temperature] [decimal](5, 2) NULL,
	[BloodPressure] [varchar](20) NULL,
	[HeartRate] [int] NULL,
	[BloodSugar] [decimal](5, 2) NULL,
	[BloodOxygen] [decimal](5, 2) NULL,
	[Timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[VitalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 
GO
INSERT [dbo].[Admin] ([AdminID], [AdminName], [Email], [Password], [Contact], [Role], [Permission]) VALUES (1, N'Arham Raza', N'admin1@example.com', N'adminpassword1', N'0300-1234567', N'Super Admin', N'All Access')
GO
INSERT [dbo].[Admin] ([AdminID], [AdminName], [Email], [Password], [Contact], [Role], [Permission]) VALUES (2, N'Adeel Shariff', N'admin2@example.com', N'adminpassword2', N'0312-9876543', N'Admin', N'Limited Access')
GO
INSERT [dbo].[Admin] ([AdminID], [AdminName], [Email], [Password], [Contact], [Role], [Permission]) VALUES (3, N'Zobia Gul', N'admin3@example.com', N'adminpassword3', N'0345-5556667', N'Admin', N'Limited Access')
GO
INSERT [dbo].[Admin] ([AdminID], [AdminName], [Email], [Password], [Contact], [Role], [Permission]) VALUES (4, N'Mawez Hussain', N'admin4@example.com', N'adminpassword4', N'0321-2345678', N'Admin', N'Limited Access')
GO
INSERT [dbo].[Admin] ([AdminID], [AdminName], [Email], [Password], [Contact], [Role], [Permission]) VALUES (5, N'Hatim Haider', N'admin4@example.com', N'adminpassword4', N'0333-2555676', N'Admin', N'Limited Access')
GO
INSERT [dbo].[Admin] ([AdminID], [AdminName], [Email], [Password], [Contact], [Role], [Permission]) VALUES (6, N'Sohail Abbas', N'admin4@example.com', N'adminpassword4', N'0321-2234128', N'Admin', N'Limited Access')
GO
INSERT [dbo].[Admin] ([AdminID], [AdminName], [Email], [Password], [Contact], [Role], [Permission]) VALUES (7, N'Mahira', N'admin5@example.com', N'adminpassword5', N'0333-7654321', N'Admin', N'Limited Access')
GO
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[Ambulance] ON 
GO
INSERT [dbo].[Ambulance] ([AmbulanceID], [Model], [NumberPlate], [Description], [IsAvailable]) VALUES (6, N'Toyota Hiace', N'LEA-1234', N'Equipped with basic life support systems', 1)
GO
INSERT [dbo].[Ambulance] ([AmbulanceID], [Model], [NumberPlate], [Description], [IsAvailable]) VALUES (7, N'Suzuki Bolan', N'ABC-5678', N'Compact and agile for urban emergencies', 1)
GO
INSERT [dbo].[Ambulance] ([AmbulanceID], [Model], [NumberPlate], [Description], [IsAvailable]) VALUES (8, N'Honda Civic', N'XYZ-9876', N'Fast response vehicle for city use', 0)
GO
INSERT [dbo].[Ambulance] ([AmbulanceID], [Model], [NumberPlate], [Description], [IsAvailable]) VALUES (9, N'Toyota Corolla', N'KLM-5432', N'Spacious and comfortable for patient transport', 1)
GO
INSERT [dbo].[Ambulance] ([AmbulanceID], [Model], [NumberPlate], [Description], [IsAvailable]) VALUES (10, N'Suzuki Cultus', N'QRS-2468', N'Fuel-efficient and reliable', 0)
GO
SET IDENTITY_INSERT [dbo].[Ambulance] OFF
GO
SET IDENTITY_INSERT [dbo].[AmbulanceRequest] ON 
GO
INSERT [dbo].[AmbulanceRequest] ([RequestID], [AmbulanceID], [CallID], [DispatchTime], [ReturnTime]) VALUES (7, 6, 6, CAST(N'2024-03-02T08:15:00.000' AS DateTime), CAST(N'2024-03-02T08:45:00.000' AS DateTime))
GO
INSERT [dbo].[AmbulanceRequest] ([RequestID], [AmbulanceID], [CallID], [DispatchTime], [ReturnTime]) VALUES (8, 7, 7, CAST(N'2024-03-09T09:15:00.000' AS DateTime), CAST(N'2024-03-09T09:45:00.000' AS DateTime))
GO
INSERT [dbo].[AmbulanceRequest] ([RequestID], [AmbulanceID], [CallID], [DispatchTime], [ReturnTime]) VALUES (9, 8, 8, CAST(N'2024-04-22T10:15:00.000' AS DateTime), CAST(N'2024-04-22T10:45:00.000' AS DateTime))
GO
INSERT [dbo].[AmbulanceRequest] ([RequestID], [AmbulanceID], [CallID], [DispatchTime], [ReturnTime]) VALUES (10, 9, 9, CAST(N'2024-05-29T11:15:00.000' AS DateTime), CAST(N'2024-05-29T11:45:00.000' AS DateTime))
GO
INSERT [dbo].[AmbulanceRequest] ([RequestID], [AmbulanceID], [CallID], [DispatchTime], [ReturnTime]) VALUES (11, 10, 10, CAST(N'2024-05-30T12:15:00.000' AS DateTime), CAST(N'2024-05-30T12:45:00.000' AS DateTime))
GO
INSERT [dbo].[AmbulanceRequest] ([RequestID], [AmbulanceID], [CallID], [DispatchTime], [ReturnTime]) VALUES (12, 7, 12, CAST(N'2024-05-14T22:04:53.363' AS DateTime), CAST(N'2024-05-14T22:51:38.710' AS DateTime))
GO
INSERT [dbo].[AmbulanceRequest] ([RequestID], [AmbulanceID], [CallID], [DispatchTime], [ReturnTime]) VALUES (13, 6, 13, CAST(N'2024-05-14T22:58:56.780' AS DateTime), CAST(N'2024-05-14T23:16:48.423' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[AmbulanceRequest] OFF
GO
SET IDENTITY_INSERT [dbo].[Appointment] ON 
GO
INSERT [dbo].[Appointment] ([AppointmentID], [PatientID], [DoctorID], [Date], [Time], [Status]) VALUES (1, 1, 1, CAST(N'2024-03-02' AS Date), CAST(N'10:00:00' AS Time), N'Completed')
GO
INSERT [dbo].[Appointment] ([AppointmentID], [PatientID], [DoctorID], [Date], [Time], [Status]) VALUES (2, 2, 2, CAST(N'2024-03-09' AS Date), CAST(N'11:00:00' AS Time), N'Completed')
GO
INSERT [dbo].[Appointment] ([AppointmentID], [PatientID], [DoctorID], [Date], [Time], [Status]) VALUES (3, 3, 3, CAST(N'2024-04-22' AS Date), CAST(N'12:00:00' AS Time), N'Completed')
GO
INSERT [dbo].[Appointment] ([AppointmentID], [PatientID], [DoctorID], [Date], [Time], [Status]) VALUES (4, 4, 4, CAST(N'2024-05-29' AS Date), CAST(N'13:00:00' AS Time), N'Pending')
GO
INSERT [dbo].[Appointment] ([AppointmentID], [PatientID], [DoctorID], [Date], [Time], [Status]) VALUES (5, 5, 5, CAST(N'2024-05-30' AS Date), CAST(N'14:00:00' AS Time), N'Cancelled')
GO
SET IDENTITY_INSERT [dbo].[Appointment] OFF
GO
SET IDENTITY_INSERT [dbo].[Control] ON 
GO
INSERT [dbo].[Control] ([ActionID], [ActionType], [Description], [Timestamp], [AdminID], [Details]) VALUES (1, N'System Update', N'Installed security patches', CAST(N'2024-05-01T11:00:00.000' AS DateTime), 1, N'All servers updated successfully')
GO
INSERT [dbo].[Control] ([ActionID], [ActionType], [Description], [Timestamp], [AdminID], [Details]) VALUES (2, N'Inventory Management', N'Ordered additional surgical supplies', CAST(N'2024-05-02T10:00:00.000' AS DateTime), 2, N'Supplies to be delivered by end of the week')
GO
INSERT [dbo].[Control] ([ActionID], [ActionType], [Description], [Timestamp], [AdminID], [Details]) VALUES (3, N'Software Upgrade', N'Upgraded patient management software', CAST(N'2024-05-03T09:00:00.000' AS DateTime), 3, N'New features implemented successfully')
GO
INSERT [dbo].[Control] ([ActionID], [ActionType], [Description], [Timestamp], [AdminID], [Details]) VALUES (4, N'Employee Training', N'Conducted training session on patient interaction', CAST(N'2024-05-04T14:00:00.000' AS DateTime), 4, N'Positive feedback received from participants')
GO
INSERT [dbo].[Control] ([ActionID], [ActionType], [Description], [Timestamp], [AdminID], [Details]) VALUES (5, N'Equipment Maintenance', N'Performed routine maintenance on lab equipment', CAST(N'2024-05-05T12:00:00.000' AS DateTime), 5, N'All equipment functioning optimally')
GO
SET IDENTITY_INSERT [dbo].[Control] OFF
GO
SET IDENTITY_INSERT [dbo].[Department] ON 
GO
INSERT [dbo].[Department] ([DeptID], [DeptName], [DeptContact]) VALUES (1, N'Doctor', N'021-1234567')
GO
INSERT [dbo].[Department] ([DeptID], [DeptName], [DeptContact]) VALUES (2, N'Pharmacy', N'021-9876543')
GO
INSERT [dbo].[Department] ([DeptID], [DeptName], [DeptContact]) VALUES (3, N'Laboratory', N'021-2345678')
GO
INSERT [dbo].[Department] ([DeptID], [DeptName], [DeptContact]) VALUES (4, N'Patient', N'021-1234666')
GO
INSERT [dbo].[Department] ([DeptID], [DeptName], [DeptContact]) VALUES (5, N'Appointment', N'021-1244467')
GO
INSERT [dbo].[Department] ([DeptID], [DeptName], [DeptContact]) VALUES (6, N'Emergency', N'021-4534567')
GO
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
INSERT [dbo].[DepartmentHead] ([DeptID], [HOD]) VALUES (1, 1)
GO
INSERT [dbo].[DepartmentHead] ([DeptID], [HOD]) VALUES (2, 11)
GO
SET IDENTITY_INSERT [dbo].[Diagnosis] ON 
GO
INSERT [dbo].[Diagnosis] ([DiagnosisID], [DiagnosisName]) VALUES (1, N'Hypertension')
GO
INSERT [dbo].[Diagnosis] ([DiagnosisID], [DiagnosisName]) VALUES (2, N'Fracture')
GO
INSERT [dbo].[Diagnosis] ([DiagnosisID], [DiagnosisName]) VALUES (3, N'Migraine')
GO
INSERT [dbo].[Diagnosis] ([DiagnosisID], [DiagnosisName]) VALUES (4, N'Leukemia')
GO
INSERT [dbo].[Diagnosis] ([DiagnosisID], [DiagnosisName]) VALUES (5, N'Asthma')
GO
SET IDENTITY_INSERT [dbo].[Diagnosis] OFF
GO
SET IDENTITY_INSERT [dbo].[Doctor] ON 
GO
INSERT [dbo].[Doctor] ([DoctorID], [Specialization], [OPDCharges]) VALUES (1, N'Cardiologist', 2500)
GO
INSERT [dbo].[Doctor] ([DoctorID], [Specialization], [OPDCharges]) VALUES (2, N'Orthopedic Surgeon', 1600)
GO
INSERT [dbo].[Doctor] ([DoctorID], [Specialization], [OPDCharges]) VALUES (3, N'Neurologist', 1550)
GO
INSERT [dbo].[Doctor] ([DoctorID], [Specialization], [OPDCharges]) VALUES (4, N'Oncologist', 1700)
GO
INSERT [dbo].[Doctor] ([DoctorID], [Specialization], [OPDCharges]) VALUES (5, N'Pediatrician', 1450)
GO
INSERT [dbo].[Doctor] ([DoctorID], [Specialization], [OPDCharges]) VALUES (6, N'Gynecologist', 1650)
GO
INSERT [dbo].[Doctor] ([DoctorID], [Specialization], [OPDCharges]) VALUES (7, N'Urologist', 1600)
GO
INSERT [dbo].[Doctor] ([DoctorID], [Specialization], [OPDCharges]) VALUES (8, N'Dermatologist', 1550)
GO
INSERT [dbo].[Doctor] ([DoctorID], [Specialization], [OPDCharges]) VALUES (9, N'ENT Specialist', 1550)
GO
INSERT [dbo].[Doctor] ([DoctorID], [Specialization], [OPDCharges]) VALUES (10, N'Psychiatrist', 1600)
GO
SET IDENTITY_INSERT [dbo].[Doctor] OFF
GO
SET IDENTITY_INSERT [dbo].[DoctorFeeBilling] ON 
GO
INSERT [dbo].[DoctorFeeBilling] ([BillingID], [PatientID], [DoctorID], [AppointmentID], [Date], [TotalAmount]) VALUES (1, 1, 1, 1, CAST(N'2024-03-02' AS Date), CAST(2500.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DoctorFeeBilling] ([BillingID], [PatientID], [DoctorID], [AppointmentID], [Date], [TotalAmount]) VALUES (2, 2, 2, 2, CAST(N'2024-03-09' AS Date), CAST(1600.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[DoctorFeeBilling] ([BillingID], [PatientID], [DoctorID], [AppointmentID], [Date], [TotalAmount]) VALUES (3, 3, 3, 3, CAST(N'2024-04-22' AS Date), CAST(1550.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[DoctorFeeBilling] OFF
GO
SET IDENTITY_INSERT [dbo].[DoctorShift] ON 
GO
INSERT [dbo].[DoctorShift] ([ShiftID], [DoctorID], [StartTime], [EndTime], [Day], [Placement], [RoomNo], [AppointmentsLimit]) VALUES (1, 1, CAST(N'08:00:00' AS Time), CAST(N'15:00:00' AS Time), N'Monday', N'OPD', N'Room 101', 10)
GO
INSERT [dbo].[DoctorShift] ([ShiftID], [DoctorID], [StartTime], [EndTime], [Day], [Placement], [RoomNo], [AppointmentsLimit]) VALUES (2, 2, CAST(N'09:00:00' AS Time), CAST(N'16:00:00' AS Time), N'Tuesday', N'OPD', N'Room 201', 12)
GO
INSERT [dbo].[DoctorShift] ([ShiftID], [DoctorID], [StartTime], [EndTime], [Day], [Placement], [RoomNo], [AppointmentsLimit]) VALUES (3, 3, CAST(N'10:00:00' AS Time), CAST(N'17:00:00' AS Time), N'Wednesday', N'OPD', N'Room 301', 8)
GO
INSERT [dbo].[DoctorShift] ([ShiftID], [DoctorID], [StartTime], [EndTime], [Day], [Placement], [RoomNo], [AppointmentsLimit]) VALUES (4, 4, CAST(N'08:00:00' AS Time), CAST(N'15:00:00' AS Time), N'Thursday', N'OPD', N'Room 401', 10)
GO
INSERT [dbo].[DoctorShift] ([ShiftID], [DoctorID], [StartTime], [EndTime], [Day], [Placement], [RoomNo], [AppointmentsLimit]) VALUES (5, 5, CAST(N'09:00:00' AS Time), CAST(N'16:00:00' AS Time), N'Friday', N'OPD', N'Room 501', 12)
GO
INSERT [dbo].[DoctorShift] ([ShiftID], [DoctorID], [StartTime], [EndTime], [Day], [Placement], [RoomNo], [AppointmentsLimit]) VALUES (6, 6, CAST(N'10:00:00' AS Time), CAST(N'17:00:00' AS Time), N'Saturday', N'ER', N'Room 601', 8)
GO
INSERT [dbo].[DoctorShift] ([ShiftID], [DoctorID], [StartTime], [EndTime], [Day], [Placement], [RoomNo], [AppointmentsLimit]) VALUES (7, 7, CAST(N'08:00:00' AS Time), CAST(N'15:00:00' AS Time), N'Sunday', N'ER', N'Room 701', 10)
GO
INSERT [dbo].[DoctorShift] ([ShiftID], [DoctorID], [StartTime], [EndTime], [Day], [Placement], [RoomNo], [AppointmentsLimit]) VALUES (8, 8, CAST(N'09:00:00' AS Time), CAST(N'16:00:00' AS Time), N'Monday', N'ER', N'Room 801', 12)
GO
INSERT [dbo].[DoctorShift] ([ShiftID], [DoctorID], [StartTime], [EndTime], [Day], [Placement], [RoomNo], [AppointmentsLimit]) VALUES (9, 9, CAST(N'10:00:00' AS Time), CAST(N'17:00:00' AS Time), N'Tuesday', N'ER', N'Room 901', 8)
GO
INSERT [dbo].[DoctorShift] ([ShiftID], [DoctorID], [StartTime], [EndTime], [Day], [Placement], [RoomNo], [AppointmentsLimit]) VALUES (10, 10, CAST(N'08:00:00' AS Time), CAST(N'15:00:00' AS Time), N'Wednesday', N'ER', N'Room 1001', 10)
GO
SET IDENTITY_INSERT [dbo].[DoctorShift] OFF
GO
SET IDENTITY_INSERT [dbo].[EmergencyCall] ON 
GO
INSERT [dbo].[EmergencyCall] ([CallID], [CallerName], [ContactNumber], [Description], [Location], [Timestamp]) VALUES (6, N'Zulfiqar Ali', N'0300-1235628', N'Car accident on Main Street', N'Karachi', CAST(N'2024-03-02T08:00:00.000' AS DateTime))
GO
INSERT [dbo].[EmergencyCall] ([CallID], [CallerName], [ContactNumber], [Description], [Location], [Timestamp]) VALUES (7, N'Ahmed Raza', N'0312-2784650', N'Heart attack symptoms', N'Lahore', CAST(N'2024-03-09T09:00:00.000' AS DateTime))
GO
INSERT [dbo].[EmergencyCall] ([CallID], [CallerName], [ContactNumber], [Description], [Location], [Timestamp]) VALUES (8, N'Sarfaraz Memon', N'0345-7392185', N'Fell down stairs, possible fracture', N'Islamabad', CAST(N'2024-04-22T10:00:00.000' AS DateTime))
GO
INSERT [dbo].[EmergencyCall] ([CallID], [CallerName], [ContactNumber], [Description], [Location], [Timestamp]) VALUES (9, N'Zahra Masood', N'0321-1845388', N'Fainting episode, unknown cause', N'Rawalpindi', CAST(N'2024-05-29T11:00:00.000' AS DateTime))
GO
INSERT [dbo].[EmergencyCall] ([CallID], [CallerName], [ContactNumber], [Description], [Location], [Timestamp]) VALUES (10, N'Taimoor Bashir', N'0333-2743937', N'Breathing difficulties, asthma patient', N'Karachi', CAST(N'2024-05-30T12:00:00.000' AS DateTime))
GO
INSERT [dbo].[EmergencyCall] ([CallID], [CallerName], [ContactNumber], [Description], [Location], [Timestamp]) VALUES (11, N'jamal', N'03461892891', N'Heart attack', N'Millennium mall 2nd floor', CAST(N'2024-05-11T13:06:04.530' AS DateTime))
GO
INSERT [dbo].[EmergencyCall] ([CallID], [CallerName], [ContactNumber], [Description], [Location], [Timestamp]) VALUES (12, N'Akbar Khan', N'0333-3333333', N'Fainting Episode', N'Dolmen Mall, Tariq Road', CAST(N'2024-05-14T22:04:52.973' AS DateTime))
GO
INSERT [dbo].[EmergencyCall] ([CallID], [CallerName], [ContactNumber], [Description], [Location], [Timestamp]) VALUES (13, N'Shakir Abbas', N'0333-3333334', N'Heart Attack', N'Mandi House, Tariq Road', CAST(N'2024-05-14T22:58:56.720' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[EmergencyCall] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (1, N'Ali Khan', CAST(N'1990-03-15' AS Date), N'M', N'0300-1234567', N'House No. 123, Street ABC, Lahore', N'Cardiologist', 1, N'ali@example.com', N'password1', CAST(N'2015-05-10' AS Date), CAST(150000.00 AS Decimal(10, 2)), N'Visiting')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (2, N'Sara Ahmed', CAST(N'1985-06-20' AS Date), N'F', N'0312-9876543', N'Apartment No. 456, Street XYZ, Karachi', N'Orthopedic Surgeon', 1, N'sara@example.com', N'password2', CAST(N'2010-07-20' AS Date), CAST(180000.00 AS Decimal(10, 2)), N'Permanent')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (3, N'Usman Khan', CAST(N'1988-01-10' AS Date), N'M', N'0345-5556667', N'Villa No. 789, Street PQR, Islamabad', N'Neurologist', 1, N'usman@example.com', N'password3', CAST(N'2013-09-05' AS Date), CAST(160000.00 AS Decimal(10, 2)), N'Permanent')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (4, N'Aisha Malik', CAST(N'1992-09-25' AS Date), N'F', N'0321-2345678', N'Flat No. 101, Block XYZ, Lahore', N'Oncologist', 1, N'aisha@example.com', N'password4', CAST(N'2017-11-15' AS Date), CAST(170000.00 AS Decimal(10, 2)), N'Visitng')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (5, N'Ahmed Khan', CAST(N'1980-12-05' AS Date), N'M', N'0333-7654321', N'House No. 456, Street DEF, Karachi', N'Pediatrician', 1, N'ahmed@example.com', N'password5', CAST(N'2005-03-20' AS Date), CAST(140000.00 AS Decimal(10, 2)), N'Visitng')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (6, N'Zara Ali', CAST(N'1995-04-30' AS Date), N'F', N'0344-5678901', N'Apartment No. 789, Street GHI, Islamabad', N'Gynecologist', 1, N'zara@example.com', N'password6', CAST(N'2020-02-10' AS Date), CAST(190000.00 AS Decimal(10, 2)), N'Permanent')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (7, N'Kamran Ahmed', CAST(N'1983-08-12' AS Date), N'M', N'0300-1122334', N'House No. 789, Street JKL, Lahore', N'Urologist', 1, N'kamran@example.com', N'password7', CAST(N'2014-08-30' AS Date), CAST(155000.00 AS Decimal(10, 2)), N'Permanent')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (8, N'Nadia Khan', CAST(N'1993-11-08' AS Date), N'F', N'0312-4455667', N'Flat No. 201, Block MNO, Karachi', N'Dermatologist', 1, N'nadia@example.com', N'password8', CAST(N'2018-06-25' AS Date), CAST(175000.00 AS Decimal(10, 2)), N'Visiting')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (9, N'Faisal Ali', CAST(N'1987-05-18' AS Date), N'M', N'0341-9876543', N'Villa No. 101, Street PQR, Islamabad', N'ENT Specialist', 1, N'faisal@example.com', N'password9', CAST(N'2012-04-15' AS Date), CAST(165000.00 AS Decimal(10, 2)), N'Permanent')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (10, N'Sadia Malik', CAST(N'1986-07-22' AS Date), N'F', N'0320-1234567', N'House No. 201, Street STU, Lahore', N'Psychiatrist', 1, N'sadia@example.com', N'password10', CAST(N'2011-10-10' AS Date), CAST(158000.00 AS Decimal(10, 2)), N'Visiting')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (11, N'Iftikhar Hussain', CAST(N'1984-05-05' AS Date), N'M', N'0300-9876901', N'Flat No. 113, Street RDS, Karachi', N'Pharmicist', 2, N'Iftikhar@example.com', N'password11', CAST(N'2008-03-15' AS Date), CAST(62000.00 AS Decimal(10, 2)), N'Permanent')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (12, N'Sara Ali', CAST(N'1988-08-10' AS Date), N'F', N'0312-3456789', N'Apt. 205, Liberty Plaza, Lahore', N'Pharmicist', 2, N'sara.ali@example.com', N'password22', CAST(N'2010-02-20' AS Date), CAST(60000.00 AS Decimal(10, 2)), N'Permanent')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (13, N'Ahmed Khan', CAST(N'1985-06-25' AS Date), N'M', N'0321-1234567', N'House No. 15, Model Town, Islamabad', N'Pharmicist', 2, N'ahmed.khan@example.com', N'password33', CAST(N'2009-11-10' AS Date), CAST(58000.00 AS Decimal(10, 2)), N'Permanent')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (14, N'Zainab Abbas', CAST(N'1990-03-18' AS Date), N'F', N'0345-6789123', N'Flat No. 45, Gulshan Colony, Karachi', N'Pharmicist', 2, N'zainab.abbas@example.com', N'password44', CAST(N'2012-05-05' AS Date), CAST(62000.00 AS Decimal(10, 2)), N'Permanent')
GO
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (15, N'Ali Raza', CAST(N'1987-11-30' AS Date), N'M', N'0333-4567890', N'Street No. 10, Defence Housing Society, Lahore', N'Pharmicist', 2, N'ali.raza@example.com', N'password55', CAST(N'2011-08-15' AS Date), CAST(59000.00 AS Decimal(10, 2)), N'Permanent')
GO
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[ER_Receptionist] ON 
GO
INSERT [dbo].[ER_Receptionist] ([id], [email], [password]) VALUES (1, N'thing@email.com', N'$2b$10$bjvn4FES9UxVi0gkORc0k.oroWg02ZiUh.XKc5XVy7ld2.rJo1CJq')
GO
INSERT [dbo].[ER_Receptionist] ([id], [email], [password]) VALUES (2, N'thing1@mail.com', N'$2b$10$abUMVQ2ipx9RQik8sqvmYezfcBbxHpeK9DLDdEiew5azbsJe0P0/i')
GO
INSERT [dbo].[ER_Receptionist] ([id], [email], [password]) VALUES (3, N'thing2@mail.com', N'$2b$10$s9rbCmrg3jHvroHbJJ1ww./kOBkyIX6DT6cJ57misbaSkwZhfafuy')
GO
SET IDENTITY_INSERT [dbo].[ER_Receptionist] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 
GO
INSERT [dbo].[Feedback] ([FeedbackID], [AppointmentID], [Rating], [Comments]) VALUES (1, 1, 5, N'Doctor was very knowledgeable and explained everything well.')
GO
INSERT [dbo].[Feedback] ([FeedbackID], [AppointmentID], [Rating], [Comments]) VALUES (2, 2, 4, N'Doctor was friendly and gave good advice for recovery.')
GO
INSERT [dbo].[Feedback] ([FeedbackID], [AppointmentID], [Rating], [Comments]) VALUES (3, 3, 3, N'Appointment was cancelled last minute, inconvenient.')
GO
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[Inventory] ON 
GO
INSERT [dbo].[Inventory] ([InventoryID], [MedicineID], [Quantity]) VALUES (1, 1, 100)
GO
INSERT [dbo].[Inventory] ([InventoryID], [MedicineID], [Quantity]) VALUES (2, 2, 150)
GO
INSERT [dbo].[Inventory] ([InventoryID], [MedicineID], [Quantity]) VALUES (3, 3, 200)
GO
INSERT [dbo].[Inventory] ([InventoryID], [MedicineID], [Quantity]) VALUES (4, 4, 120)
GO
INSERT [dbo].[Inventory] ([InventoryID], [MedicineID], [Quantity]) VALUES (5, 5, 80)
GO
INSERT [dbo].[Inventory] ([InventoryID], [MedicineID], [Quantity]) VALUES (6, 6, 90)
GO
INSERT [dbo].[Inventory] ([InventoryID], [MedicineID], [Quantity]) VALUES (7, 7, 180)
GO
INSERT [dbo].[Inventory] ([InventoryID], [MedicineID], [Quantity]) VALUES (8, 8, 250)
GO
INSERT [dbo].[Inventory] ([InventoryID], [MedicineID], [Quantity]) VALUES (9, 9, 110)
GO
INSERT [dbo].[Inventory] ([InventoryID], [MedicineID], [Quantity]) VALUES (10, 10, 70)
GO
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO
SET IDENTITY_INSERT [dbo].[Issue] ON 
GO
INSERT [dbo].[Issue] ([IssueID], [DeptID], [EmpID], [CreationDate], [Condition], [Category], [Content], [Status], [Remarks], [ResolvedBy], [CompletionDate]) VALUES (5, 1, 1, CAST(N'2024-05-01' AS Date), N'AC not working properly', N'Maintenance', N'AC in the waiting area is not cooling enough', N'Open', NULL, NULL, NULL)
GO
INSERT [dbo].[Issue] ([IssueID], [DeptID], [EmpID], [CreationDate], [Condition], [Category], [Content], [Status], [Remarks], [ResolvedBy], [CompletionDate]) VALUES (6, 2, 11, CAST(N'2024-05-02' AS Date), N'Broken X-ray machine', N'Equipment', N'X-ray machine in Room 301 is not functioning', N'Open', NULL, NULL, NULL)
GO
INSERT [dbo].[Issue] ([IssueID], [DeptID], [EmpID], [CreationDate], [Condition], [Category], [Content], [Status], [Remarks], [ResolvedBy], [CompletionDate]) VALUES (7, 1, 3, CAST(N'2024-05-03' AS Date), N'Need more wheelchairs', N'Supply', N'Running low on wheelchairs in the hospital', N'Open', NULL, NULL, NULL)
GO
INSERT [dbo].[Issue] ([IssueID], [DeptID], [EmpID], [CreationDate], [Condition], [Category], [Content], [Status], [Remarks], [ResolvedBy], [CompletionDate]) VALUES (8, 1, 1, CAST(N'2024-05-04' AS Date), N'Computer virus detected', N'IT', N'Hospital computers are infected with a virus', N'Open', NULL, NULL, NULL)
GO
INSERT [dbo].[Issue] ([IssueID], [DeptID], [EmpID], [CreationDate], [Condition], [Category], [Content], [Status], [Remarks], [ResolvedBy], [CompletionDate]) VALUES (9, 2, 11, CAST(N'2024-05-05' AS Date), N'Power outage in the building', N'Facility', N'Electricity is down in the entire hospital', N'Open', NULL, NULL, NULL)
GO
INSERT [dbo].[Issue] ([IssueID], [DeptID], [EmpID], [CreationDate], [Condition], [Category], [Content], [Status], [Remarks], [ResolvedBy], [CompletionDate]) VALUES (10, 2, 12, CAST(N'2024-05-01' AS Date), N'Equipment malfunction', N'Technical', N'MRI machine not functioning properly', N'Open', NULL, NULL, NULL)
GO
INSERT [dbo].[Issue] ([IssueID], [DeptID], [EmpID], [CreationDate], [Condition], [Category], [Content], [Status], [Remarks], [ResolvedBy], [CompletionDate]) VALUES (11, 1, 2, CAST(N'2024-05-02' AS Date), N'Shortage of surgical supplies', N'Inventory', N'Running low on orthopedic implants', N'Open', NULL, NULL, NULL)
GO
INSERT [dbo].[Issue] ([IssueID], [DeptID], [EmpID], [CreationDate], [Condition], [Category], [Content], [Status], [Remarks], [ResolvedBy], [CompletionDate]) VALUES (12, 2, 14, CAST(N'2024-05-03' AS Date), N'Software bug in patient management system', N'IT', N'Error in generating patient reports', N'Open', NULL, NULL, NULL)
GO
INSERT [dbo].[Issue] ([IssueID], [DeptID], [EmpID], [CreationDate], [Condition], [Category], [Content], [Status], [Remarks], [ResolvedBy], [CompletionDate]) VALUES (13, 2, 12, CAST(N'2024-05-04' AS Date), N'Complaint against staff behavior', N'HR', N'Patient reported rude behavior by a nurse', N'Open', NULL, NULL, NULL)
GO
INSERT [dbo].[Issue] ([IssueID], [DeptID], [EmpID], [CreationDate], [Condition], [Category], [Content], [Status], [Remarks], [ResolvedBy], [CompletionDate]) VALUES (14, 2, 15, CAST(N'2024-05-05' AS Date), N'Lab equipment calibration issue', N'Technical', N'Blood analyzer showing inaccurate results', N'Open', NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Issue] OFF
GO
SET IDENTITY_INSERT [dbo].[LabInvoices] ON 
GO
INSERT [dbo].[LabInvoices] ([InvoiceID], [Timestamp], [Amount]) VALUES (1, CAST(N'2024-03-02T08:00:00.000' AS DateTime), CAST(1200.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[LabInvoices] ([InvoiceID], [Timestamp], [Amount]) VALUES (2, CAST(N'2024-03-09T09:00:00.000' AS DateTime), CAST(1500.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[LabInvoices] ([InvoiceID], [Timestamp], [Amount]) VALUES (3, CAST(N'2024-04-22T10:00:00.000' AS DateTime), CAST(1800.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[LabInvoices] OFF
GO
INSERT [dbo].[LabResults] ([SampleID], [FieldID], [FieldResult], [Timestamp]) VALUES (1, 1, N'14 g/dL', CAST(N'2024-05-05T21:21:22.000' AS DateTime))
GO
INSERT [dbo].[LabResults] ([SampleID], [FieldID], [FieldResult], [Timestamp]) VALUES (2, 2, N'45 U/L', CAST(N'2024-05-05T21:21:22.000' AS DateTime))
GO
INSERT [dbo].[LabResults] ([SampleID], [FieldID], [FieldResult], [Timestamp]) VALUES (3, 3, N'80 bpm', CAST(N'2024-05-05T21:21:22.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Manufacturer] ON 
GO
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName], [Email], [Address], [Contact]) VALUES (1, N'ABC Pharmaceuticals', N'info@abcpharma.com', N'123 Main Street, Lahore', N'042-1234567')
GO
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName], [Email], [Address], [Contact]) VALUES (2, N'XYZ Pharma', N'info@xyzpharma.com', N'456 Park Avenue, Karachi', N'021-9876543')
GO
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName], [Email], [Address], [Contact]) VALUES (3, N'PQR Laboratories', N'info@pqr.com', N'789 Elm Street, Islamabad', N'051-2345678')
GO
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName], [Email], [Address], [Contact]) VALUES (4, N'LMN Medical Supplies', N'info@lmnmed.com', N'101 Oak Road, Lahore', N'042-3456789')
GO
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName], [Email], [Address], [Contact]) VALUES (5, N'GHI Pharmaceuticals', N'info@ghi.com', N'202 Maple Avenue, Karachi', N'021-8765432')
GO
SET IDENTITY_INSERT [dbo].[Manufacturer] OFF
GO
INSERT [dbo].[ManufacturerMedicine] ([ManufacturerID], [MedicineID]) VALUES (1, 1)
GO
INSERT [dbo].[ManufacturerMedicine] ([ManufacturerID], [MedicineID]) VALUES (1, 6)
GO
INSERT [dbo].[ManufacturerMedicine] ([ManufacturerID], [MedicineID]) VALUES (2, 2)
GO
INSERT [dbo].[ManufacturerMedicine] ([ManufacturerID], [MedicineID]) VALUES (2, 7)
GO
INSERT [dbo].[ManufacturerMedicine] ([ManufacturerID], [MedicineID]) VALUES (3, 3)
GO
INSERT [dbo].[ManufacturerMedicine] ([ManufacturerID], [MedicineID]) VALUES (3, 8)
GO
INSERT [dbo].[ManufacturerMedicine] ([ManufacturerID], [MedicineID]) VALUES (4, 4)
GO
INSERT [dbo].[ManufacturerMedicine] ([ManufacturerID], [MedicineID]) VALUES (4, 9)
GO
INSERT [dbo].[ManufacturerMedicine] ([ManufacturerID], [MedicineID]) VALUES (5, 5)
GO
INSERT [dbo].[ManufacturerMedicine] ([ManufacturerID], [MedicineID]) VALUES (5, 10)
GO
SET IDENTITY_INSERT [dbo].[MedBilling] ON 
GO
INSERT [dbo].[MedBilling] ([BillingID], [PrescriptionID], [Date], [TotalAmount], [PaymentMethod]) VALUES (1, 1, CAST(N'2024-03-02' AS Date), CAST(1500.00 AS Decimal(10, 2)), N'Cash')
GO
INSERT [dbo].[MedBilling] ([BillingID], [PrescriptionID], [Date], [TotalAmount], [PaymentMethod]) VALUES (2, 2, CAST(N'2024-03-09' AS Date), CAST(1600.00 AS Decimal(10, 2)), N'Credit Card')
GO
INSERT [dbo].[MedBilling] ([BillingID], [PrescriptionID], [Date], [TotalAmount], [PaymentMethod]) VALUES (3, 3, CAST(N'2024-04-22' AS Date), CAST(1650.00 AS Decimal(10, 2)), N'Cash')
GO
SET IDENTITY_INSERT [dbo].[MedBilling] OFF
GO
SET IDENTITY_INSERT [dbo].[MedicalHistory] ON 
GO
INSERT [dbo].[MedicalHistory] ([MedicalHistoryID], [PatientID], [TreatmentHistory], [Allergies], [PreviousSurgeries], [FamilyHistory]) VALUES (1, 1, N'Underwent bypass surgery in 2018', N'Penicillin', N'Appendectomy in 2005', N'Father had heart disease')
GO
INSERT [dbo].[MedicalHistory] ([MedicalHistoryID], [PatientID], [TreatmentHistory], [Allergies], [PreviousSurgeries], [FamilyHistory]) VALUES (2, 2, N'No significant medical history', N'None', N'None', N'No family history of major illnesses')
GO
INSERT [dbo].[MedicalHistory] ([MedicalHistoryID], [PatientID], [TreatmentHistory], [Allergies], [PreviousSurgeries], [FamilyHistory]) VALUES (3, 3, N'Diagnosed with epilepsy at age 25', N'Sulfa drugs', N'None', N'Mother had diabetes')
GO
SET IDENTITY_INSERT [dbo].[MedicalHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[Medicine] ON 
GO
INSERT [dbo].[Medicine] ([MedicineID], [MedicineName], [ManufacturerID], [Category], [ManufacturingDate], [ExpiryDate], [PricePerUnit]) VALUES (1, N'Aspirin', 1, N'Pain Relief', CAST(N'2023-01-01' AS Date), CAST(N'2024-12-31' AS Date), CAST(50.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Medicine] ([MedicineID], [MedicineName], [ManufacturerID], [Category], [ManufacturingDate], [ExpiryDate], [PricePerUnit]) VALUES (2, N'Amoxicillin', 2, N'Antibiotic', CAST(N'2023-02-15' AS Date), CAST(N'2024-12-15' AS Date), CAST(80.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Medicine] ([MedicineID], [MedicineName], [ManufacturerID], [Category], [ManufacturingDate], [ExpiryDate], [PricePerUnit]) VALUES (3, N'Paracetamol', 3, N'Pain Relief', CAST(N'2023-03-10' AS Date), CAST(N'2024-11-10' AS Date), CAST(40.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Medicine] ([MedicineID], [MedicineName], [ManufacturerID], [Category], [ManufacturingDate], [ExpiryDate], [PricePerUnit]) VALUES (4, N'Ciprofloxacin', 4, N'Antibiotic', CAST(N'2023-04-05' AS Date), CAST(N'2024-10-05' AS Date), CAST(120.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Medicine] ([MedicineID], [MedicineName], [ManufacturerID], [Category], [ManufacturingDate], [ExpiryDate], [PricePerUnit]) VALUES (5, N'Lisinopril', 5, N'Blood Pressure', CAST(N'2023-05-20' AS Date), CAST(N'2024-09-20' AS Date), CAST(70.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Medicine] ([MedicineID], [MedicineName], [ManufacturerID], [Category], [ManufacturingDate], [ExpiryDate], [PricePerUnit]) VALUES (6, N'Atorvastatin', 1, N'Cholesterol', CAST(N'2023-06-30' AS Date), CAST(N'2024-08-30' AS Date), CAST(90.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Medicine] ([MedicineID], [MedicineName], [ManufacturerID], [Category], [ManufacturingDate], [ExpiryDate], [PricePerUnit]) VALUES (7, N'Metformin', 2, N'Diabetes', CAST(N'2023-07-25' AS Date), CAST(N'2024-07-25' AS Date), CAST(60.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Medicine] ([MedicineID], [MedicineName], [ManufacturerID], [Category], [ManufacturingDate], [ExpiryDate], [PricePerUnit]) VALUES (8, N'Omeprazole', 3, N'Acid Reflux', CAST(N'2023-08-15' AS Date), CAST(N'2024-06-15' AS Date), CAST(100.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Medicine] ([MedicineID], [MedicineName], [ManufacturerID], [Category], [ManufacturingDate], [ExpiryDate], [PricePerUnit]) VALUES (9, N'Salbutamol', 4, N'Respiratory', CAST(N'2023-09-10' AS Date), CAST(N'2024-05-10' AS Date), CAST(75.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Medicine] ([MedicineID], [MedicineName], [ManufacturerID], [Category], [ManufacturingDate], [ExpiryDate], [PricePerUnit]) VALUES (10, N'Diazepam', 5, N'Anxiety', CAST(N'2023-10-05' AS Date), CAST(N'2024-04-05' AS Date), CAST(110.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[Medicine] OFF
GO
SET IDENTITY_INSERT [dbo].[MedStock] ON 
GO
INSERT [dbo].[MedStock] ([StockID], [MedicineID], [SupplierID], [PurchaseDate], [Quantity]) VALUES (1, 1, 1, CAST(N'2024-04-01' AS Date), 100)
GO
INSERT [dbo].[MedStock] ([StockID], [MedicineID], [SupplierID], [PurchaseDate], [Quantity]) VALUES (2, 2, 2, CAST(N'2024-04-02' AS Date), 150)
GO
INSERT [dbo].[MedStock] ([StockID], [MedicineID], [SupplierID], [PurchaseDate], [Quantity]) VALUES (3, 3, 3, CAST(N'2024-04-03' AS Date), 200)
GO
INSERT [dbo].[MedStock] ([StockID], [MedicineID], [SupplierID], [PurchaseDate], [Quantity]) VALUES (4, 4, 4, CAST(N'2024-04-08' AS Date), 120)
GO
INSERT [dbo].[MedStock] ([StockID], [MedicineID], [SupplierID], [PurchaseDate], [Quantity]) VALUES (5, 5, 5, CAST(N'2024-04-09' AS Date), 80)
GO
INSERT [dbo].[MedStock] ([StockID], [MedicineID], [SupplierID], [PurchaseDate], [Quantity]) VALUES (6, 6, 1, CAST(N'2024-05-10' AS Date), 90)
GO
INSERT [dbo].[MedStock] ([StockID], [MedicineID], [SupplierID], [PurchaseDate], [Quantity]) VALUES (7, 7, 2, CAST(N'2024-05-21' AS Date), 180)
GO
INSERT [dbo].[MedStock] ([StockID], [MedicineID], [SupplierID], [PurchaseDate], [Quantity]) VALUES (8, 8, 3, CAST(N'2024-05-22' AS Date), 250)
GO
INSERT [dbo].[MedStock] ([StockID], [MedicineID], [SupplierID], [PurchaseDate], [Quantity]) VALUES (9, 9, 4, CAST(N'2024-05-28' AS Date), 110)
GO
INSERT [dbo].[MedStock] ([StockID], [MedicineID], [SupplierID], [PurchaseDate], [Quantity]) VALUES (10, 10, 5, CAST(N'2024-05-29' AS Date), 70)
GO
SET IDENTITY_INSERT [dbo].[MedStock] OFF
GO
SET IDENTITY_INSERT [dbo].[Patient] ON 
GO
INSERT [dbo].[Patient] ([PatientID], [PatientName], [DOB], [Gender], [Contact], [Address], [Email], [Password], [Status]) VALUES (1, N'Ahmed Ali', CAST(N'1982-02-12' AS Date), N'M', N'0300-1234567', N'House No. 123, Street ABC, Lahore', N'ahmed@example.com', N'password1', N'Admitted')
GO
INSERT [dbo].[Patient] ([PatientID], [PatientName], [DOB], [Gender], [Contact], [Address], [Email], [Password], [Status]) VALUES (2, N'Sana Khan', CAST(N'1990-05-20' AS Date), N'F', N'0312-9876543', N'Apartment No. 456, Street XYZ, Karachi', N'sana@example.com', N'password2', N'Visiting')
GO
INSERT [dbo].[Patient] ([PatientID], [PatientName], [DOB], [Gender], [Contact], [Address], [Email], [Password], [Status]) VALUES (3, N'Khalid Mahmood', CAST(N'1975-09-15' AS Date), N'M', N'0345-5556667', N'Villa No. 789, Street PQR, Islamabad', N'khalid@example.com', N'password3', N'Admitted')
GO
INSERT [dbo].[Patient] ([PatientID], [PatientName], [DOB], [Gender], [Contact], [Address], [Email], [Password], [Status]) VALUES (4, N'Farah Aslam', CAST(N'1988-03-08' AS Date), N'F', N'0321-2345678', N'Flat No. 101, Block XYZ, Lahore', N'farah@example.com', N'password4', N'Visiting')
GO
INSERT [dbo].[Patient] ([PatientID], [PatientName], [DOB], [Gender], [Contact], [Address], [Email], [Password], [Status]) VALUES (5, N'Asad Khan', CAST(N'1995-07-30' AS Date), N'M', N'0333-7654321', N'House No. 456, Street DEF, Karachi', N'asad@example.com', N'password5', N'Dead')
GO
INSERT [dbo].[Patient] ([PatientID], [PatientName], [DOB], [Gender], [Contact], [Address], [Email], [Password], [Status]) VALUES (6, N'Zara Khan', CAST(N'1980-10-25' AS Date), N'F', N'0344-5678901', N'Apartment No. 789, Street GHI, Islamabad', N'zara@example.com', N'password6', N'Emergency')
GO
INSERT [dbo].[Patient] ([PatientID], [PatientName], [DOB], [Gender], [Contact], [Address], [Email], [Password], [Status]) VALUES (7, N'Nabeel Ahmed', CAST(N'1987-04-18' AS Date), N'M', N'0300-1122334', N'House No. 789, Street JKL, Lahore', N'nabeel@example.com', N'password7', N'Emergency')
GO
INSERT [dbo].[Patient] ([PatientID], [PatientName], [DOB], [Gender], [Contact], [Address], [Email], [Password], [Status]) VALUES (8, N'Mehak Ali', CAST(N'1993-11-08' AS Date), N'F', N'0312-4455667', N'Flat No. 201, Block MNO, Karachi', N'mehak@example.com', N'password8', N'Emergency')
GO
INSERT [dbo].[Patient] ([PatientID], [PatientName], [DOB], [Gender], [Contact], [Address], [Email], [Password], [Status]) VALUES (9, N'Ali Raza', CAST(N'1986-07-22' AS Date), N'M', N'0320-1234567', N'House No. 201, Street STU, Lahore', N'ali@example.com', N'password9', N'Emergency')
GO
INSERT [dbo].[Patient] ([PatientID], [PatientName], [DOB], [Gender], [Contact], [Address], [Email], [Password], [Status]) VALUES (10, N'Sadia Batool', CAST(N'1991-12-15' AS Date), N'F', N'0333-9876543', N'Apartment No. 301, Street UVW, Islamabad', N'sadia@example.com', N'password10', N'Emergency')
GO
SET IDENTITY_INSERT [dbo].[Patient] OFF
GO
SET IDENTITY_INSERT [dbo].[PatientsInER] ON 
GO
INSERT [dbo].[PatientsInER] ([PatientID], [RequestID], [Status], [Triage], [DoctorID], [Description]) VALUES (6, 7, N'In Treatment', N'Yellow', 1, NULL)
GO
INSERT [dbo].[PatientsInER] ([PatientID], [RequestID], [Status], [Triage], [DoctorID], [Description]) VALUES (7, 8, N'In Treatment', N'Green', 1, NULL)
GO
INSERT [dbo].[PatientsInER] ([PatientID], [RequestID], [Status], [Triage], [DoctorID], [Description]) VALUES (8, 9, N'In Treatment', N'Red', 1, NULL)
GO
INSERT [dbo].[PatientsInER] ([PatientID], [RequestID], [Status], [Triage], [DoctorID], [Description]) VALUES (9, 10, N'In Treatment', N'Yellow', 1, NULL)
GO
INSERT [dbo].[PatientsInER] ([PatientID], [RequestID], [Status], [Triage], [DoctorID], [Description]) VALUES (10, 11, N'In Treatment', N'Red', 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[PatientsInER] OFF
GO
INSERT [dbo].[PatientsInERHistory] ([PatientID], [Timestamp], [Description], [Status], [DoctorID]) VALUES (6, CAST(N'2024-03-02T08:00:00.000' AS DateTime), N'Car accident', N'In Treatment', 1)
GO
INSERT [dbo].[PatientsInERHistory] ([PatientID], [Timestamp], [Description], [Status], [DoctorID]) VALUES (7, CAST(N'2024-03-09T09:00:00.000' AS DateTime), N'Heart attack symptoms', N'In Treatment', 1)
GO
INSERT [dbo].[PatientsInERHistory] ([PatientID], [Timestamp], [Description], [Status], [DoctorID]) VALUES (8, CAST(N'2024-04-22T10:00:00.000' AS DateTime), N'Possible fracture from fall', N'In Treatment', 1)
GO
INSERT [dbo].[PatientsInERHistory] ([PatientID], [Timestamp], [Description], [Status], [DoctorID]) VALUES (9, CAST(N'2024-05-29T11:00:00.000' AS DateTime), N'Fainting episode', N'In Treatment', 1)
GO
INSERT [dbo].[PatientsInERHistory] ([PatientID], [Timestamp], [Description], [Status], [DoctorID]) VALUES (10, CAST(N'2024-05-30T12:00:00.000' AS DateTime), N'Breathing difficulties', N'In Treatment', 1)
GO
INSERT [dbo].[PatientTest] ([PrescriptionID], [TestID]) VALUES (1, 1)
GO
INSERT [dbo].[PatientTest] ([PrescriptionID], [TestID]) VALUES (2, 2)
GO
INSERT [dbo].[PatientTest] ([PrescriptionID], [TestID]) VALUES (3, 3)
GO
INSERT [dbo].[Pharmacist] ([EmpID], [ExperienceLevel]) VALUES (11, N'Senior')
GO
INSERT [dbo].[Pharmacist] ([EmpID], [ExperienceLevel]) VALUES (12, N'Junior')
GO
INSERT [dbo].[Pharmacist] ([EmpID], [ExperienceLevel]) VALUES (13, N'Senior')
GO
INSERT [dbo].[Pharmacist] ([EmpID], [ExperienceLevel]) VALUES (14, N'Junior')
GO
INSERT [dbo].[Pharmacist] ([EmpID], [ExperienceLevel]) VALUES (15, N'Senior')
GO
SET IDENTITY_INSERT [dbo].[Prescription] ON 
GO
INSERT [dbo].[Prescription] ([PrescriptionID], [AppointmentID], [ClinicalNotes], [Status], [Date]) VALUES (1, 1, N'Prescribed medication for hypertension', N'Active', CAST(N'2024-03-02' AS Date))
GO
INSERT [dbo].[Prescription] ([PrescriptionID], [AppointmentID], [ClinicalNotes], [Status], [Date]) VALUES (2, 2, N'Advised rest and follow-up for fracture', N'Active', CAST(N'2024-03-09' AS Date))
GO
INSERT [dbo].[Prescription] ([PrescriptionID], [AppointmentID], [ClinicalNotes], [Status], [Date]) VALUES (3, 3, N'Prescribed medication for migraine relief', N'Active', CAST(N'2024-04-22' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Prescription] OFF
GO
INSERT [dbo].[PrescriptionDiagnosis] ([PrescriptionID], [DiagnosisID], [Date], [Description]) VALUES (1, 1, CAST(N'2024-03-02' AS Date), N'Patient showed symptoms of hypertension')
GO
INSERT [dbo].[PrescriptionDiagnosis] ([PrescriptionID], [DiagnosisID], [Date], [Description]) VALUES (2, 2, CAST(N'2024-03-09' AS Date), N'X-ray confirmed fracture')
GO
INSERT [dbo].[PrescriptionDiagnosis] ([PrescriptionID], [DiagnosisID], [Date], [Description]) VALUES (3, 3, CAST(N'2024-04-22' AS Date), N'Patient history of migraines')
GO
INSERT [dbo].[PrescriptionMedicine] ([PrescriptionID], [MedicineID], [Frequency], [Quantity], [Dosage], [Instructions], [MedicineDuration]) VALUES (1, 1, N'Twice a day', 30, N'500mg', N'Take with water after meals', 30)
GO
INSERT [dbo].[PrescriptionMedicine] ([PrescriptionID], [MedicineID], [Frequency], [Quantity], [Dosage], [Instructions], [MedicineDuration]) VALUES (1, 6, N'Once a day', 30, N'20mg', N'Take before bedtime', 30)
GO
INSERT [dbo].[PrescriptionMedicine] ([PrescriptionID], [MedicineID], [Frequency], [Quantity], [Dosage], [Instructions], [MedicineDuration]) VALUES (2, 2, N'Three times a day', 20, N'250mg', N'Take with food', 20)
GO
INSERT [dbo].[PrescriptionMedicine] ([PrescriptionID], [MedicineID], [Frequency], [Quantity], [Dosage], [Instructions], [MedicineDuration]) VALUES (2, 7, N'Twice a day', 20, N'500mg', N'Take with meals', 20)
GO
INSERT [dbo].[PrescriptionMedicine] ([PrescriptionID], [MedicineID], [Frequency], [Quantity], [Dosage], [Instructions], [MedicineDuration]) VALUES (3, 3, N'Once a day', 15, N'500mg', N'Take on an empty stomach', 15)
GO
INSERT [dbo].[PrescriptionMedicine] ([PrescriptionID], [MedicineID], [Frequency], [Quantity], [Dosage], [Instructions], [MedicineDuration]) VALUES (3, 8, N'Once a day', 15, N'40mg', N'Take 30 minutes before breakfast', 15)
GO
SET IDENTITY_INSERT [dbo].[Report] ON 
GO
INSERT [dbo].[Report] ([ReportID], [ReportName], [Description], [GeneratedBy], [Timestamp], [DeptID]) VALUES (1, N'Patient dept Weekly Status Report', N'Status of patients on each day of selected week of the month', 4, CAST(N'2024-05-01T13:00:00.000' AS DateTime), 4)
GO
INSERT [dbo].[Report] ([ReportID], [ReportName], [Description], [GeneratedBy], [Timestamp], [DeptID]) VALUES (2, N'Monthly Top Diseases', N'top 5 diseases faced by patients in a selected month', 5, CAST(N'2024-05-02T14:00:00.000' AS DateTime), 4)
GO
INSERT [dbo].[Report] ([ReportID], [ReportName], [Description], [GeneratedBy], [Timestamp], [DeptID]) VALUES (3, N'Monthly Status of Patients Treated', N'number of patients with status treated by doctors in a selected month', 2, CAST(N'2024-05-03T15:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[Report] ([ReportID], [ReportName], [Description], [GeneratedBy], [Timestamp], [DeptID]) VALUES (4, N'Doctor dept Weekly Revenue', N'Revenue generated by doctor department of selected month in each week', 3, CAST(N'2024-05-04T16:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[Report] ([ReportID], [ReportName], [Description], [GeneratedBy], [Timestamp], [DeptID]) VALUES (5, N'Weekly Appointment Count', N'Count of appointments of all weeks of month', 5, CAST(N'2024-05-05T17:00:00.000' AS DateTime), 5)
GO
INSERT [dbo].[Report] ([ReportID], [ReportName], [Description], [GeneratedBy], [Timestamp], [DeptID]) VALUES (6, N'Weekly Status of Appointments', N'Status of appointments of each day of selected week of the month', 3, CAST(N'2024-05-04T16:00:00.000' AS DateTime), 5)
GO
INSERT [dbo].[Report] ([ReportID], [ReportName], [Description], [GeneratedBy], [Timestamp], [DeptID]) VALUES (7, N'Weekly Emergency Call Count', N'Count emergency calls for each day of select week of the month', 1, CAST(N'2024-05-04T16:00:00.000' AS DateTime), 6)
GO
SET IDENTITY_INSERT [dbo].[Report] OFF
GO
SET IDENTITY_INSERT [dbo].[Samples] ON 
GO
INSERT [dbo].[Samples] ([SampleID], [OrderID], [SampleShift], [Timestamp], [Volume], [StorageCondition]) VALUES (1, 1, N'Morning', CAST(N'2024-05-05T21:21:22.000' AS DateTime), 5, N'Refrigerated')
GO
INSERT [dbo].[Samples] ([SampleID], [OrderID], [SampleShift], [Timestamp], [Volume], [StorageCondition]) VALUES (2, 2, N'Morning', CAST(N'2024-05-05T21:21:22.000' AS DateTime), 4, N'Room temperature')
GO
INSERT [dbo].[Samples] ([SampleID], [OrderID], [SampleShift], [Timestamp], [Volume], [StorageCondition]) VALUES (3, 3, N'Evening', CAST(N'2024-05-05T21:21:22.000' AS DateTime), 6, N'Refrigerated')
GO
SET IDENTITY_INSERT [dbo].[Samples] OFF
GO
SET IDENTITY_INSERT [dbo].[Supplier] ON 
GO
INSERT [dbo].[Supplier] ([SupplierID], [Supplier_Name], [Contact_Number], [Address]) VALUES (1, N'MediSupply', N'042-9998887', N'789 Market Street, Lahore')
GO
INSERT [dbo].[Supplier] ([SupplierID], [Supplier_Name], [Contact_Number], [Address]) VALUES (2, N'PharmaPlus', N'021-7776665', N'456 Commercial Road, Karachi')
GO
INSERT [dbo].[Supplier] ([SupplierID], [Supplier_Name], [Contact_Number], [Address]) VALUES (3, N'LifeLine Pharma', N'051-8887773', N'101 Business Avenue, Islamabad')
GO
INSERT [dbo].[Supplier] ([SupplierID], [Supplier_Name], [Contact_Number], [Address]) VALUES (4, N'HealthCare Supplies', N'042-6665551', N'202 Medical Plaza, Lahore')
GO
INSERT [dbo].[Supplier] ([SupplierID], [Supplier_Name], [Contact_Number], [Address]) VALUES (5, N'MediCorp', N'021-5554449', N'303 Hospital Road, Karachi')
GO
SET IDENTITY_INSERT [dbo].[Supplier] OFF
GO
INSERT [dbo].[TestCountAndStatus] ([OrderID], [TestID], [Status], [SampleID]) VALUES (1, 1, N'Processing', 1)
GO
INSERT [dbo].[TestCountAndStatus] ([OrderID], [TestID], [Status], [SampleID]) VALUES (2, 2, N'Completed', 2)
GO
INSERT [dbo].[TestCountAndStatus] ([OrderID], [TestID], [Status], [SampleID]) VALUES (3, 3, N'Processing', 3)
GO
SET IDENTITY_INSERT [dbo].[TestFields] ON 
GO
INSERT [dbo].[TestFields] ([FieldID], [FieldName], [NormalRange]) VALUES (1, N'Hemoglobin', N'12-16 g/dL')
GO
INSERT [dbo].[TestFields] ([FieldID], [FieldName], [NormalRange]) VALUES (2, N'ALT (Alanine Aminotransferase)', N'7-56 U/L')
GO
INSERT [dbo].[TestFields] ([FieldID], [FieldName], [NormalRange]) VALUES (3, N'Heart Rate', N'60-100 bpm')
GO
INSERT [dbo].[TestFields] ([FieldID], [FieldName], [NormalRange]) VALUES (4, N'TSH (Thyroid Stimulating Hormone)', N'0.4-4.0 mIU/L')
GO
SET IDENTITY_INSERT [dbo].[TestFields] OFF
GO
INSERT [dbo].[TestFieldsBridge] ([TestID], [FieldID]) VALUES (1, 1)
GO
INSERT [dbo].[TestFieldsBridge] ([TestID], [FieldID]) VALUES (2, 2)
GO
INSERT [dbo].[TestFieldsBridge] ([TestID], [FieldID]) VALUES (3, 3)
GO
INSERT [dbo].[TestFieldsBridge] ([TestID], [FieldID]) VALUES (4, 4)
GO
SET IDENTITY_INSERT [dbo].[TestOrders] ON 
GO
INSERT [dbo].[TestOrders] ([OrderID], [PrescriptionID], [InvoiceID], [Timestamp], [collection_time]) VALUES (1, 1, 1, CAST(N'2024-05-05T21:21:22.000' AS DateTime), CAST(N'10:00:00' AS Time))
GO
INSERT [dbo].[TestOrders] ([OrderID], [PrescriptionID], [InvoiceID], [Timestamp], [collection_time]) VALUES (2, 2, 2, CAST(N'2024-05-05T21:21:22.000' AS DateTime), CAST(N'11:00:00' AS Time))
GO
INSERT [dbo].[TestOrders] ([OrderID], [PrescriptionID], [InvoiceID], [Timestamp], [collection_time]) VALUES (3, 3, 3, CAST(N'2024-05-05T21:21:22.000' AS DateTime), CAST(N'12:00:00' AS Time))
GO
SET IDENTITY_INSERT [dbo].[TestOrders] OFF
GO
SET IDENTITY_INSERT [dbo].[TestRequirements] ON 
GO
INSERT [dbo].[TestRequirements] ([RequirementID], [TestID], [RequirementName], [Description]) VALUES (1, 1, N'Fasting', N'Patient must fast for 8 hours prior to the test')
GO
INSERT [dbo].[TestRequirements] ([RequirementID], [TestID], [RequirementName], [Description]) VALUES (2, 2, N'No special requirements', N'Test can be conducted without any specific preparations')
GO
INSERT [dbo].[TestRequirements] ([RequirementID], [TestID], [RequirementName], [Description]) VALUES (3, 3, N'Resting heart rate', N'Patient should be at rest during the test')
GO
INSERT [dbo].[TestRequirements] ([RequirementID], [TestID], [RequirementName], [Description]) VALUES (4, 4, N'Fasting', N'Patient must fast for 8 hours prior to the test')
GO
SET IDENTITY_INSERT [dbo].[TestRequirements] OFF
GO
SET IDENTITY_INSERT [dbo].[TotalLabTest] ON 
GO
INSERT [dbo].[TotalLabTest] ([TestID], [Testname], [ProcessingTime], [Cost]) VALUES (1, N'Complete Blood Count (CBC)', 1, CAST(300.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TotalLabTest] ([TestID], [Testname], [ProcessingTime], [Cost]) VALUES (2, N'Liver Function Test (LFT)', 2, CAST(500.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TotalLabTest] ([TestID], [Testname], [ProcessingTime], [Cost]) VALUES (3, N'Electrocardiogram (ECG)', 1, CAST(400.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TotalLabTest] ([TestID], [Testname], [ProcessingTime], [Cost]) VALUES (4, N'Thyroid Function Test (TFT)', 2, CAST(600.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[TotalLabTest] ([TestID], [Testname], [ProcessingTime], [Cost]) VALUES (5, N'Blood Glucose Test (BGT)', 1, CAST(200.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[TotalLabTest] OFF
GO
SET IDENTITY_INSERT [dbo].[VitalSigns] ON 
GO
INSERT [dbo].[VitalSigns] ([VitalID], [PatientID], [Temperature], [BloodPressure], [HeartRate], [BloodSugar], [BloodOxygen], [Timestamp]) VALUES (6, 6, CAST(38.50 AS Decimal(5, 2)), N'120/80', 90, CAST(110.00 AS Decimal(5, 2)), CAST(98.00 AS Decimal(5, 2)), CAST(N'2024-03-02T08:30:00.000' AS DateTime))
GO
INSERT [dbo].[VitalSigns] ([VitalID], [PatientID], [Temperature], [BloodPressure], [HeartRate], [BloodSugar], [BloodOxygen], [Timestamp]) VALUES (7, 7, CAST(37.20 AS Decimal(5, 2)), N'130/85', 85, CAST(100.00 AS Decimal(5, 2)), CAST(95.00 AS Decimal(5, 2)), CAST(N'2024-03-09T09:30:00.000' AS DateTime))
GO
INSERT [dbo].[VitalSigns] ([VitalID], [PatientID], [Temperature], [BloodPressure], [HeartRate], [BloodSugar], [BloodOxygen], [Timestamp]) VALUES (8, 8, CAST(36.80 AS Decimal(5, 2)), N'110/70', 95, CAST(90.00 AS Decimal(5, 2)), CAST(97.00 AS Decimal(5, 2)), CAST(N'2024-04-22T10:30:00.000' AS DateTime))
GO
INSERT [dbo].[VitalSigns] ([VitalID], [PatientID], [Temperature], [BloodPressure], [HeartRate], [BloodSugar], [BloodOxygen], [Timestamp]) VALUES (9, 9, CAST(38.00 AS Decimal(5, 2)), N'140/90', 100, CAST(120.00 AS Decimal(5, 2)), CAST(96.00 AS Decimal(5, 2)), CAST(N'2024-05-29T11:30:00.000' AS DateTime))
GO
INSERT [dbo].[VitalSigns] ([VitalID], [PatientID], [Temperature], [BloodPressure], [HeartRate], [BloodSugar], [BloodOxygen], [Timestamp]) VALUES (10, 10, CAST(37.50 AS Decimal(5, 2)), N'125/80', 88, CAST(105.00 AS Decimal(5, 2)), CAST(94.00 AS Decimal(5, 2)), CAST(N'2024-05-30T12:30:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[VitalSigns] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [unique_mail]    Script Date: 5/15/2024 12:42:35 AM ******/
ALTER TABLE [dbo].[ER_Receptionist] ADD  CONSTRAINT [unique_mail] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LabResults] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Samples] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[TestOrders] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[AmbulanceRequest]  WITH CHECK ADD FOREIGN KEY([AmbulanceID])
REFERENCES [dbo].[Ambulance] ([AmbulanceID])
GO
ALTER TABLE [dbo].[AmbulanceRequest]  WITH CHECK ADD FOREIGN KEY([CallID])
REFERENCES [dbo].[EmergencyCall] ([CallID])
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[Control]  WITH CHECK ADD FOREIGN KEY([AdminID])
REFERENCES [dbo].[Admin] ([AdminID])
GO
ALTER TABLE [dbo].[DepartmentHead]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[Department] ([DeptID])
GO
ALTER TABLE [dbo].[DepartmentHead]  WITH CHECK ADD FOREIGN KEY([HOD])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[DoctorFeeBilling]  WITH CHECK ADD FOREIGN KEY([AppointmentID])
REFERENCES [dbo].[Appointment] ([AppointmentID])
GO
ALTER TABLE [dbo].[DoctorFeeBilling]  WITH CHECK ADD FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[DoctorFeeBilling]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[DoctorShift]  WITH CHECK ADD FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[Department] ([DeptID])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([AppointmentID])
REFERENCES [dbo].[Appointment] ([AppointmentID])
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD FOREIGN KEY([MedicineID])
REFERENCES [dbo].[Medicine] ([MedicineID])
GO
ALTER TABLE [dbo].[Issue]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[Department] ([DeptID])
GO
ALTER TABLE [dbo].[Issue]  WITH CHECK ADD FOREIGN KEY([EmpID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Issue]  WITH CHECK ADD FOREIGN KEY([ResolvedBy])
REFERENCES [dbo].[Admin] ([AdminID])
GO
ALTER TABLE [dbo].[LabResults]  WITH CHECK ADD FOREIGN KEY([FieldID])
REFERENCES [dbo].[TestFields] ([FieldID])
GO
ALTER TABLE [dbo].[LabResults]  WITH CHECK ADD FOREIGN KEY([SampleID])
REFERENCES [dbo].[Samples] ([SampleID])
GO
ALTER TABLE [dbo].[ManufacturerMedicine]  WITH CHECK ADD FOREIGN KEY([ManufacturerID])
REFERENCES [dbo].[Manufacturer] ([ManufacturerID])
GO
ALTER TABLE [dbo].[ManufacturerMedicine]  WITH CHECK ADD FOREIGN KEY([MedicineID])
REFERENCES [dbo].[Medicine] ([MedicineID])
GO
ALTER TABLE [dbo].[MedBilling]  WITH CHECK ADD FOREIGN KEY([PrescriptionID])
REFERENCES [dbo].[Prescription] ([PrescriptionID])
GO
ALTER TABLE [dbo].[MedicalHistory]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[Medicine]  WITH CHECK ADD FOREIGN KEY([ManufacturerID])
REFERENCES [dbo].[Manufacturer] ([ManufacturerID])
GO
ALTER TABLE [dbo].[MedStock]  WITH CHECK ADD FOREIGN KEY([MedicineID])
REFERENCES [dbo].[Medicine] ([MedicineID])
GO
ALTER TABLE [dbo].[MedStock]  WITH CHECK ADD FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Supplier] ([SupplierID])
GO
ALTER TABLE [dbo].[PatientsInER]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[PatientsInER]  WITH CHECK ADD FOREIGN KEY([RequestID])
REFERENCES [dbo].[AmbulanceRequest] ([RequestID])
GO
ALTER TABLE [dbo].[PatientsInER]  WITH CHECK ADD  CONSTRAINT [FK_PatientsInER_Doctor] FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Doctor] ([DoctorID])
GO
ALTER TABLE [dbo].[PatientsInER] CHECK CONSTRAINT [FK_PatientsInER_Doctor]
GO
ALTER TABLE [dbo].[PatientTest]  WITH CHECK ADD FOREIGN KEY([PrescriptionID])
REFERENCES [dbo].[Prescription] ([PrescriptionID])
GO
ALTER TABLE [dbo].[PatientTest]  WITH CHECK ADD FOREIGN KEY([TestID])
REFERENCES [dbo].[TotalLabTest] ([TestID])
GO
ALTER TABLE [dbo].[Pharmacist]  WITH CHECK ADD FOREIGN KEY([EmpID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Prescription]  WITH CHECK ADD FOREIGN KEY([AppointmentID])
REFERENCES [dbo].[Appointment] ([AppointmentID])
GO
ALTER TABLE [dbo].[PrescriptionDiagnosis]  WITH CHECK ADD FOREIGN KEY([DiagnosisID])
REFERENCES [dbo].[Diagnosis] ([DiagnosisID])
GO
ALTER TABLE [dbo].[PrescriptionDiagnosis]  WITH CHECK ADD FOREIGN KEY([PrescriptionID])
REFERENCES [dbo].[Prescription] ([PrescriptionID])
GO
ALTER TABLE [dbo].[PrescriptionMedicine]  WITH CHECK ADD FOREIGN KEY([MedicineID])
REFERENCES [dbo].[Medicine] ([MedicineID])
GO
ALTER TABLE [dbo].[PrescriptionMedicine]  WITH CHECK ADD FOREIGN KEY([PrescriptionID])
REFERENCES [dbo].[Prescription] ([PrescriptionID])
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[Department] ([DeptID])
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD FOREIGN KEY([GeneratedBy])
REFERENCES [dbo].[Admin] ([AdminID])
GO
ALTER TABLE [dbo].[Samples]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[TestOrders] ([OrderID])
GO
ALTER TABLE [dbo].[TestCountAndStatus]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[TestOrders] ([OrderID])
GO
ALTER TABLE [dbo].[TestCountAndStatus]  WITH CHECK ADD FOREIGN KEY([SampleID])
REFERENCES [dbo].[Samples] ([SampleID])
GO
ALTER TABLE [dbo].[TestCountAndStatus]  WITH CHECK ADD FOREIGN KEY([TestID])
REFERENCES [dbo].[TotalLabTest] ([TestID])
GO
ALTER TABLE [dbo].[TestFieldsBridge]  WITH CHECK ADD FOREIGN KEY([FieldID])
REFERENCES [dbo].[TestFields] ([FieldID])
GO
ALTER TABLE [dbo].[TestFieldsBridge]  WITH CHECK ADD FOREIGN KEY([TestID])
REFERENCES [dbo].[TotalLabTest] ([TestID])
GO
ALTER TABLE [dbo].[TestOrders]  WITH CHECK ADD FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[LabInvoices] ([InvoiceID])
GO
ALTER TABLE [dbo].[TestOrders]  WITH CHECK ADD FOREIGN KEY([PrescriptionID])
REFERENCES [dbo].[Prescription] ([PrescriptionID])
GO
ALTER TABLE [dbo].[TestRequirements]  WITH CHECK ADD FOREIGN KEY([TestID])
REFERENCES [dbo].[TotalLabTest] ([TestID])
GO
ALTER TABLE [dbo].[VitalSigns]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [dbo].[PatientsInER] ([PatientID])
GO
/****** Object:  StoredProcedure [dbo].[AddDischargedStatusToPatientInERHistory]    Script Date: 5/15/2024 12:42:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddDischargedStatusToPatientInERHistory]
    @PatientID INT,
    @Description NVARCHAR(MAX)
AS
BEGIN
    -- Begin transaction
    BEGIN TRANSACTION;

    -- Check if the patient exists in the PatientsInER table
    IF EXISTS (SELECT 1 FROM PatientsInER WHERE PatientID = @PatientID)
    BEGIN
        -- Insert record into the PatientInERHistory table
        INSERT INTO PatientsInERHistory (PatientID, Timestamp, Description, Status)
        VALUES (@PatientID, GETDATE(), @Description, 'Discharged');

		--Delete patient for PatientInER
		Delete From VitalSigns where PatientID=@PatientID;
		Delete FROM PatientsInER where patientID=@PatientID;

        -- Commit transaction
        COMMIT;
        PRINT 'Status "Discharged" with description added to PatientInERHistory.';
    END
    ELSE
    BEGIN
        -- Rollback transaction if patient does not exist in PatientsInER
        ROLLBACK;
        PRINT 'Patient not found in PatientsInER.';
    END
END;



GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 5/15/2024 12:42:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create Proc [dbo].[AddUser]
@email varchar(250),
@password varchar(max)
AS
Begin
Insert INto ER_Receptionist(email,password) Values(@email,@password);
end
GO
/****** Object:  StoredProcedure [dbo].[EndAmbulanceRequest]    Script Date: 5/15/2024 12:42:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--end the request by adding arrival time and changing ambulance to available
CREATE PROCEDURE [dbo].[EndAmbulanceRequest]
    @RequestID INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CurrentTime DATETIME = GETDATE();

    -- Check if ReturnTime is already not null
    IF NOT EXISTS (
        SELECT 1
        FROM [dbo].[AmbulanceRequest]
        WHERE [RequestID] = @RequestID AND [ReturnTime] IS NOT NULL
    )
    BEGIN
        -- Update AmbulanceRequest table
        UPDATE [dbo].[AmbulanceRequest]
        SET [ReturnTime] = @CurrentTime
        WHERE [RequestID] = @RequestID;

        -- Get AmbulanceID associated with the RequestID
        DECLARE @AmbulanceID INT;
        SELECT @AmbulanceID = [AmbulanceID]
        FROM [dbo].[AmbulanceRequest]
        WHERE [RequestID] = @RequestID;

        -- Update Ambulance table to set availability to true
        UPDATE [dbo].[Ambulance]
        SET [IsAvailable] = 1
        WHERE [AmbulanceID] = @AmbulanceID;
    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertCallerDetails]    Script Date: 5/15/2024 12:42:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCallerDetails]
    @CallerName VARCHAR(255),
    @ContactNumber VARCHAR(20),
    @Description VARCHAR(255),
    @Location VARCHAR(255)
AS
BEGIN
    -- Insert caller details into the EmergencyCall table
    INSERT INTO EmergencyCall (CallerName, ContactNumber, Description, Location, Timestamp) 
    VALUES (@CallerName, @ContactNumber, @Description, @Location,GETDATE())
END;


GO
/****** Object:  StoredProcedure [dbo].[InsertPatient]    Script Date: 5/15/2024 12:42:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[InsertPatient](
    @patientName VARCHAR(255),
    @dob DATE,
    @gender CHAR(1),
    @contact VARCHAR(15),
    @address VARCHAR(255),
    @email VARCHAR(255),
    @password VARCHAR(255)
)
AS
BEGIN
    -- Insert patient data into the Patient table
    INSERT INTO Patient (PatientName, DOB, Gender, Contact, Address, Email, Password)
    VALUES (@patientName, @dob, @gender, @contact, @address, @email, @password);
END;
GO
USE [master]
GO
ALTER DATABASE [HospitalManagementSystem] SET  READ_WRITE 
GO
