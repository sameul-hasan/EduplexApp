# DIU Kazi Nazrul Islam EduPlex WebApp

A Java-based movie booking web application for DIU Kazi Nazrul Islam EduPlex featuring:
- User & admin roles
- Movie management (admin)
- Booking with email confirmation
- Booking history
- Tailwind CSS for a dynamic, green & blue DIU-themed frontend

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
2. **Install dependencies:** `mvn clean install`
3. **Setup MySQL DB:** Use XAMPP, import `db/schema.sql`
4. **Configure DB credentials:** `src/main/java/util/DBUtil.java`
5. **Configure email:** `src/main/java/util/MailUtil.java`
6. **Run on Tomcat:** Deploy `war` from Maven or use Tomcat manager

---

## Logo

Use [this logo](https://images.app.goo.gl/w8LPRyhLx5yTpVfR9) (save as `assets/logo.png`).

---

## Note

- The UI uses DIU green (`#32CD32`) and blue (`#0072CE`).
- Booking confirmation emails require SMTP config (e.g., Gmail).

---

## Author

Built for DIU Kazi Nazrul Islam EduPlex