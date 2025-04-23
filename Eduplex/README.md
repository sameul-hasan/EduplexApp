# DIU Kazi Nazrul Islam EduPlex WebApp

A Java-based movie booking web application for DIU Kazi Nazrul Islam EduPlex featuring:
- User & admin roles
- Movie management (admin)
- Booking with email confirmation
- Booking history
- Tailwind CSS for a dynamic, green & blue DIU-themed frontend

**Created by Sameul Hasan, Department of Software Engineering, DIU**

---

## Tech Stack

- **Backend:** Java (Servlets, JSP), DAO Pattern, Maven
- **Frontend:** Tailwind CSS, JSP
- **Database:** MySQL (XAMPP)
- **App Server:** Tomcat
- **Mail:** JavaMail API

---

## Features

- **User Registration/Login** (with validation)
- **Admin Panel:** Add/edit movies with posters and info
- **Movie List & Details**
- **Booking:** Book movie tickets, receive confirmation email
- **Booking History:** Users can view their past bookings
- **DIU branding**: Green & blue color theme, DIU logo

---

## Project Structure

```
diu-eduplex/
├── src/main/java/
│   ├── dao/                  # DAO classes for DB interaction
│   ├── model/                # JavaBeans (User, Movie, Booking)
│   ├── servlet/              # Servlets (controllers)
│   └── util/                 # Utility classes (DB, email)
├── src/main/webapp/
│   ├── WEB-INF/
│   │   └── web.xml           # Servlet configuration
│   ├── assets/
│   │   └── logo.png          # DIU logo
│   ├── css/
│   │   └── tailwind.css      # Tailwind CSS
│   ├── jsp/
│   │   ├── admin/            # Admin JSPs
│   │   ├── user/             # User JSPs
│   │   └── common/           # Header/footer/login/register
│   └── index.jsp
├── pom.xml                   # Maven dependencies
└── README.md
```

---

## Setup Instructions

1. **Clone the repository**
2. **Install dependencies:**  
   ```
   mvn clean install
   ```
3. **Setup MySQL Database:**  
   - Start MySQL (e.g., XAMPP)
   - Import `db/schema.sql`
4. **Configure Database Credentials:**  
   - Edit `src/main/java/util/DBUtil.java` with your DB username and password.
5. **Configure Email SMTP (for booking confirmation):**  
   - Edit `src/main/java/util/MailUtil.java` with your SMTP provider settings (e.g., Gmail).
6. **Build and Deploy WAR:**  
   - Run: `mvn clean package`
   - Copy `target/diu-eduplex.war` to Tomcat's `webapps/` folder.
   - Start Tomcat and visit [http://localhost:8080/diu-eduplex](http://localhost:8080/diu-eduplex)

---

## Logo

Use [this logo](https://images.app.goo.gl/w8LPRyhLx5yTpVfR9) (save as `assets/logo.png`).

---

## Notes

- The UI uses DIU green (`#32CD32`) and blue (`#0072CE`).
- Booking confirmation emails require working SMTP config.
- If you change the WAR name, update the Tomcat URL accordingly.

---

## Author

Sameul Hasan  
Department of Software Engineering, DIU
