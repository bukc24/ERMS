# Emergency Management System

## Getting Started

### Setup

1. First create a file `.env`
2. In the `.env` file write: `DB_SERVER=YOUR_SERVER_NAME` -> Replace `YOUR_SERVER_NAME` with your MSSQL server name
3. Copy the SQL in `HMS.sql` and run it in your MSSQL
4. Run command in project folder: `npm install`

### Run server

1. Run command in project folder: `npm start`

## Issues

1. XXS not handled
2. Server side data validation not done
3. No special case to handle doctors' shift ending
4. No special case to handle 0 ambulances available
5. Registering a patient without admitting them is allowed
6. Must move JWT key to .env


## TODO

1. Medicine request
2. Lab request
