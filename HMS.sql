USE [master]
GO
/****** Object:  Database [HospitalManagementSystem]    Script Date: 5/10/2024 12:54:46 AM ******/
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
/****** Object:  Table [dbo].[Patient]    Script Date: 5/10/2024 12:54:46 AM ******/
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
/****** Object:  Table [dbo].[PatientsInER]    Script Date: 5/10/2024 12:54:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientsInER](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[RequestID] [int] NULL,
	[Status] [varchar](50) NULL,
	[Triage] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetPatientsInER]    Script Date: 5/10/2024 12:54:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetPatientsInER]()
RETURNS TABLE
AS
RETURN
(
    SELECT p.PatientID, p.PatientName, p.DOB, p.Gender, p.Contact, p.Address, pe.RequestID, pe.Status, pe.Triage
    FROM PatientsInER pe
    INNER JOIN Patient p ON pe.PatientID = p.PatientID
);
GO
/****** Object:  UserDefinedFunction [dbo].[GetPatientsNotInER]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Admin]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Ambulance]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[AmbulanceRequest]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Appointment]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Control]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Department]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[DepartmentHead]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Diagnosis]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Doctor]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[DoctorFeeBilling]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[DoctorShift]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[EmergencyCall]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Employee]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[ER_Receptionist]    Script Date: 5/10/2024 12:54:47 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [unique_mail] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Inventory]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Issue]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[LabInvoices]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[LabResults]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Manufacturer]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[ManufacturerMedicine]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[MedBilling]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[MedicalHistory]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Medicine]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[MedStock]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[PatientsInERHistory]    Script Date: 5/10/2024 12:54:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientsInERHistory](
	[PatientID] [int] NULL,
	[Timestamp] [datetime] NULL,
	[Description] [varchar](255) NULL,
	[Status] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientTest]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Pharmacist]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Prescription]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[PrescriptionDiagnosis]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[PrescriptionMedicine]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Report]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Samples]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[Supplier]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[TestCountAndStatus]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[TestFields]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[TestFieldsBridge]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[TestOrders]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[TestRequirements]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[TotalLabTest]    Script Date: 5/10/2024 12:54:47 AM ******/
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
/****** Object:  Table [dbo].[VitalSigns]    Script Date: 5/10/2024 12:54:47 AM ******/
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
ALTER TABLE [dbo].[PatientsInERHistory]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [dbo].[PatientsInER] ([PatientID])
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
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 5/10/2024 12:54:47 AM ******/
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
USE [master]
GO
ALTER DATABASE [HospitalManagementSystem] SET  READ_WRITE 
GO
